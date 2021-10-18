type assertion

module type Asserter = {
  type t<'a>
  let affirm: t<'a> => unit
}

module Runner: (A: Asserter) =>
{
  let test: (string, unit => A.t<_>) => unit
  let testAsync: (string, ~timeout: int=?, (A.t<_> => unit) => unit) => unit
  let testPromise: (string, ~timeout: int=?, unit => Js.Promise.t<A.t<_>>) => unit
  let testAll: (string, list<'a>, 'a => A.t<_>) => unit

  let describe: (string, unit => unit) => unit

  @val external beforeAll: (@uncurry (unit => unit)) => unit = "beforeAll"
  let beforeAllAsync: (~timeout: int=?, (unit => unit) => unit) => unit
  let beforeAllPromise: (~timeout: int=?, unit => Js.Promise.t<'a>) => unit
  @val external beforeEach: (@uncurry (unit => unit)) => unit = "beforeEach"
  let beforeEachAsync: (~timeout: int=?, (unit => unit) => unit) => unit
  let beforeEachPromise: (~timeout: int=?, unit => Js.Promise.t<'a>) => unit
  @val external afterAll: (@uncurry (unit => unit)) => unit = "afterAll"
  let afterAllAsync: (~timeout: int=?, (unit => unit) => unit) => unit
  let afterAllPromise: (~timeout: int=?, unit => Js.Promise.t<'a>) => unit
  @val external afterEach: (@uncurry (unit => unit)) => unit = "afterEach"
  let afterEachAsync: (~timeout: int=?, (unit => unit) => unit) => unit
  let afterEachPromise: (~timeout: int=?, unit => Js.Promise.t<'a>) => unit

  module Only: {
    let test: (string, unit => A.t<_>) => unit
    let testAsync: (string, ~timeout: int=?, (A.t<_> => unit) => unit) => unit
    let testPromise: (string, ~timeout: int=?, unit => Js.Promise.t<A.t<_>>) => unit
    let testAll: (string, list<'a>, 'a => A.t<_>) => unit
    let describe: (string, unit => unit) => unit
  }

  module Skip: {
    let test: (string, unit => A.t<_>) => unit
    let testAsync: (string, ~timeout: int=?, (A.t<_> => unit) => unit) => unit
    let testPromise: (string, ~timeout: int=?, unit => Js.Promise.t<A.t<_>>) => unit
    let testAll: (string, list<'a>, 'a => A.t<_>) => unit
    let describe: (string, unit => unit) => unit
  }
}

let test: (string, unit => assertion) => unit
let testAsync: (string, ~timeout: int=?, (assertion => unit) => unit) => unit
let testPromise: (string, ~timeout: int=?, unit => Js.Promise.t<assertion>) => unit
let testAll: (string, list<'a>, 'a => assertion) => unit

let describe: (string, unit => unit) => unit

@val external beforeAll: (@uncurry (unit => unit)) => unit = "beforeAll"
let beforeAllAsync: (~timeout: int=?, (unit => unit) => unit) => unit
let beforeAllPromise: (~timeout: int=?, unit => Js.Promise.t<'a>) => unit
@val external beforeEach: (@uncurry (unit => unit)) => unit = "beforeEach"
let beforeEachAsync: (~timeout: int=?, (unit => unit) => unit) => unit
let beforeEachPromise: (~timeout: int=?, unit => Js.Promise.t<'a>) => unit
@val external afterAll: (@uncurry (unit => unit)) => unit = "afterAll"
let afterAllAsync: (~timeout: int=?, (unit => unit) => unit) => unit
let afterAllPromise: (~timeout: int=?, unit => Js.Promise.t<'a>) => unit
@val external afterEach: (@uncurry (unit => unit)) => unit = "afterEach"
let afterEachAsync: (~timeout: int=?, (unit => unit) => unit) => unit
let afterEachPromise: (~timeout: int=?, unit => Js.Promise.t<'a>) => unit

module Only: {
  let test: (string, unit => assertion) => unit
  let testAsync: (string, ~timeout: int=?, (assertion => unit) => unit) => unit
  let testPromise: (string, ~timeout: int=?, unit => Js.Promise.t<assertion>) => unit
  let testAll: (string, list<'a>, 'a => assertion) => unit
  let describe: (string, unit => unit) => unit
}

module Skip: {
  let test: (string, unit => assertion) => unit
  let testAsync: (string, ~timeout: int=?, (assertion => unit) => unit) => unit
  let testPromise: (string, ~timeout: int=?, unit => Js.Promise.t<assertion>) => unit
  let testAll: (string, list<'a>, 'a => assertion) => unit
  let describe: (string, unit => unit) => unit
}

module Todo: {
  let test: string => unit
}

let pass: assertion
let fail: string => assertion

module Expect: {
  type plainPartial<'a> = [#Just('a)]
  type invertedPartial<'a> = [#Not('a)]
  type partial<'a> = [
    | plainPartial<'a>
    | invertedPartial<'a>
  ]

  let expect: 'a => plainPartial<'a>
  let expectFn: ('a => 'b, 'a) => plainPartial<unit => 'b> /* EXPERIMENTAL */

  let toBe: ('a, [< partial<'a>]) => assertion
  let toBeCloseTo: (. float, [< partial<float>]) => assertion
  let toBeSoCloseTo: (. float, ~digits: int, [< partial<float>]) => assertion
  let toBeGreaterThan: ('a, [< partial<'a>]) => assertion
  let toBeGreaterThanOrEqual: ('a, [< partial<'a>]) => assertion
  let toBeLessThan: ('a, [< partial<'a>]) => assertion
  let toBeLessThanOrEqual: ('a, [< partial<'a>]) => assertion
  let toBeSupersetOf: (array<'a>, [< partial<array<'a>>]) => assertion
  let toContain: ('a, [< partial<array<'a>>]) => assertion
  let toContainEqual: ('a, [< partial<array<'a>>]) => assertion
  let toContainString: (string, [< partial<string>]) => assertion
  let toEqual: ('a, [< partial<'a>]) => assertion
  let toHaveLength: (int, [< partial<array<'a>>]) => assertion
  let toMatch: (string, [< partial<string>]) => assertion
  let toMatchInlineSnapshot: (string, plainPartial<_>) => assertion
  let toMatchRe: (Js.Re.t, [< partial<string>]) => assertion
  let toMatchSnapshot: plainPartial<_> => assertion
  let toMatchSnapshotWithName: (string, plainPartial<_>) => assertion
  let toThrow: [< partial<unit => _>] => assertion
  let toThrowErrorMatchingSnapshot: plainPartial<unit => _> => assertion

  let not_: plainPartial<'a> => invertedPartial<'a>
  let not__: plainPartial<'a> => invertedPartial<'a>

  module Operators: {
    @@ocaml.text(" experimental ")

    let \"==": ([< partial<'a>], 'a) => assertion
    let \">": ([< partial<'a>], 'a) => assertion
    let \">=": ([< partial<'a>], 'a) => assertion
    let \"<": ([< partial<'a>], 'a) => assertion
    let \"<=": ([< partial<'a>], 'a) => assertion
    let \"=": ([< partial<'a>], 'a) => assertion
    let \"<>": (plainPartial<'a>, 'a) => assertion
    let \"!=": (plainPartial<'a>, 'a) => assertion
  }
}

module ExpectJs: {
  include module type of Expect

  let toBeDefined: [< partial<Js.undefined<_>>] => assertion
  let toBeFalsy: [< partial<_>] => assertion
  let toBeNull: [< partial<Js.null<_>>] => assertion
  let toBeTruthy: [< partial<_>] => assertion
  let toBeUndefined: [< partial<Js.undefined<_>>] => assertion
  let toContainProperties: (array<string>, [< partial<{..}>]) => assertion
  let toMatchObject: ({..}, [< partial<{..}>]) => assertion
}

module MockJs: {
  @@ocaml.text(" experimental ")

  type fn<'fn, 'args, 'ret>

  let new0: fn<unit => 'ret, unit, 'ret> => 'ret
  let new1: ('a, fn<'a => 'ret, 'a, 'ret>) => 'ret
  let new2: ('a, 'b, fn<(. 'a, 'b) => 'ret, ('a, 'b), 'ret>) => 'ret

  external fn: fn<'fn, _, _> => 'fn = "%identity"
  let calls: fn<_, 'args, _> => array<'args>
  let instances: fn<_, _, 'ret> => array<'ret>

  @ocaml.doc(" Beware: this actually replaces `mock`, not just `mock.instances` and `mock.calls` ")
  @bs.send.pipe(: fn<_>) external mockClear: unit = "mockClear"
  @bs.send.pipe(: fn<_>) external mockReset: unit = "mockReset"
  @bs.send.pipe(: fn<'fn, _, _> as 'self) external mockImplementation: 'fn => 'self = "mockImplementation"
  @bs.send.pipe(: fn<'fn, _, _> as 'self) external mockImplementationOnce: 'fn => 'self = "mockImplementationOnce"
  @bs.send.pipe(: fn<_, _, 'ret>) external mockReturnThis: unit =
    "mockReturnThis" /* not type safe, we don't know what `this` actually is */
  @bs.send.pipe(: fn<_, _, 'ret> as 'self) external mockReturnValue: 'ret => 'self = "mockReturnValue"
  @bs.send.pipe(: fn<_, _, 'ret> as 'self)  external mockReturnValueOnce: 'ret => 'self = "mockReturnValueOnce"
}

module Jest: {
  @val external clearAllTimers: unit => unit = "jest.clearAllTimers"
  @val external runAllTicks: unit => unit = "jest.runAllTicks"
  @val external runAllTimers: unit => unit = "jest.runAllTimers"
  @val external runAllImmediates: unit => unit = "jest.runAllImmediates"
  @val external runTimersToTime: int => unit = "jest.runTimersToTime"
  @val external advanceTimersByTime: int => unit = "jest.advanceTimersByTime"
  @val external runOnlyPendingTimers: unit => unit = "jest.runOnlyPendingTimers"
  @val external useFakeTimers: unit => unit = "jest.useFakeTimers"
  @val external useRealTimers: unit => unit = "jest.useRealTimers"
}

module JestJs: {
  @@ocaml.text(" experimental ")

  @val external disableAutomock: unit => unit = "jest.disableAutomock"
  @val external enableAutomock: unit => unit = "jest.enableAutomock"
  @val external resetModules: unit => unit = "jest.resetModules"
  @val
  external inferred_fn: unit => MockJs.fn<(. 'a) => Js.undefined<'b>, 'a, Js.undefined<'b>> =
    "jest.fn"
  @val external fn: ('a => 'b) => MockJs.fn<'a => 'b, 'a, 'b> = "jest.fn"
  @val external fn2: ((. 'a, 'b) => 'c) => MockJs.fn<(. 'a, 'b) => 'c, ('a, 'b), 'c> = "jest.fn"
  @val external mock: string => unit = "jest.mock"
  @val external mockWithFactory: (string, unit => 'a) => unit = "jest.mock"
  @val external mockVirtual: (string, unit => 'a, {..}) => unit = "jest.mock"
  @val external clearAllMocks: unit => unit = "jest.clearAllMocks"
  @val external resetAllMocks: unit => unit = "jest.resetAllMocks"
  @val external setMock: (string, {..}) => unit = "jest.setMock"
  @val external unmock: string => unit = "jest.unmock"
  @val external spyOn: ({..} as 'this, string) => MockJs.fn<unit, unit, 'this> = "jest.spyOn"
}
