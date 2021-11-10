open Jest
open Expect
open! Expect.Operators

@val external setTimeout: (unit => unit, int) => unit = "setTimeout"
@val external setImmediate: (unit => unit) => unit = "setImmediate"
@val external nextTick: (unit => unit) => unit = "process.nextTick"

let () = describe("Fake Timers", () => {
  test("runAllTimers", () => {
    let flag = ref(false)
    Jest.useFakeTimers()
    setTimeout(() => flag := true, 0)
    let before = flag.contents
    Jest.runAllTimers()

    expect((before, flag.contents)) == (false, true)
  })

  test("runAllTicks", () => {
    let flag = ref(false)
    Jest.useFakeTimers()
    nextTick(() => flag := true)
    let before = flag.contents
    Jest.runAllTicks()

    expect((before, flag.contents)) == (false, true)
  })

  test("runAllImmediates ", () => {
    let flag = ref(false)
    Jest.useFakeTimers(~implementation=#legacy, ())
    setImmediate(() => flag := true)
    let before = flag.contents
    Jest.runAllImmediates()

    expect((before, flag.contents)) == (false, true)
  })

  test("runTimersToTime", () => {
    let flag = ref(false)
    Jest.useFakeTimers(~implementation=#legacy, ())
    setTimeout(() => flag := true, 1500)
    let before = flag.contents
    Jest.advanceTimersByTime(1000)
    let inbetween = flag.contents
    Jest.advanceTimersByTime(1000)

    expect((before, inbetween, flag.contents)) == (false, false, true)
  })

  test("advanceTimersByTime", () => {
    let flag = ref(false)
    Jest.useFakeTimers(~implementation=#legacy, ())
    setTimeout(() => flag := true, 1500)
    let before = flag.contents
    Jest.advanceTimersByTime(1000)
    let inbetween = flag.contents
    Jest.advanceTimersByTime(1000)

    expect((before, inbetween, flag.contents)) == (false, false, true)
  })

  test("runOnlyPendingTimers", () => {
    let count = ref(0)
    Jest.useFakeTimers(~implementation=#legacy, ())
    let rec recursiveTimeout = () => {
      count := count.contents + 1
      setTimeout(recursiveTimeout, 1500)
    }
    recursiveTimeout()
    let before = count.contents
    Jest.runOnlyPendingTimers()
    let inBetween = count.contents
    Jest.runOnlyPendingTimers()

    expect((before, inBetween, count.contents)) == (1, 2, 3)
  })

  test("clearAllTimers", () => {
    let flag = ref(false)
    Jest.useFakeTimers()
    setImmediate(() => flag := true)
    let before = flag.contents
    Jest.clearAllTimers()
    Jest.runAllTimers()

    expect((before, flag.contents)) == (false, false)
  })

  testAsync("clearAllTimers", finish => {
    Jest.useFakeTimers(~implementation=#legacy, ())
    Jest.useRealTimers()
    setImmediate(() => finish(pass))
  })
})
