include Jest.Runner({
  type t<_> = bool
  let affirm = ok => assert ok
})

let () = {
  Only.test("Only.test", () => true)

  Only.testAsync("Only.testAsync", finish => finish(true))
  Only.testAsync("testAsync - timeout ok", ~timeout=1, finish => finish(true))

  Only.testPromise("Only.testPromise", () => Js.Promise2.resolve(true))
  Only.testPromise("testPromise - timeout ok", ~timeout=1, () => Js.Promise2.resolve(true))

  Only.testAll("testAll", list{"foo", "bar", "baz"}, input => Js.String.length(input) === 3)
  Only.testAll("testAll - tuples", list{("foo", 3), ("barbaz", 6), ("bananas!", 8)}, ((
    input,
    output,
  )) => Js.String.length(input) === output)

  Only.testAllPromise("testAllPromise", list{"foo", "bar", "baz"}, input =>
    Js.Promise2.resolve(Js.String.length(input) === 3)
  )
  Only.testAllPromise(
    "testAllPromise - tuples",
    list{("foo", 3), ("barbaz", 6), ("bananas!", 8)},
    ((input, output)) => Js.Promise2.resolve(Js.String.length(input) === output),
  )

  Only.describe("Only.describe", () => test("some aspect", () => 1 + 2 === 3))
}
