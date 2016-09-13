use "options"
use "collections"
use "files"

class val TerminfoDb
  let _data: Array[U8 val] iso

  new val create(data: Array[U8 val] iso) =>
    _data = consume data

  // fun get_cap(test: String): (None | String) =>

primitive GetTerminfoDb
  """
  """
  fun apply(name: String, filename: String, auth: AmbientAuth):
      (None | TerminfoDb) =>
    try
      let f = OpenFile(FilePath(auth, filename)) as File
      TerminfoDb(f.read(2 << 12)) // biggest i saw on os x was 3402 lol
    else
      None
    end

primitive GetTerminalName
  """
  Get name and terminfo database of current terminal, according to $TERM.
  """
  fun apply(vars: Map[String, String] val): (None | (String, String)) =>
    try
      let term_name = vars("TERM")
      let first_letter = recover val
        let hex_fmt = FormatSettingsInt.set_format(FormatHexBare).set_width(2)
        term_name(0).string(hex_fmt)
      end
      let filename = Path.join(Path.join("/usr/share/terminfo", first_letter),
                              term_name)
      (term_name, filename)
    else
      None
    end

primitive ParseDatabase
  """
  """

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
    | (let name: String, let filename: String) =>
      try
        match GetTerminfoDb(name, filename, env.root as AmbientAuth)
        | None => env.out.print("Couldn't read " + filename)
        | let db: TerminfoDb =>
          env.out.print("Whee, opened " + filename)
        end
      else
        return
      end
    end

    // TODO: read terminfo file
    // TODO: parse terminfo file
    // TODO: output parsed terminfo entry
