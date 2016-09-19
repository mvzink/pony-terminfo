use "ponytest"
use ".."

actor Main is TestList
  new create(env: Env) =>
    PonyTest(env, this)

  new make() =>
    None

  fun tag tests(test: PonyTest) =>
    test(_TestXtermParsing)
    test(_TestParamStackOps)
    test(_TestParamParseBasics)

class iso _TestXtermParsing is UnitTest
  fun name(): String => "xterm parsing"

  fun apply(h: TestHelper) ? =>
    let db = GetTerminfoDb("/usr/share/terminfo/78/xterm-256color",
                           h.env.root as AmbientAuth) as TerminfoDb
    h.assert_true(db("am") as Bool)
    h.assert_eq[U16](db("cols") as U16, 80)

class iso _TestParamStackOps is UnitTest
  fun name(): String => "parameter stack operations"

  fun apply(h: TestHelper) ? =>
    let parms: Array[StackObject] val = recover ["hello", 42, true, false] end
    let ps = recover iso ParamStack(parms) end
    var expected: String iso = recover String end

    ps.char_const('a')
    ps.int_const(4)
    ps.add()
    ps.print_c()
    expected.push('a' + 4)
    h.assert_eq[String ref](ps.out(), consume expected)
    expected = recover String end

    try
      ps.add()
      h.fail("add() shouldn't work on an empty stack")
    end

    ps.append("f")
    expected.append("f")
    h.assert_eq[String ref](ps.out(), consume expected)
    expected = recover String end

    ps.push_i(1) // "hello"
    ps.print_s()
    expected.append(parms(0) as String)
    h.assert_eq[String ref](ps.out(), consume expected)
    expected = recover String end

    ps.push_i(2) // 42
    ps.set_var('a')
    ps.get_var('a')
    ps.int_const(21)
    ps.sub()
    expected.append("21")
    ps.format(FormatDefaultNumber)
    h.assert_eq[String ref](ps.out(), consume expected)
    expected = recover String end

    ps.char_const('a')
    ps.get_var('a')
    ps.int_const(2)
    ps.div()
    ps.add()
    expected.push('a' + 21)
    ps.print_c()
    h.assert_eq[String ref](ps.out(), consume expected)

    ps.push_i(3) // true
    ps.push_i(4) // false
    ps.lor()
    h.assert_eq[Bool](ps.if_then(), true)

    ps.push_i(4) // false
    ps.push_i(4) // false
    ps.lor()
    h.assert_eq[Bool](ps.if_then(), false)

    ps.push_i(3) // true
    ps.push_i(4) // false
    ps.land()
    h.assert_eq[Bool](ps.if_then(), false)

    ps.push_i(3) // true
    ps.push_i(3) // true
    ps.land()
    h.assert_eq[Bool](ps.if_then(), true)

class iso _TestParamParseBasics is UnitTest
  fun name(): String => "parameter stack operations"

  fun _test(h: TestHelper, test: String, expected: String) ? =>
    let parms: Array[StackObject] val = recover ["hello", 42, true, false] end
    let r = recover val ParseString(test, parms) end
    h.assert_eq[String val](r, expected)

  fun apply(h: TestHelper) ? =>
    // 42 + 32 = 74 -> "J"
    _test(h, "%' '%'*'%+%c", "J")
    // 42 * 2 = 84 -> "T"
    _test(h, "%p2%{2}%*%c", "T")

    _test(h, "%'!'%p1%s%c", "hello!")
    _test(h, "%p2%d", "42")
    _test(h, "%p1%Pa%p1%' '%','%ga%s%c%c%s", "hello, hello")
    _test(h, "%{74}%c", "J")

