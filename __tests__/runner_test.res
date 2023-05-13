module Promise = Js.Promise2

include Jest.Runner({
  type t<_> = bool
  let affirm = ok => assert ok
})

let () = {
  test("test", () => true)

  Skip.test("test - expect fail", () => false)

  testAsync("testAsync", finish => finish(true))

  Skip.testAsync("testAsync - no done", _ => ())

  Skip.testAsync("testAsync - expect fail", finish => finish(false))

  testAsync("testAsync - timeout ok", ~timeout=1, finish => finish(true))

  Skip.testAsync("testAsync - timeout fail", ~timeout=1, _ => ())

  testPromise("testPromise", () => Promise.resolve(true))

  Skip.testPromise("testPromise - reject", () => Promise.reject(Failure("")))

  Skip.testPromise("testPromise - expect fail", () => Promise.resolve(false))

  testPromise("testPromise - timeout ok", ~timeout=1, () => Promise.resolve(true))

  Skip.testPromise("testPromise - timeout fail", ~timeout=1, () =>
    Promise.make((~resolve as _, ~reject as _) => ())
  )

  testAll("testAll", list{"foo", "bar", "baz"}, input => Js.String.length(input) === 3)
  testAll("testAll - tuples", list{("foo", 3), ("barbaz", 6), ("bananas!", 8)}, ((input, output)) =>
    Js.String.length(input) === output
  )

  testAllPromise("testAllPromise", list{"foo", "bar", "baz"}, input =>
    Promise.resolve(Js.String.length(input) === 3)
  )
  testAllPromise("testAllPromise - tuples", list{("foo", 3), ("barbaz", 6), ("bananas!", 8)}, ((
    input,
    output,
  )) => Promise.resolve(Js.String.length(input) === output))

  describe("describe", () => test("some aspect", () => true))

  describe("beforeAll", () => {
    let x = ref(0)

    beforeAll(() => x := x.contents + 4)

    test("x is 4", () => x.contents === 4)
    test("x is still 4", () => x.contents === 4)
  })

  describe("beforeAllAsync", () => {
    describe("without timeout", () => {
      let x = ref(0)

      beforeAllAsync(
        finish => {
          x := x.contents + 4
          finish()
        },
      )

      test("x is 4", () => x.contents === 4)
      test("x is still 4", () => x.contents === 4)
    })

    describe("with 100ms timeout", () => {
      let x = ref(0)

      beforeAllAsync(
        ~timeout=100,
        finish => {
          x := x.contents + 4
          finish()
        },
      )

      test("x is 4", () => x.contents === 4)
      test("x is still 4", () => x.contents === 4)
    })

    Skip.describe("timeout should fail suite", () => {
      beforeAllAsync(~timeout=1, _ => ())

      test("", () => true) /* runner will crash if there's no tests */
    })
  })

  describe("beforeAllPromise", () => {
    describe("without timeout", () => {
      let x = ref(0)

      beforeAllPromise(
        () => {
          x := x.contents + 4
          Promise.resolve()
        },
      )

      test("x is 4", () => x.contents === 4)
      test("x is still 4", () => x.contents === 4)
    })

    describe("with 100ms timeout", () => {
      let x = ref(0)

      beforeAllPromise(
        ~timeout=100,
        () => {
          x := x.contents + 4
          Promise.resolve()
        },
      )

      test("x is 4", () => x.contents === 4)
      test("x is still 4", () => x.contents === 4)
    })

    Skip.describe("timeout should fail suite", () => {
      beforeAllPromise(~timeout=1, () => Promise.make((~resolve as _, ~reject as _) => ()))

      test("", () => true) /* runner will crash if there's no tests */
    })
  })

  describe("beforeEach", () => {
    let x = ref(0)

    beforeEach(() => x := x.contents + 4)

    test("x is 4", () => x.contents === 4)
    test("x is suddenly 8", () => x.contents === 8)
  })

  describe("beforeEachAsync", () => {
    describe("without timeout", () => {
      let x = ref(0)

      beforeEachAsync(
        finish => {
          x := x.contents + 4
          finish()
        },
      )

      test("x is 4", () => x.contents === 4)
      test("x is suddenly 8", () => x.contents === 8)
    })

    describe("with 100ms timeout", () => {
      let x = ref(0)

      beforeEachAsync(
        ~timeout=100,
        finish => {
          x := x.contents + 4
          finish()
        },
      )

      test("x is 4", () => x.contents === 4)
      test("x is suddenly 8", () => x.contents === 8)
    })

    Skip.describe("timeout should fail suite", () => {
      beforeEachAsync(~timeout=1, _ => ())

      test("", () => true) /* runner will crash if there's no tests */
    })
  })

  describe("beforeEachPromise", () => {
    describe("without timeout", () => {
      let x = ref(0)

      beforeEachPromise(
        () => {
          x := x.contents + 4
          Promise.resolve(true)
        },
      )

      test("x is 4", () => x.contents === 4)
      test("x is suddenly 8", () => x.contents === 8)
    })

    describe("with 100ms timeout", () => {
      let x = ref(0)

      beforeEachPromise(
        ~timeout=100,
        () => {
          x := x.contents + 4
          Promise.resolve(true)
        },
      )

      test("x is 4", () => x.contents === 4)
      test("x is suddenly 8", () => x.contents === 8)
    })

    Skip.describe("timeout should fail suite", () => {
      beforeEachPromise(~timeout=1, () => Promise.make((~resolve as _, ~reject as _) => ()))

      test("", () => true) /* runner will crash if there's no tests */
    })
  })

  describe("afterAll", () => {
    let x = ref(0)

    describe("phase 1", () => {
      afterAll(() => x := x.contents + 4)

      test("x is 0", () => x.contents === 0)
      test("x is still 0", () => x.contents === 0)
    })

    describe("phase 2", () => test("x is suddenly 4", () => x.contents === 4))
  })

  describe("afterAllAsync", () => {
    describe("without timeout", () => {
      let x = ref(0)

      describe(
        "phase 1",
        () => {
          afterAllAsync(
            finish => {
              x := x.contents + 4
              finish()
            },
          )

          test("x is 0", () => x.contents === 0)
          test("x is still 0", () => x.contents === 0)
        },
      )

      describe("phase 2", () => test("x is suddenly 4", () => x.contents === 4))
    })

    describe("with 100ms timeout", () => {
      let x = ref(0)

      describe(
        "phase 1",
        () => {
          afterAllAsync(
            ~timeout=100,
            finish => {
              x := x.contents + 4
              finish()
            },
          )

          test("x is 0", () => x.contents === 0)
          test("x is still 0", () => x.contents === 0)
        },
      )

      describe("phase 2", () => test("x is suddenly 4", () => x.contents === 4))
    })

    Skip.describe("timeout should fail suite", () => {
      afterAllAsync(~timeout=1, _ => ())
      test("", () => true)
    })
  })

  describe("afterAllPromise", () => {
    describe("without timeout", () => {
      let x = ref(0)

      describe(
        "phase 1",
        () => {
          afterAllPromise(
            () => {
              x := x.contents + 4
              Promise.resolve(true)
            },
          )

          test("x is 0", () => x.contents === 0)
          test("x is still 0", () => x.contents === 0)
        },
      )

      describe("phase 2", () => test("x is suddenly 4", () => x.contents === 4))
    })

    describe("with 100ms timeout", () => {
      let x = ref(0)

      describe(
        "phase 1",
        () => {
          afterAllPromise(
            ~timeout=100,
            () => {
              x := x.contents + 4
              Promise.resolve(true)
            },
          )

          test("x is 0", () => x.contents === 0)
          test("x is still 0", () => x.contents === 0)
        },
      )

      describe("phase 2", () => test("x is suddenly 4", () => x.contents === 4))
    })

    Skip.describe("timeout should fail suite", () => {
      afterAllPromise(~timeout=1, () => Promise.make((~resolve as _, ~reject as _) => ()))
      test("", () => true)
    })
  })

  describe("afterEach", () => {
    let x = ref(0)

    afterEach(() => x := x.contents + 4)

    test("x is 0", () => x.contents === 0)
    test("x is suddenly 4", () => x.contents === 4)
  })

  describe("afterEachAsync", () => {
    describe("without timeout", () => {
      let x = ref(0)

      afterEachAsync(
        finish => {
          x := x.contents + 4
          finish()
        },
      )

      test("x is 0", () => x.contents === 0)
      test("x is suddenly 4", () => x.contents === 4)
    })

    describe("with 100ms timeout", () => {
      let x = ref(0)

      afterEachAsync(
        ~timeout=100,
        finish => {
          x := x.contents + 4
          finish()
        },
      )

      test("x is 0", () => x.contents === 0)
      test("x is suddenly 4", () => x.contents === 4)
    })

    Skip.describe("timeout should fail suite", () => {
      afterEachAsync(~timeout=1, _ => ())
      test("", () => true)
    })
  })

  describe("afterEachPromise", () => {
    describe("without timeout", () => {
      let x = ref(0)

      afterEachPromise(
        () => {
          x := x.contents + 4
          Promise.resolve(true)
        },
      )

      test("x is 0", () => x.contents === 0)
      test("x is suddenly 4", () => x.contents === 4)
    })

    describe("with 100ms timeout", () => {
      let x = ref(0)

      afterEachPromise(
        ~timeout=100,
        () => {
          x := x.contents + 4
          Promise.resolve(true)
        },
      )

      test("x is 0", () => x.contents === 0)
      test("x is suddenly 4", () => x.contents === 4)
    })

    Skip.describe("timeout should fail suite", () => {
      afterEachPromise(~timeout=1, () => Promise.make((~resolve as _, ~reject as _) => ()))
      test("", () => true)
    })
  })

  describe("Only", () =>
    /* See runner_only_test.ml */
    ()
  )

  describe("Skip", () => {
    Skip.test("Skip.test", () => false)

    Skip.testAsync("Skip.testAsync", finish => finish(false))
    Skip.testAsync("Skip.testAsync - timeout", ~timeout=1, _ => ())

    Skip.testPromise("Skip.testPromise", () => Promise.resolve(false))
    Skip.testPromise("testPromise - timeout", ~timeout=1, () =>
      Promise.make((~resolve, ~reject as _) => resolve(. false))
    )

    Skip.testAll("testAll", list{"foo", "bar", "baz"}, _ => false)
    Skip.testAll("testAll - tuples", list{("foo", 3), ("barbaz", 6), ("bananas!", 8)}, ((_, _)) =>
      false
    )

    Skip.describe("Skip.describe", () => test("some aspect", () => false))
  })
}
