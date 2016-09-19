primitive Percent

primitive If // Then? Else? idk

type Mode is (None | Percent | If)

primitive ParseString
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
        // TODO:
        // %[[:]flags][width[.precision]][doxXs]
        //      as in printf, flags are [-+#] and space.  Use a `:' to allow the next character to be a `-' flag, avoiding interpreting "%-" as an operator.
        // | '?' => mode = If // ok that's not the right way to do this
        else
          error
        end
        mode = None
      else
        if c == '%' then
          mode = Percent
        else
          ps.push(c)
        end
      end
    end
    ps.out()
