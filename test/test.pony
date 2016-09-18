use "ponytest"
use ".."

actor Main is TestList
  new create(env: Env) =>
    PonyTest(env, this)

  new make() =>
    None

  fun tag tests(test: PonyTest) =>
    test(_TestHeaderParsing)
    test(_TestParamStackOps)

class iso _TestHeaderParsing is UnitTest
  fun name(): String => "header parsing"

  fun apply(h: TestHelper) ? =>
    let db = GetTerminfoDb("/usr/share/terminfo/78/xterm-256color",
                           h.env.root as AmbientAuth) as TerminfoDb

    h.assert_true(db("am") as Bool)
    h.assert_eq[U16](db("cols") as U16, 80)

class iso _TestParamStackOps is UnitTest
  fun name(): String => "parameter stack operations"

  fun apply(h: TestHelper) ? =>
    let parms: Array[StackObject] val = recover ["hello", 42, true] end
    let ps = ParamStack(parms)
    let expected: String ref = String

    ps.char_const('a')
    ps.int_const(4)
    ps.add()
    ps.print_c()
    expected.push('a' + 4)
    h.assert_eq[String ref](ps.out, expected)

    try
      ps.add()
      h.fail("add() shouldn't work on an empty stack")
    end

    ps.append("f")
    expected.append("f")
    h.assert_eq[String ref](ps.out, expected)

    ps.push_i(1) // "hello"
    ps.print_s()
    expected.append(parms(0) as String)
    h.assert_eq[String ref](ps.out, expected)

    ps.push_i(2) // 42
    ps.set_var('a')
    ps.get_var('a')
    ps.int_const(21)
    ps.sub()
    expected.append("21")
    ps.format(FormatDefaultNumber)
    h.assert_eq[String ref](ps.out, expected)

    ps.char_const('a')
    ps.get_var('a')
    ps.int_const(2)
    ps.div()
    ps.add()
    expected.push('a' + 21)
    ps.print_c()
    h.assert_eq[String ref](ps.out, expected)

    ps.push_i(3) // true
    ps.push_i(3)
    ps.lor()
    // TODO can't (don't want to) really test these without if/then/else
