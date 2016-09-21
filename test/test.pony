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
    test(_TestCapParseBasics)

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

    ps.push_i(3) // true
    ps.lnot()
    h.assert_eq[Bool](ps.if_then(), false)

class iso _TestCapParseBasics is UnitTest
  fun name(): String => "basic capability string parsing operations"

  fun _test(h: TestHelper, expected: String, test: String) ? =>
    let parms: Array[StackObject] val = recover ["hello", 42, true, false] end
    let r = recover val ParseString(test, parms) end
    h.assert_eq[String val](expected, r)

  fun apply(h: TestHelper) ? =>
    _test(h, "", "")
    _test(h, "hello!", "hello!")

    // 42 + 32 = 74 -> "J"
    _test(h, "J", "%' '%'*'%+%c")
    // 42 * 2 = 84 -> "T"
    _test(h, "T", "%p2%{2}%*%c")

    _test(h, "hello!", "%'!'%p1%s%c")
    _test(h, "42", "%p2%d")
    _test(h, "hello, hello", "%p1%Pa%p1%' '%','%ga%s%c%c%s")
    _test(h, "J", "%{74}%c")

    _test(h, " 75", "%{75}%3d")
    _test(h, "        75", "%{75}%10d")
    _test(h, "        4b", "%{75}%10x")
    _test(h, "-25", "%{75}%{100}%-%d")
    _test(h, "000000004B", "%{75}%010X")
    _test(h, "113       ", "%{75}%:-10o")
    _test(h, "-25", "%{75}%{100}%-% -1d")
    _test(h, "-25 ", "%{75}%{100}%-% -4d")
    _test(h, " 25", "%{25}% -1d")
    _test(h, " 25 ", "%{25}% -4d")
    _test(h, "+25 ", "%{25}%:+-4d")
    _test(h, " 25  ", "%{25}%:+- 5d")

    _test(h, "A", "%?%p2%{42}%=%tA%;")
    _test(h, "B", "%?%p2%{43}%=%tFAIL%;B")
    _test(h, "C", "%?%p2%p2%=%tC%eFAIL%;")
    _test(h, "D", "%?%p2%p2%=%!%tFAIL%eD%;")
    _test(h, "E", "%?%p2%{1}%+%p2%>%tE%eFAIL%;")
    _test(h, "1", "%p2%{1}%+%p2%?%p4%t%+%e%p3%t%-%;%d")
    _test(h, "85", "%p2%{1}%+%p2%?%p3%t%+%e%p4%t%-%;%d")
    _test(h, "3", "%?%p4%t%{1}%e%p4%t%{2}%e%p3%t%{3}%e%{4}%;%d")

