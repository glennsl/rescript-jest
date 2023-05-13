open Jest

type test_record = {value: string}

let () = {
  describe("Expect", () => {
    open Expect

    test("toBe", () => expect(1 + 2)->toBe(3))
    test("toBeCloseTo", () => expect(1. +. 2.)->toBeCloseTo(3.))
    test("toBeSoCloseTo", () => expect(1. +. 2.123)->toBeSoCloseTo(3.123, ~digits=3))
    test("toBeGreaterThan", () => expect(4)->toBeGreaterThan(3))
    test("toBeGreaterThanOrEqual", () => expect(4)->toBeGreaterThanOrEqual(4))
    test("toBeLessThan", () => expect(4)->toBeLessThan(5))
    test("toBeLessThanOrEqual", () => expect(4)->toBeLessThanOrEqual(4))
    test("toBeSuperSetOf", () => expect(["a", "b", "c"])->toBeSupersetOf(["a", "c"]))
    test("toContain", () => expect(["a", "b", "c"])->toContain("b"))
    test("toContainEqual", () =>
      expect([{value: "a"}, {value: "b"}, {value: "c"}])->toContainEqual({value: "b"})
    )
    test("toContainString", () => expect("banana")->toContainString("nana"))
    test("toHaveLength", () => expect(["a", "b", "c"])->toHaveLength(3))
    test("toEqual", () => expect(1 + 2)->toEqual(3))
    test("toMatch", () => expect("banana")->toMatch("nana"))
    test("toMatchRe", () => expect("banana")->toMatchRe(%re("/ana/")))
    test("toThrow", () => expect(() => assert false)->toThrow)

    test("toMatchInlineSnapshot", () => expect("foo")->toMatchInlineSnapshot("\"foo\""))
    test("toMatchSnapshot", () => expect("foo")->toMatchSnapshot)
    test("toMatchSnapshotWithName", () => expect("foo")->toMatchSnapshotWithName("bar"))
    test("toThrowErrorMatchingSnapshot", () =>
      expect(() => Js.Exn.raiseError("foo error"))->toThrowErrorMatchingSnapshot
    )

    test("not toBe", () => expect(1 + 2)->not_->toBe(4))
    test("not toBeCloseTo", () => expect(1. +. 2.)->not_->toBeCloseTo(3001.))
    test("not toBeSoCloseTo", () => expect(1. +. 2.123)->not_->toBeSoCloseTo(3.124, ~digits=3))
    test("not toBeGreaterThan", () => expect(4)->not_->toBeGreaterThan(4))
    test("not toBeGreaterThanOrEqual", () => expect(4)->not_->toBeGreaterThanOrEqual(5))
    test("not toBeLessThan", () => expect(4)->not_->toBeLessThan(4))
    test("not toBeLessThanOrEqual", () => expect(4)->not_->toBeLessThanOrEqual(3))
    test("not toBeSuperSetOf", () => expect(["a", "b", "c"])->not_->toBeSupersetOf(["a", "d"]))
    test("not toContain", () => expect(["a", "b", "c"])->not_->toContain("d"))
    test("not toContainEqual", () =>
      expect([{value: "a"}, {value: "b"}, {value: "c"}])->not_->toContainEqual({value: "d"})
    )
    test("not toContainString", () => expect("banana")->not_->toContainString("nanan"))
    test("not toHaveLength", () => expect(["a", "b", "c"])->not_->toHaveLength(2))
    test("not toEqual", () => expect(1 + 2)->not_->toEqual(4))
    test("not toMatch", () => expect("banana")->not_->toMatch("nanan"))
    test("not toMatchRe", () => expect("banana")->not_->toMatchRe(%re("/anas/")))
    test("not toThrow", () => expect(() => 2)->not_->toThrow)

    test("expectFn", () => expectFn(raise, Invalid_argument("foo"))->toThrow)
  })

  describe("Expect.Operators", () => {
    open Expect
    open! Expect.Operators

    test("==", () => expect(1 + 2) === 3)
    test(">", () => expect(4) > 3)
    test(">=", () => expect(4) >= 4)
    test("<", () => expect(4) < 5)
    test("<=", () => expect(4) <= 4)
    test("=", () => expect(1 + 2) == 3)
    test("<>", () => expect(1 + 2) != 4)
    test("!=", () => expect(1 + 2) !== 4)
  })

  describe("ExpectJs", () => {
    open ExpectJs

    test("toBeDefined", () => expect(Js.Undefined.return(3))->toBeDefined)
    test("toBeFalsy", () => expect(nan)->toBeFalsy)
    test("toBeNull", () => expect(Js.null)->toBeNull)
    test("toBeTruthy", () => expect([])->toBeTruthy)
    test("toBeUndefined", () => expect(Js.Undefined.empty)->toBeUndefined)
    test("toContainProperties", () =>
      expect({"foo": 0, "bar": true})->toContainProperties(["foo", "bar"])
    )
    test("toMatchObject", () => expect({"a": 1, "b": 2, "c": 3})->toMatchObject({"a": 1, "b": 2}))

    test("not toBeDefined", () => expect(Js.undefined)->not_->toBeDefined)
    test("not toBeFalsy", () => expect([])->not_->toBeFalsy)
    test("not toBeNull", () => expect(Js.Null.return(4))->not_->toBeNull)
    test("not toBeTruthy", () => expect(nan)->not_->toBeTruthy)
    test("not toBeUndefined", () => expect(Js.Undefined.return(4))->not_->toBeUndefined)
    test("not toContainProperties", () =>
      expect({"foo": 0, "bar": true})->not_->toContainProperties(["foo", "zoo"])
    )
    test("not toMatchObject", () =>
      expect({"a": 1, "b": 2, "c": 3})->not_->toMatchObject({"a": 1, "c": 2})
    )
  })
}
