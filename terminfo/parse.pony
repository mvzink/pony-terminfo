primitive Percent

primitive SkippingIfThen
primitive SkippingIfElse

type Mode is (None | Percent | SkippingIfThen | SkippingIfElse)

primitive ParseString

  fun _is_digit(i: U8): Bool =>
    (48 <= i) and (i <= 57)

  fun _parse_num(i: U8, sb: StringBytes, ps: ParamStack) ? =>
    let fmt = FormatSettingsInt

    var flag = i
    while not _is_digit(flag) or (flag == '0') do
      match flag
      | '#' => error
      | '0' => fmt.set_fill('0')
      | '-' => fmt.set_align(AlignLeft)
      | ' ' => fmt.set_prefix(PrefixSpace)
      | '+' => fmt.set_prefix(PrefixSign)
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
    | (let width: USize, let used: USize) =>
      if used > 0 then
        fmt.set_width(width)
      end
    end
    if sb.peek() == '.' then
      // precision
      error
    end
    match sb.next()
    | 'd' => ps.format(fmt)
    | 'o' => ps.format(fmt.set_format(FormatOctalBare))
    | 'x' => ps.format(fmt.set_format(FormatHexSmallBare))
    | 'X' => ps.format(fmt.set_format(FormatHexBare))
    end

  fun apply(s: String, params: Array[StackObject] val): String iso^ ? =>
    let sb = StringBytes(s)
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
          let ns = sb.scan_to('}')
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
        | 'd' => ps.format(FormatDefaultNumber)
        | 'o' => ps.format(FormatSettingsInt.set_format(FormatOctalBare))
        | 'x' => ps.format(FormatSettingsInt.set_format(FormatHexSmallBare))
        | 'X' => ps.format(FormatSettingsInt.set_format(FormatHexBare))
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
