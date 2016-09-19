use "collections"

primitive _Add
  fun apply(a: U64, b: U64): U64 =>
    a + b

primitive _Sub
  fun apply(a: U64, b: U64): U64 =>
    a - b

primitive _Mul
  fun apply(a: U64, b: U64): U64 =>
    a * b

primitive _Div
  fun apply(a: U64, b: U64): U64 =>
    a / b

primitive _Mod
  fun apply(a: U64, b: U64): U64 =>
    a % b

primitive _BAnd
  fun apply(a: U64, b: U64): U64 =>
    a and b

primitive _BOr
  fun apply(a: U64, b: U64): U64 =>
    a or b

primitive _BXor
  fun apply(a: U64, b: U64): U64 =>
    a xor b

type _BinOp is (_Add | _Sub | _Mul | _Div | _Mod | _BAnd | _BOr | _BXor)

type StackObject is (String | U64 | Bool)

class ParamStack
  """
  A stack for evaluating parameterized terminfo strings.

  In reality, it's a bit more than a stack, since terminfo strings also require
  us to implement:
  * dynamic and static variable-type things
  * character and string formatting (mostly falls to the user)
  * production of a byte array in parallel to the stack

  This class doesn't parse anything, but has operations for all of the parseable
  elements of a terminfo string, and it produces the output byte array as it
  goes.
  """

  let _params: Array[StackObject] val
  let _stack: List[StackObject]
  let _vars: Map[U8, StackObject]
  // XXX TODO this really needs to be an iso or trn that we only pass out
  // destructively/upon dispose
  var _out: String iso

  new create(params': Array[StackObject] val) =>
    _params = params'
    _stack = List[StackObject]()
    _vars = Map[U8, StackObject](26 * 2)
    _out = recover String end

  fun ref out(): String iso^ =>
    let out': String iso = recover String end
    _out = consume out'

  // Client's responsibility.
  fun ref append(s: String) =>
    """
    All the string's non-"format" characters go in here (or `push()`), including
    those formatted by the client through %% and numeric formatting, e.g. (from
    the manual):

    ```
    %% outputs `%'
    ```
    """
    _out.append(s)

  fun ref push(c: U8) =>
    """
    Like `append()`, but for single characters.
    """
    _out.push(c)

  // Stack's responsibility:

  fun ref format(fmt: FormatSettings[FormatInt, PrefixNumber] = FormatDefaultNumber) ? =>
    """
    %[[:]flags][width[.precision]][doxXs]
        as in printf, flags are [-+#] and space. Use a `:' to allow the next
        character to be a `-' flag, avoiding interpreting "%-" as an operator.

    The caller is responsible for parsing the format specification and producing
    an appropriate `FormatSettings`.
    """
    let a = _stack.pop() as U64
    append(a.string(fmt))

  fun ref print_c() ? =>
    """
    %c print pop() like %c in printf
    """
    let a = _stack.pop() as U64
    append(String.from_array(recover val [a.u8()] end))

  fun ref print_s() ? =>
    """
    %s print pop() like %s in printf
    """
    let a = _stack.pop() as String
    append(a)

  fun ref push_i(i: U8) ? =>
    """
    %p[1-9] push i'th parameter
    """
    _stack.push(_params(i.usize() - 1))

  fun ref set_var(c: U8) ? =>
    """
    %P[a-z] set dynamic variable [a-z] to pop()
    %P[A-Z] set static variable [a-z] to pop()
    """
    let a = _stack.pop()
    _vars.insert(c, a)

  fun ref get_var(c: U8) ? =>
    """
    %g[a-z] get dynamic variable [a-z] and push it
    %g[A-Z] get static variable [a-z] and push it
        The terms "static" and "dynamic" are misleading. Historically,
        these are simply two different sets of variables, whose values are
        not reset between calls to tparm. However, that fact is not
        documented in other implementations. Relying on it will adversely
        impact portability to other implementations.
    """
    _stack.push(_vars(c))

  fun ref char_const(c: U8) =>
    """
    %'c' char constant c
    """
    _stack.push(c.u64())

  fun ref int_const(i: U64) =>
    """
    %{nn} integer constant nn
    """
    _stack.push(i)

  fun ref str_len() ? =>
    """
    %l push strlen(pop)
    """
    let s: String = _stack.pop() as String
    _stack.push(s.size().u64())

  fun ref _bin_op(op: _BinOp) ? =>
    let a: U64 = _stack.pop() as U64
    let b: U64 = _stack.pop() as U64
    _stack.push(op(b, a))

  fun ref add() ? =>
    """
    %+ %- %* %/ %m arithmetic (%m is mod): push(pop() op pop())
    """
    _bin_op(_Add)

  fun ref sub() ? =>
    _bin_op(_Sub)

  fun ref mul() ? =>
    _bin_op(_Mul)

  fun ref div() ? =>
    _bin_op(_Div)

  fun ref mod() ? =>
    _bin_op(_Mod)

  fun ref band() ? =>
    """
    %& %| %^ bit operations (AND, OR and exclusive-OR): push(pop() op pop())
    """
    _bin_op(_BAnd)

  fun ref bor() ? =>
    _bin_op(_BOr)

  fun ref bxor() ? =>
    _bin_op(_BXor)

  fun ref land() ? =>
    """
    %A, %O logical AND and OR operations (for conditionals)
    """
    let a = _stack.pop() as Bool
    let b = _stack.pop() as Bool
    _stack.push(a and b)

  fun ref lor() ? =>
    let a = _stack.pop() as Bool
    let b = _stack.pop() as Bool
    _stack.push(a or b)

  fun ref lnot() ? =>
    """
    %! %~ unary operations (logical and bit complement): push(op pop())
    """
    let a = _stack.pop() as Bool
    _stack.push(not a)

  fun ref bnot() ? =>
    let a = _stack.pop() as U64
    _stack.push(not a)

  fun ref equal() ? =>
    """
    %= %> %< logical operations: push(pop() op pop())
    """
    match _stack.pop()
    | let a: String =>
      let b = _stack.pop() as String
      _stack.push(a.eq(b))
    | let a: U64 =>
      let b = _stack.pop() as U64
      _stack.push(a.eq(b))
    | let a: Bool =>
      let b = _stack.pop() as Bool
      _stack.push(a.eq(b))
    end

  fun ref less_than() ? =>
    match _stack.pop()
    | let a: String =>
      let b = _stack.pop() as String
      _stack.push(a.lt(b))
    | let a: U64 =>
      let b = _stack.pop() as U64
      _stack.push(a.lt(b))
    | let a: Bool =>
      let b = _stack.pop() as Bool
      _stack.push(false)
    end

  fun ref greater_than() ? =>
    match _stack.pop()
    | let a: String =>
      let b = _stack.pop() as String
      _stack.push(a.gt(b))
    | let a: U64 =>
      let b = _stack.pop() as U64
      _stack.push(a.gt(b))
    | let a: Bool =>
      let b = _stack.pop() as Bool
      _stack.push(false)
    end

  fun ref add_i() ? =>
    """
    %i add 1 to first two parameters (for ANSI terminals)

    XXX ??? and push them? this is stupid.
    """
    push_i(1)
    push_i(2)
    let a = _stack.pop() as U64
    let b = _stack.pop() as U64
    _stack.push(b + 1)
    _stack.push(a + 1)

  fun ref if_then(): Bool ? =>
    """
    %? expr %t thenpart %e elsepart %;

    TODO rtfm and figure out how this is supposed to work
    XXX seems like the only thing the stack machine needs to do is give back the
    result of the expression; everything else is the caller's responsibility.
    """
    _stack.pop() as Bool
