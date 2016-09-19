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
          // ps.int_const(n.read_int())
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
        | 'd' =>
          let fmt = FormatDefaultNumber
          ps.format(fmt)
        | 'o' => ps.format(FormatSettingsInt.set_format(FormatOctalBare))
        | 'x' => ps.format(FormatSettingsInt.set_format(FormatHexSmallBare))
        | 'X' => ps.format(FormatSettingsInt.set_format(FormatHexBare))
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
      // %%   outputs `%'
      // %[[:]flags][width[.precision]][doxXs]
      //      as in printf, flags are [-+#] and space.  Use a `:' to allow the next character to be a `-' flag, avoiding interpreting "%-" as an operator.
      // %c   print pop() like %c in printf
      // %s   print pop() like %s in printf
      // %p[1-9]
      //      push i'th parameter
      // %P[a-z]
      //      set dynamic variable [a-z] to pop()
      // %g[a-z]
      //      get dynamic variable [a-z] and push it
      // %P[A-Z]
      //      set static variable [a-z] to pop()
      // %g[A-Z]
      //      get static variable [a-z] and push it
      // %'c' char constant c
      // %{nn}
      //      integer constant nn
      // %l   push strlen(pop)
      // %+ %- %* %/ %m
      //      arithmetic (%m is mod): push(pop() op pop())
      // %& %| %^
      //      bit operations (AND, OR and exclusive-OR): push(pop() op pop())
      // %= %> %<
      //      logical operations: push(pop() op pop())
      // %A, %O
      //      logical AND and OR operations (for conditionals)
      // %! %~
      //      unary operations (logical and bit complement): push(op pop())
      // %i   add 1 to first two parameters (for ANSI terminals)
      // %? expr %t thenpart %e elsepart %;
