module Promise = Js.Promise2

open Jest

let () = {
  test("pass", () => pass)

  Skip.test("fail", () => fail(""))

  test("test", () => pass)

  Skip.test("test - expect fail", () => fail(""))

  testAsync("testAsync", finish => finish(pass))

  Skip.testAsync("testAsync - no done", _ => ())

  Skip.testAsync("testAsync - expect fail", finish => finish(fail("")))

  testAsync("testAsync - timeout ok", ~timeout=1, finish => finish(pass))

  Skip.testAsync("testAsync - timeout fail", ~timeout=1, _ => ())

  testPromise("testPromise", () => Promise.resolve(pass))

  Skip.testPromise("testPromise - reject", () => Promise.reject(Failure("")))

  Skip.testPromise("testPromise - expect fail", () => Promise.resolve(fail("")))

  testPromise("testPromise - timeout ok", ~timeout=1, () => Promise.resolve(pass))

  Skip.testPromise("testPromise - timeout fail", ~timeout=1, () =>
    Promise.make((~resolve as _, ~reject as _) => ())
  )

  testAll("testAll", list{"foo", "bar", "baz"}, input =>
    if Js.String.length(input) === 3 {
      pass
    } else {
      fail("")
    }
  )
  testAll("testAll - tuples", list{("foo", 3), ("barbaz", 6), ("bananas!", 8)}, ((input, output)) =>
    if Js.String.length(input) === output {
      pass
    } else {
      fail("")
    }
  )

  testAllPromise("testAllPromise", list{"foo", "bar", "baz"}, input =>
    Promise.resolve(
      if Js.String.length(input) === 3 {
        pass
      } else {
        fail("")
      },
    )
  )
  testAllPromise("testAllPromise - tuples", list{("foo", 3), ("barbaz", 6), ("bananas!", 8)}, ((
    input,
    output,
  )) =>
    Promise.resolve(
      if Js.String.length(input) === output {
        pass
      } else {
        fail("")
      },
    )
  )

  describe("describe", () => test("some aspect", () => pass))

  describe("beforeAll", () => {
    let x = ref(0)

    beforeAll(() => x := x.contents + 4)

    test("x is 4", () =>
      if x.contents === 4 {
        pass
      } else {
        fail("")
      }
    )
    test("x is still 4", () =>
      if x.contents === 4 {
        pass
      } else {
        fail("")
      }
    )
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

      test(
        "x is 4",
        () =>
          if x.contents === 4 {
            pass
          } else {
            fail("")
          },
      )
      test(
        "x is still 4",
        () =>
          if x.contents === 4 {
            pass
          } else {
            fail("")
          },
      )
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

      test(
        "x is 4",
        () =>
          if x.contents === 4 {
            pass
          } else {
            fail("")
          },
      )
      test(
        "x is still 4",
        () =>
          if x.contents === 4 {
            pass
          } else {
            fail("")
          },
      )
    })

    Skip.describe("timeout should fail suite", () => {
      beforeAllAsync(~timeout=1, _ => ())
      test("", () => pass) /* runner will crash if there's no tests */
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

      test(
        "x is 4",
        () =>
          if x.contents === 4 {
            pass
          } else {
            fail("")
          },
      )
      test(
        "x is still 4",
        () =>
          if x.contents === 4 {
            pass
          } else {
            fail("")
          },
      )
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

      test(
        "x is 4",
        () =>
          if x.contents === 4 {
            pass
          } else {
            fail("")
          },
      )
      test(
        "x is still 4",
        () =>
          if x.contents === 4 {
            pass
          } else {
            fail("")
          },
      )
    })

    Skip.describe("timeout should fail suite", () => {
      beforeAllPromise(~timeout=1, () => Promise.make((~resolve as _, ~reject as _) => ()))
      test("", () => pass) /* runner will crash if there's no tests */
    })
  })

  describe("beforeEach", () => {
    let x = ref(0)

    beforeEach(() => x := x.contents + 4)

    test("x is 4", () =>
      if x.contents === 4 {
        pass
      } else {
        fail("")
      }
    )
    test("x is suddenly 8", () =>
      if x.contents === 8 {
        pass
      } else {
        fail("")
      }
    )
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

      test(
        "x is 4",
        () =>
          if x.contents === 4 {
            pass
          } else {
            fail("")
          },
      )
      test(
        "x is suddenly 8",
        () =>
          if x.contents === 8 {
            pass
          } else {
            fail("")
          },
      )
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

      test(
        "x is 4",
        () =>
          if x.contents === 4 {
            pass
          } else {
            fail("")
          },
      )
      test(
        "x is suddenly 8",
        () =>
          if x.contents === 8 {
            pass
          } else {
            fail("")
          },
      )
    })

    Skip.describe("timeout should fail suite", () => {
      beforeEachAsync(~timeout=1, _ => ())
      test("", () => pass) /* runner will crash if there's no tests */
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

      test(
        "x is 4",
        () =>
          if x.contents === 4 {
            pass
          } else {
            fail("")
          },
      )
      test(
        "x is suddenly 8",
        () =>
          if x.contents === 8 {
            pass
          } else {
            fail("")
          },
      )
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

      test(
        "x is 4",
        () =>
          if x.contents === 4 {
            pass
          } else {
            fail("")
          },
      )
      test(
        "x is suddenly 8",
        () =>
          if x.contents === 8 {
            pass
          } else {
            fail("")
          },
      )
    })

    Skip.describe("timeout should fail suite", () => {
      beforeEachPromise(~timeout=1, () => Promise.make((~resolve as _, ~reject as _) => ()))
      test("", () => pass) /* runner will crash if there's no tests */
    })
  })

  describe("afterAll", () => {
    let x = ref(0)

    describe("phase 1", () => {
      afterAll(() => x := x.contents + 4)

      test(
        "x is 0",
        () =>
          if x.contents === 0 {
            pass
          } else {
            fail("")
          },
      )
      test(
        "x is still 0",
        () =>
          if x.contents === 0 {
            pass
          } else {
            fail("")
          },
      )
    })

    describe("phase 2", () =>
      test(
        "x is suddenly 4",
        () =>
          if x.contents === 4 {
            pass
          } else {
            fail("")
          },
      )
    )
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

          test(
            "x is 0",
            () =>
              if x.contents === 0 {
                pass
              } else {
                fail("")
              },
          )
          test(
            "x is still 0",
            () =>
              if x.contents === 0 {
                pass
              } else {
                fail("")
              },
          )
        },
      )

      describe(
        "phase 2",
        () =>
          test(
            "x is suddenly 4",
            () =>
              if x.contents === 4 {
                pass
              } else {
                fail("")
              },
          ),
      )
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

          test(
            "x is 0",
            () =>
              if x.contents === 0 {
                pass
              } else {
                fail("")
              },
          )
          test(
            "x is still 0",
            () =>
              if x.contents === 0 {
                pass
              } else {
                fail("")
              },
          )
        },
      )

      describe(
        "phase 2",
        () =>
          test(
            "x is suddenly 4",
            () =>
              if x.contents === 4 {
                pass
              } else {
                fail("")
              },
          ),
      )
    })

    Skip.describe("timeout should fail suite", () => {
      afterAllAsync(~timeout=1, _ => ())
      test("", () => pass) /* runner will crash if there's no tests */
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

          test(
            "x is 0",
            () =>
              if x.contents === 0 {
                pass
              } else {
                fail("")
              },
          )
          test(
            "x is still 0",
            () =>
              if x.contents === 0 {
                pass
              } else {
                fail("")
              },
          )
        },
      )

      describe(
        "phase 2",
        () =>
          test(
            "x is suddenly 4",
            () =>
              if x.contents === 4 {
                pass
              } else {
                fail("")
              },
          ),
      )
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

          test(
            "x is 0",
            () =>
              if x.contents === 0 {
                pass
              } else {
                fail("")
              },
          )
          test(
            "x is still 0",
            () =>
              if x.contents === 0 {
                pass
              } else {
                fail("")
              },
          )
        },
      )

      describe(
        "phase 2",
        () =>
          test(
            "x is suddenly 4",
            () =>
              if x.contents === 4 {
                pass
              } else {
                fail("")
              },
          ),
      )
    })

    Skip.describe("timeout should fail suite", () => {
      afterAllPromise(~timeout=1, () => Promise.make((~resolve as _, ~reject as _) => ()))
      test("", () => pass) /* runner will crash if there's no tests */
    })
  })

  describe("afterEach", () => {
    let x = ref(0)

    afterEach(() => x := x.contents + 4)

    test("x is 0", () =>
      if x.contents === 0 {
        pass
      } else {
        fail("")
      }
    )
    test("x is suddenly 4", () =>
      if x.contents === 4 {
        pass
      } else {
        fail("")
      }
    )
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

      test(
        "x is 0",
        () =>
          if x.contents === 0 {
            pass
          } else {
            fail("")
          },
      )
      test(
        "x is suddenly 4",
        () =>
          if x.contents === 4 {
            pass
          } else {
            fail("")
          },
      )
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

      test(
        "x is 0",
        () =>
          if x.contents === 0 {
            pass
          } else {
            fail("")
          },
      )
      test(
        "x is suddenly 4",
        () =>
          if x.contents === 4 {
            pass
          } else {
            fail("")
          },
      )
    })

    Skip.describe("timeout should fail suite", () => {
      afterEachAsync(~timeout=1, _ => ())
      test("", () => pass) /* runner will crash if there's no tests */
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

      test(
        "x is 0",
        () =>
          if x.contents === 0 {
            pass
          } else {
            fail("")
          },
      )
      test(
        "x is suddenly 4",
        () =>
          if x.contents === 4 {
            pass
          } else {
            fail("")
          },
      )
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

      test(
        "x is 0",
        () =>
          if x.contents === 0 {
            pass
          } else {
            fail("")
          },
      )
      test(
        "x is suddenly 4",
        () =>
          if x.contents === 4 {
            pass
          } else {
            fail("")
          },
      )
    })

    Skip.describe("timeout should fail suite", () => {
      afterEachPromise(~timeout=1, () => Promise.make((~resolve as _, ~reject as _) => ()))
      test("", () => pass) /* runner will crash if there's no tests */
    })
  })

  describe("Only", () =>
    /* See globals_only_test.ml */
    ()
  )

  describe("Skip", () => {
    Skip.test("Skip.test", () => pass)

    Skip.testAsync("Skip.testAsync", finish => finish(pass))
    Skip.testAsync("Skip.testAsync - timeout", ~timeout=1, _ => ())

    Skip.testPromise("Skip.testPromise", () => Promise.resolve(pass))
    Skip.testPromise("testPromise - timeout", ~timeout=1, () =>
      Promise.make((~resolve as _, ~reject as _) => ())
    )

    Skip.testAll("testAll", list{"foo", "bar", "baz"}, input =>
      if Js.String.length(input) === 3 {
        pass
      } else {
        fail("")
      }
    )
    Skip.testAll("testAll - tuples", list{("foo", 3), ("barbaz", 6), ("bananas!", 8)}, ((
      input,
      output,
    )) =>
      if Js.String.length(input) === output {
        pass
      } else {
        fail("")
      }
    )
    Skip.testAllPromise("testAllPromise", list{"foo", "bar", "baz"}, input =>
      Promise.resolve(
        if Js.String.length(input) === 3 {
          pass
        } else {
          fail("")
        },
      )
    )
    Skip.testAllPromise(
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

    Skip.describe("Skip.describe", () => test("some aspect", () => pass))
  })

  describe("Todo", () => Todo.test("Todo.test"))
}
