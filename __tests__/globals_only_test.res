module Promise = Js.Promise2

open Jest

let () = {
  Only.test("Only.test", () => pass)

  Only.testAsync("Only.testAsync", finish => finish(pass))
  Only.testAsync("testAsync - timeout ok", ~timeout=1, finish => finish(pass))

  Only.testPromise("Only.testPromise", () => Promise.resolve(pass))
  Only.testPromise("testPromise - timeout ok", ~timeout=1, () => Promise.resolve(pass))

  Only.testAll("testAll", list{"foo", "bar", "baz"}, input =>
    if Js.String.length(input) === 3 {
      pass
    } else {
      fail("")
    }
  )
  Only.testAll("testAll - tuples", list{("foo", 3), ("barbaz", 6), ("bananas!", 8)}, ((
    input,
    output,
  )) =>
    if Js.String.length(input) === output {
      pass
    } else {
      fail("")
    }
  )
  Only.testAllPromise("testAllPromise", list{"foo", "bar", "baz"}, input =>
    Promise.resolve(
      if Js.String.length(input) === 3 {
        pass
      } else {
        fail("")
      },
    )
  )
  Only.testAllPromise(
    "testAllPromise - tuples",
    list{("foo", 3), ("barbaz", 6), ("bananas!", 8)},
    ((input, output)) =>
      Promise.resolve(
        if Js.String.length(input) === output {
          pass
        } else {
          fail("")
        },
      ),
  )

  Only.describe("Only.describe", () => test("some aspect", () => pass))
}
