open Jest
open ExpectJs

/* TODO: move to BS std lib */
@send external bind: ('a => 'b, 'c, 'a, 'a) => 'b = "bind"
@send external bindThis: ('a => 'b, 'c) => 'a => 'b = "bind"
@send external call: ('a => 'b, 'c, 'a) => 'b = "call"
let call = (self, arg) => call(self, (), arg)
@send external callThis: ('a => 'b, 'c, 'a) => 'b = "call"
@send external call2: (('a, 'b) => 'c, @as(0) _, 'a, 'b) => 'c = "call"

let _ = {
  describe("inferred_fn", _ => {
    test("returns undefined", _ => {
      let mockFn = JestJs.inferred_fn()
      let fn = MockJs.fn(mockFn)

      expect(call(fn, ()))->toBeUndefined
    })

    test("black hole for argument type object", _ => {
      let mockFn = JestJs.inferred_fn()
      let fn = MockJs.fn(mockFn)

      expect(call(fn, {"property": 42}))->toBeUndefined
    })

    test("black hole for argument type string", _ => {
      let mockFn = JestJs.inferred_fn()
      let fn = MockJs.fn(mockFn)

      expect(call(fn, "some string"))->toBeUndefined
    })

    test("calls - records call arguments", _ => {
      let mockFn = JestJs.inferred_fn()
      let fn = MockJs.fn(mockFn)

      let _ = call(fn, "first")
      let _ = call(fn, "second")
      let calls = mockFn->MockJs.calls

      expect(calls)->toEqual(["first", "second"])
    })

    test("instances - sanity check - is empty array", _ => {
      let mockFn = JestJs.inferred_fn()
      let instances = MockJs.instances(mockFn)

      expect(instances)->toEqual([])
    })

    test("instances - records created instances", _ => {
      let mockFn = JestJs.fn(%raw("function (n) { this.n = n; }"))

      mockFn->MockJs.new1(4)->ignore
      mockFn->MockJs.new1(7)->ignore

      let instances = MockJs.instances(mockFn)

      expect(instances)->toEqual([{"n": 4}, {"n": 7}])
    })

    test("mockClear - resets calls", _ => {
      let mockFn = JestJs.inferred_fn()
      let fn = MockJs.fn(mockFn)

      let before = mockFn->MockJs.calls
      let _ = (call(fn, 1), call(fn, 2))
      let inbetween = mockFn->MockJs.calls
      mockFn->MockJs.mockClear
      let after = mockFn->MockJs.calls

      expect((before, inbetween, after))->toEqual(([], [1, 2], []))
    })

    test("mockReset - resets calls", _ => {
      let mockFn = JestJs.inferred_fn()
      let fn = MockJs.fn(mockFn)

      let before = mockFn->MockJs.calls
      let _ = (call(fn, 1), call(fn, 2))
      let inbetween = mockFn->MockJs.calls
      mockFn->MockJs.mockReset
      let after = mockFn->MockJs.calls

      expect((before, inbetween, after))->toEqual(([], [1, 2], []))
    })

    test("mockReset - resets implementations", _ => {
      let mockFn = JestJs.inferred_fn()
      mockFn->MockJs.mockReturnValue(Some(128))->ignore
      let fn = MockJs.fn(mockFn)

      let before = call(fn, ())
      mockFn->MockJs.mockReset
      let after = call(fn, ())

      expect((before, after))->toEqual((Some(128), None))
    })

    test("mockImplementation - sets implementation to use for subsequent invocations", _ => {
      let mockFn = JestJs.inferred_fn()
      let fn = MockJs.fn(mockFn)

      let before = call(fn, 10)
      mockFn->MockJs.mockImplementation(a => Some(Int.toString(a)))->ignore

      expect((before, call(fn, 18), call(fn, 24)))->toEqual((
        None,
        Some("18"),
        Some("24"),
      ))
    })

    test("mockImplementationOnce - queues implementation for one subsequent invocation", _ => {
      let mockFn = JestJs.inferred_fn()
      let fn = MockJs.fn(mockFn)

      let before = call(fn, 10)
      mockFn->MockJs.mockImplementationOnce(a => Some(Int.toString(a)))->ignore
      mockFn
      ->MockJs.mockImplementationOnce(a => Some(Int.toString(a * 2)))
      ->ignore

      expect((before, call(fn, 18), call(fn, 24), call(fn, 12)))->toEqual((
        None,
        Some("18"),
        Some("48"),
        None,
      ))
    })

    test("mockReturnThis - returns `this` on subsequent invocations", _ => {
      let mockFn = JestJs.inferred_fn()
      let this = "this"
      let fn = bindThis(mockFn->MockJs.fn, this)

      let before = call(fn, ())
      mockFn->MockJs.mockReturnThis->ignore

      expect((before, call(fn, ()), call(fn, ())))->toEqual((
        None,
        Some(this),
        Some(this),
      ))
    })

    test("mockReturnValue - returns given value on subsequent invocations", _ => {
      let mockFn = JestJs.inferred_fn()
      let fn = MockJs.fn(mockFn)

      let before = call(fn, 10)
      mockFn->MockJs.mockReturnValue(Some(146))->ignore

      expect((before, call(fn, 18), call(fn, 24)))->toEqual((
        None,
        Some(146),
        Some(146),
      ))
    })

    test("mockReturnValueOnce - queues implementation for one subsequent invocation", _ => {
      let mockFn = JestJs.inferred_fn()
      let fn = MockJs.fn(mockFn)

      let before = call(fn, 10)
      mockFn->MockJs.mockReturnValueOnce(Some(29))->ignore
      mockFn->MockJs.mockReturnValueOnce(Some(41))->ignore

      expect((before, call(fn, 18), call(fn, 24), call(fn, 12)))->toEqual((
        None,
        Some(29),
        Some(41),
        None,
      ))
    })

    /*
  Skip.test "bindThis" (fun _ ->
    let fn = ((fun a -> Int.toString a) [@bs]) in
    let boundFn = bindThis fn "this" in

    expect (call boundFn () 2) -> toEqual "2"
  );
 */

    test("mockClear - resets instances", _ => {
      let mockFn = JestJs.fn(%raw("function (n) { this.n = n; }"))

      let before = mockFn->MockJs.instances

      mockFn->MockJs.new1(4)->ignore
      mockFn->MockJs.new1(7)->ignore

      let inbetween = mockFn->MockJs.instances

      mockFn->MockJs.mockClear

      let after = mockFn->MockJs.instances

      expect((before, inbetween, after))->toEqual(([], [{"n": 4}, {"n": 7}], []))
    })
  })

  describe("fn", _ => {
    test("calls implementation", _ => {
      let mockFn = JestJs.fn(a => Int.toString(a))
      let fn = MockJs.fn(mockFn)

      expect(fn(18))->toBe("18")
    })

    test("calls - records call arguments", _ => {
      let mockFn = JestJs.fn(a => Int.toString(a))

      let _ = MockJs.fn(mockFn)(74)
      let _ = MockJs.fn(mockFn)(89435)
      let calls = mockFn->MockJs.calls

      expect(calls)->toEqual([74, 89435])
    })

    test("mockClear - resets calls", _ => {
      let mockFn = JestJs.fn(a => Int.toString(a))

      let before = mockFn->MockJs.calls
      let _ = (MockJs.fn(mockFn)(1), MockJs.fn(mockFn)(2))
      let inbetween = mockFn->MockJs.calls
      mockFn->MockJs.mockClear
      let after = mockFn->MockJs.calls

      expect((before, inbetween, after))->toEqual(([], [1, 2], []))
    })

    test("mockReset - resets calls", _ => {
      let mockFn = JestJs.fn(a => Int.toString(a))
      let fn = MockJs.fn(mockFn)

      let before = mockFn->MockJs.calls
      let _ = (fn(1), fn(2))
      let inbetween = mockFn->MockJs.calls
      mockFn->MockJs.mockReset
      let after = mockFn->MockJs.calls

      expect((before, inbetween, after))->toEqual(([], [1, 2], []))
    })

    /* TODO: Actually removes the original imlementation too, causing it to return undefined, which usually won't be a valid return value for the function type it mocks */
    Skip.test(
      "mockReset - resets implementations - skipped for now as this removes the original implementation too causing an undefnied to be returned",
      _ => {
        let mockFn = JestJs.fn(a => Int.toString(a))
        mockFn->MockJs.mockReturnValue("128")->ignore
        let fn = MockJs.fn(mockFn)

        let before = fn(0)
        mockFn->MockJs.mockReset
        let after = fn(1)

        expect((before, after))->toEqual(("128", "1"))
      },
    )

    test("mockImplementation - sets implementation to use for subsequent invocations", _ => {
      let mockFn = JestJs.fn(a => Int.toString(a))
      let fn = MockJs.fn(mockFn)

      let before = fn(10)
      mockFn->MockJs.mockImplementation(a => Int.toString(a * 2))->ignore

      expect((before, fn(18), fn(24)))->toEqual(("10", "36", "48"))
    })

    test("mockImplementationOnce - queues implementation for one subsequent invocation", _ => {
      let mockFn = JestJs.fn(a => Int.toString(a))
      let fn = MockJs.fn(mockFn)

      let before = fn(10)
      mockFn->MockJs.mockImplementationOnce(a => Int.toString(a * 3))->ignore
      mockFn->MockJs.mockImplementationOnce(a => Int.toString(a * 2))->ignore

      expect((before, fn(18), fn(24), fn(12)))->toEqual(("10", "54", "48", "12"))
    })

    /* mockReturnThis doesn't make sense for native functions
  test "mockReturnThis - returns `this` on subsequent invocations" (fun _ ->
    let mockFn = JestJs.fn (fun a -> Int.toString a) in
    let this = "this" in
    let fn = bindThis (mockFn -> MockJs.fn) this in

    let before = fn () in
    mockFn -> MockJs.mockReturnThis -> ignore;

    expect
      (before, fn (), fn ())
    -> toEqual
      (None, Some this, Js.Undefined.return this)
  );
 */

    test("mockReturnValue - returns given value on subsequent invocations", _ => {
      let mockFn = JestJs.fn(a => Int.toString(a))
      let fn = MockJs.fn(mockFn)

      let before = fn(10)
      mockFn->MockJs.mockReturnValue("146")->ignore

      expect((before, fn(18), fn(24)))->toEqual(("10", "146", "146"))
    })

    test("mockReturnValueOnce - queues implementation for one subsequent invocation", _ => {
      let mockFn = JestJs.fn(a => Int.toString(a))
      let fn = MockJs.fn(mockFn)

      let before = fn(10)
      mockFn->MockJs.mockReturnValueOnce("29")->ignore
      mockFn->MockJs.mockReturnValueOnce("41")->ignore

      expect((before, fn(18), fn(24), fn(12)))->toEqual(("10", "29", "41", "12"))
    })
  })

  describe("fn2", _ =>
    test("calls implementation", _ => {
      let mockFn = JestJs.fn2((a, b) => Int.toString(a + b))
      let fn = MockJs.fn(mockFn)

      expect(call2(fn, 18, 24))->toBe("42")
    })
  )

  /*
  test "calls - records call arguments" (fun _ ->
    let mockFn = JestJs.fn2 ((fun a b -> Int.toString (a + b)) [@bs]) in

    let _ = MockJs.fn mockFn 18 24 in
    let calls  = mockFn -> MockJs.calls in

    expect calls -> toEqual [| (18, 24) |]
  );
 */

  describe("MockJs.new", _ => {
    test("MockJs.new0", _ => {
      let mockFn = JestJs.fn(%raw("function () { this.n = 42; }"))

      let instance = mockFn->MockJs.new0

      expect(instance)->toEqual({"n": 42})
    })

    test("MockJs.new1", _ => {
      let mockFn = JestJs.fn(%raw("function (n) { this.n = n; }"))

      let instance = mockFn->MockJs.new1(4)

      expect(instance)->toEqual({"n": 4})
    })

    test("MockJs.new2", _ => {
      let mockFn = JestJs.fn2(%raw("function (a, b) { this.n = a * b; }"))

      let instance = mockFn->MockJs.new2(4, 7)

      expect(instance)->toEqual({"n": 28})
    })
  })
}
