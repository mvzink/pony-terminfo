use "format"

primitive Percent

primitive SkippingIfThen
primitive SkippingIfElse

type Mode is (None | Percent | SkippingIfThen | SkippingIfElse)

primitive Unpeeked

class Scanner[A: Equatable[A] val] is Iterator[A]
  let _iter: Iterator[A]
  var _peeked: (A | Unpeeked)

  new create(iter: Iterator[A]) =>
    _peeked = Unpeeked
    _iter = iter

  fun ref has_next(): Bool =>
    try
      _peeked as A
      true
    else
      _iter.has_next()
    end

  fun ref next(): A ? =>
    try
      let r = _peeked as A
      _peeked = Unpeeked
      r
    else
      _iter.next()
    end

  fun ref peek(): A ? =>
    try
      _peeked as A
    else
      _peeked = _iter.next()
      _peeked as A
    end

  fun ref scan_to(a: A): Array[A] iso^ ? =>
    recover
      let az = Array[A]
      while has_next() do
        let n = next()
        if n == a then
          break
        else
          az.push(n)
        end
      end
      az
    end

primitive ParseString

  fun _is_digit(i: U8): Bool =>
    (48 <= i) and (i <= 57)

  fun _parse_num(i: U8, sb: Scanner[U8], ps: ParamStack) ? =>
    var prefix: PrefixNumber = PrefixDefault
    var width: USize = 0
    var align: Align = AlignRight
    var fill: U32 = ' '

    var flag = i
    while not _is_digit(flag) or (flag == '0') do
      match flag
      | '#' => error
      | '0' => fill =  '0'
      | '-' => align = AlignLeft
      | ' ' => prefix = PrefixSpace
      | '+' => prefix = PrefixSign
      end
      flag = sb.next()
    end

    let width_str = String
    if _is_digit(flag) then
      width_str.push(flag)
    end
    while _is_digit(sb.peek()) do
      width_str.push(sb.next())
    end
    match width_str.read_int[USize]()
    | (let width': USize, let used: USize) =>
      if used > 0 then
        width = width'
      end
    end
    if sb.peek() == '.' then
      // precision
      error
    end
    let fmt: FormatInt = match sb.next()
    | 'o' => FormatOctalBare
    | 'x' => FormatHexSmallBare
    | 'X' => FormatHexBare
    else
      FormatDefault
    end
    ps.format(fmt, prefix, width, align, fill)

  fun apply(s: String, params: Array[StackObject] val): String iso^ ? =>
    let sb = Scanner[U8](StringBytes(s))
    let ps = ParamStack(params)
    var mode: Mode = None
    for c in sb do
      match mode
      | Percent =>
        match c
        | '%' => ps.push('%')
        | 'c' => ps.print_c()
        | 's' => ps.print_s()
        | 'p' =>
          let n = sb.next() - '0'
          ps.push_i(n)
        | 'P' =>
          let n = sb.next()
          ps.set_var(n)
        | 'g' =>
          let n = sb.next()
          ps.get_var(n)
        | '\'' =>
          let n = sb.next()
          let apostrophe = sb.next()
          if apostrophe != '\'' then error end
          ps.char_const(n)
        | '{' =>
          let ns = String.from_iso_array(sb.scan_to('}'))
          match ns.read_int[I64]()
          | (let i: I64, let l: USize) => ps.int_const(i.u64())
          else
            error
          end
        | 'l' => ps.str_len()
        | '+' => ps.add()
        | '-' => ps.sub()
        | '*' => ps.mul()
        | '/' => ps.div()
        | 'm' => ps.mod()
        | '&' => ps.band()
        | '|' => ps.bor()
        | '^' => ps.bxor()
        | '=' => ps.equal()
        | '>' => ps.greater_than()
        | '<' => ps.less_than()
        | 'A' => ps.land()
        | 'O' => ps.lor()
        | '!' => ps.lnot()
        | '~' => ps.bnot()
        | 'i' => ps.add_i() // still idk wtf
        | 'd' => ps.format(FormatDefault)
        | 'o' => ps.format(FormatOctalBare)
        | 'x' => ps.format(FormatHexSmallBare)
        | 'X' => ps.format(FormatHexBare)
        | ':' => _parse_num(':', sb, ps) // for - and + flags
        | '#' => _parse_num('#', sb, ps)
        | ' ' => _parse_num(' ', sb, ps)
        | '?' => None
        | ';' => None
        | 't' => if not ps.if_then() then mode = SkippingIfThen end
        | 'e' => mode = SkippingIfElse
        | let i: U8 if _is_digit(i) => _parse_num(i, sb, ps)
        else
          error
        end
        if mode is Percent then
          mode = None
        end
      | SkippingIfThen =>
        if c == '%' then
          match sb.next()
            | 'e' => mode = None
            | ';' => mode = None
          end
        end
      | SkippingIfElse =>
        if c == '%' then
          match sb.next()
            | ';' => mode = None
          end
        end
      else
        if c == '%' then
          mode = Percent
        else
          ps.push(c)
        end
      end
    end
    ps.out()
