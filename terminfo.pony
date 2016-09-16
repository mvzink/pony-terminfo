use "options"
use "collections"
use "files"
use "buffered"
use "../trie"

type Cap is (Bool | U16 | String)

class val TerminfoDb
  let name: String ref

  let bool_names_short: Array[String val] val
  let bool_names_full: Array[String val] val
  let num_names_short: Array[String val] val
  let num_names_full: Array[String val] val
  let str_names_short: Array[String val] val
  let str_names_full: Array[String val] val

  // the main capability table. holds all the various types of capabilities in
  // one place because i'm lazy.
  let caps: TrieNode[Cap]

  new val create(data: Array[U8 val] val) ? =>
    let rb = Reader
    let header_size: USize = 12
    rb.append(data.trim(0, header_size))

    bool_names_short = BoolNamesShort()
    bool_names_full = BoolNamesFull()
    num_names_short = NumNamesShort()
    num_names_full = NumNamesFull()
    str_names_short = StrNamesShort()
    str_names_full = StrNamesFull()

    caps = TrieNode[Cap]

    match rb.u16_le()
    | 0x11a => None // 0432 in octal; not supported in pony?
    else
      error
    end
    let name_size = rb.u16_le().usize()
    let bool_count = rb.u16_le().usize()
    let num_count = rb.u16_le().usize()
    let str_count = rb.u16_le().usize()
    let str_size = rb.u16_le().usize()
    if name_size < 0 then error
    elseif bool_count < 0 then error
    elseif bool_names_full.size() < bool_count.usize() then error
    elseif num_count < 0 then error
    elseif str_count < 0 then error
    elseif str_size < 0 then error end

    let bool_count_even = if (bool_count % 2) == 0 then
      bool_count
    else
      bool_count + 1
    end
    let non_str_size = header_size + name_size + bool_count_even +
                       (num_count * 2) + (str_count * 2)
    rb.append(data.trim(header_size, non_str_size + 1))

    // the terminal type name is a null-turminated string
    name = String(name_size.usize())
    var n: U8 = rb.u8()
    while n != 0 do
      // if the lengths don't match, who cares; pony's got our back!
      name.push(n)
      n = rb.u8()
    end

    for (i, cap_name_short) in bool_names_short.pairs() do
      if i == bool_count then
        break
      end
      let cap_name_full = bool_names_full(i)
      if rb.u8() != 0 then
        caps.insert(StringBytes(cap_name_short), true)
        caps.insert(StringBytes(cap_name_full), true)
      end
    end

    // get to an even byte boundary
    if ((name_size + bool_count) % 2) != 0 then
      rb.u8()
    end

    for (i, cap_name_short) in num_names_short.pairs() do
      if i == num_count then
        break
      end
      let cap_name_full = num_names_full(i)
      let num = rb.u16_le()
      caps.insert(StringBytes(cap_name_short), num)
      caps.insert(StringBytes(cap_name_full), num)
    end

    let str_offsets = Map[USize, USize]()
    for i in str_names_short.keys() do
      if i == str_count then
        break
      end
      str_offsets.insert(i, rb.u16_le().usize())
    end

    var cnt: USize = 0
    for (i, off) in str_offsets.pairs() do
      if cnt == str_count then
        break
      else
        cnt = cnt + 1
      end
      if (off == 0xffff) or (off == 0xfffe) then
        continue
      end
      var this_str_size: USize = 0
      var ch: U8 = 0
      while true do
        ch = data(non_str_size + off + this_str_size + 1)
        if ch != 0 then
          this_str_size = this_str_size + 1
        else
          break
        end
      end
      let str_array = data.trim(non_str_size + off + 1,
                                non_str_size + off + this_str_size + 1)
      let str = String.from_array(str_array)
      caps.insert(StringBytes(str_names_full(i)), str)
      caps.insert(StringBytes(str_names_short(i)), str)
    end

  fun val apply(cap: String): (None | Cap) =>
    caps(StringBytes(cap))

primitive GetTerminfoDb
  """
  Read the compiled terminfo database located at the given path. Returns None on
  errors, including parse errors.
  """
  fun apply(filename: String, auth: AmbientAuth):
      (None | TerminfoDb) =>
    try
      let f = OpenFile(FilePath(auth, filename)) as File
      // biggest i saw on os x was 3402 lol
      TerminfoDb(f.read(2 << 12))
    else
      None
    end

primitive GetTerminalName
  """
  Get name and terminfo database of current terminal, according to $TERM.
  """
  fun apply(vars: Map[String, String] val): (None | String) =>
    try
      let term_name = vars("TERM")
      let first_letter = recover val
        let hex_fmt = FormatSettingsInt.set_format(FormatHexBare).set_width(2)
        term_name(0).string(hex_fmt)
      end
      let filename = Path.join(Path.join("/usr/share/terminfo", first_letter),
                              term_name)
      filename
    else
      None
    end

actor Main
  new create(env: Env) =>
    // let filepath = FilePath(env.root as AmbientAuth, filename)
    // match OpenFile(filepath)
    // | let f: File => f
    // end
    let env_vars = EnvVars(env.vars())
    match GetTerminalName(env_vars)
    | None =>
      env.out.print("Couldn't determine terminal type."
      " $TERM is empty or database is unparsable.")
    | let filename: String =>
      try
        match GetTerminfoDb(filename, env.root as AmbientAuth)
        | None =>
          env.out.print("Couldn't read " + filename)
        | let db: TerminfoDb =>
          env.out.print("Whee, opened " + filename)
          env.out.print("name = " + db.name)
          env.out.print("")
          let bool_names_full = BoolNamesFull()
          for (i, cap_name) in BoolNamesShort().pairs() do
            env.out.print(bool_names_full(i)+" ("+cap_name+") = "+db(cap_name).string())
          end

          env.out.write("\t")
          for (i, cap_name) in BoolNamesShort().pairs() do
            match db(cap_name)
            | true => env.out.write(cap_name + ", ")
            end
          end

          env.out.print("\n")
          let num_names_full = NumNamesFull()
          for (i, cap_name) in NumNamesShort().pairs() do
            env.out.print(num_names_full(i)+" ("+cap_name+") = "+db(cap_name).string())
          end

          env.out.print("")
          for k in db.str_names_full.values() do
            match db(k)
            | let u: String => env.out.print(k + ": " + u.size().string())
            end
          end

          env.out.print("")
          try
            let s = db(env.args(1)) as String
            env.out.print(env.args(1) + ": " + s.size().string())
          else
            env.out.print("shit")
          end
        end
      else
        env.out.print("Couldn't parse terminfo database.")
      end
    end

    // TODO: parse terminfo file
    // TODO: output parsed terminfo entry
