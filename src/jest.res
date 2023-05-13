module Promise = Js.Promise2

type modifier<'a> = [
  | #Just('a)
  | #Not('a)
]

let mapMod = (f, x) =>
  switch x {
  | #Just(a) => #Just(f(a))
  | #Not(a) => #Not(f(a))
  }

type rec assertion =
  | Ok: assertion
  | Fail(string): assertion

  | ArrayContains(modifier<(array<'a>, 'a)>): assertion
  | ArrayContainsEqual(modifier<(array<'a>, 'a)>): assertion
  | ArrayLength(modifier<(array<'a>, int)>): assertion
  | ArraySuperset(modifier<(array<'a>, array<'a>)>): assertion
  | Be(modifier<('a, 'a)>): assertion
  | Equal(modifier<('a, 'a)>): assertion
  | FloatCloseTo(modifier<(float, float)>): assertion
  | FloatSoCloseTo(modifier<(float, float, int)>): assertion
  | GreaterThan(modifier<('a, 'a)>): assertion
  | GreaterThanOrEqual(modifier<('a, 'a)>): assertion
  | LessThan(modifier<('a, 'a)>): assertion
  | LessThanOrEqual(modifier<('a, 'a)>): assertion
  | StringContains(modifier<(string, string)>): assertion
  | StringMatch(modifier<(string, Js.Re.t)>): assertion

  | Throws(modifier<unit => _>): assertion

  | MatchInlineSnapshot(_, string): assertion
  | MatchSnapshot(_): assertion
  | MatchSnapshotName(_, string): assertion
  | ThrowsMatchSnapshot(unit => _): assertion

  /* JS */
  | Defined(modifier<Js.undefined<'a>>): assertion
  | Falsy(modifier<'a>): assertion
  | Null(modifier<Js.null<_>>): assertion
  | Truthy(modifier<'a>): assertion
  | Undefined(modifier<Js.undefined<'a>>): assertion
  | ObjectContains(modifier<({..}, array<string>)>): assertion
  | ObjectMatch(modifier<({..}, {..})>): assertion

module type Asserter = {
  type t<'a>
  let affirm: t<'a> => unit
}

/* internal */
module LLExpect: {
  type t<'a> = assertion
  let affirm: t<'a> => unit
} = {
  type t<'a> = assertion
  type specialMatch

  @val external expect: 'a => {..} = "expect"
  @val external fail: string => unit = "fail"
  @val external arrayContaining: array<'a> => specialMatch = "expect.arrayContaining"
  @val external stringContaining: string => specialMatch = "expect.stringContaining"
  let objectContaining: array<string> => {..} = %raw(`
    function (properties) {
      var spec = {};
      properties.forEach(function (property) {
        spec[property] = expect.anything();
      });
      return spec;
    }
  `)

  let affirm = x =>
    switch x {
    | Ok => ()
    | Fail(message) => fail(message)

    | ArrayContains(#Just(a, b)) => expect(a)["toContain"](b)
    | ArrayContains(#Not(a, b)) => expect(a)["not"]["toContain"](b)
    | ArrayContainsEqual(#Just(a, b)) => expect(a)["toContainEqual"](b)
    | ArrayContainsEqual(#Not(a, b)) => expect(a)["not"]["toContainEqual"](b)
    | ArrayLength(#Just(a, l)) => expect(a)["toHaveLength"](l)
    | ArrayLength(#Not(a, l)) => expect(a)["not"]["toHaveLength"](l)
    | ArraySuperset(#Just(a, b)) => expect(a)["toEqual"](arrayContaining(b))
    | ArraySuperset(#Not(a, b)) => expect(a)["not"]["toEqual"](arrayContaining(b))
    | Be(#Just(a, b)) => expect(a)["toBe"](b)
    | Be(#Not(a, b)) => expect(a)["not"]["toBe"](b)
    | Equal(#Just(a, b)) => expect(a)["toEqual"](b)
    | Equal(#Not(a, b)) => expect(a)["not"]["toEqual"](b)
    | FloatCloseTo(#Just(a, b)) => expect(a)["toBeCloseTo"](b)
    | FloatCloseTo(#Not(a, b)) => expect(a)["not"]["toBeCloseTo"](b)
    | FloatSoCloseTo(#Just(a, b, p)) => expect(a)["toBeCloseTo"](. b, p)
    | FloatSoCloseTo(#Not(a, b, p)) => expect(a)["not"]["toBeCloseTo"](. b, p)
    | GreaterThan(#Just(a, b)) => expect(a)["toBeGreaterThan"](b)
    | GreaterThan(#Not(a, b)) => expect(a)["not"]["toBeGreaterThan"](b)
    | GreaterThanOrEqual(#Just(a, b)) => expect(a)["toBeGreaterThanOrEqual"](b)
    | GreaterThanOrEqual(#Not(a, b)) => expect(a)["not"]["toBeGreaterThanOrEqual"](b)
    | LessThan(#Just(a, b)) => expect(a)["toBeLessThan"](b)
    | LessThan(#Not(a, b)) => expect(a)["not"]["toBeLessThan"](b)
    | LessThanOrEqual(#Just(a, b)) => expect(a)["toBeLessThanOrEqual"](b)
    | LessThanOrEqual(#Not(a, b)) => expect(a)["not"]["toBeLessThanOrEqual"](b)
    | StringMatch(#Just(s, re)) => expect(s)["toMatch"](re)
    | StringMatch(#Not(s, re)) => expect(s)["not"]["toMatch"](re)
    | StringContains(#Just(a, b)) => expect(a)["toEqual"](stringContaining(b))
    | StringContains(#Not(a, b)) => expect(a)["not"]["toEqual"](stringContaining(b))

    | Throws(#Just(f)) => expect(f)["toThrow"](.)
    | Throws(#Not(f)) => expect(f)["not"]["toThrow"](.)

    | MatchInlineSnapshot(a, inlineSnapshot) => expect(a)["toMatchInlineSnapshot"](inlineSnapshot)
    | MatchSnapshot(a) => expect(a)["toMatchSnapshot"](.)
    | MatchSnapshotName(a, name) => expect(a)["toMatchSnapshot"](name)
    | ThrowsMatchSnapshot(f) => expect(f)["toThrowErrorMatchingSnapshot"](.)

    /* JS */
    | Defined(#Just(a)) => expect(a)["toBeDefined"](.)
    | Defined(#Not(a)) => expect(a)["not"]["toBeDefined"](.)
    | Falsy(#Just(a)) => expect(a)["toBeFalsy"](.)
    | Falsy(#Not(a)) => expect(a)["not"]["toBeFalsy"](.)
    | Null(#Just(a)) => expect(a)["toBeNull"](.)
    | Null(#Not(a)) => expect(a)["not"]["toBeNull"](.)
    | Truthy(#Just(a)) => expect(a)["toBeTruthy"](.)
    | Truthy(#Not(a)) => expect(a)["not"]["toBeTruthy"](.)
    | Undefined(#Just(a)) => expect(a)["toBeUndefined"](.)
    | Undefined(#Not(a)) => expect(a)["not"]["toBeUndefined"](.)
    | ObjectContains(#Just(a, props)) => expect(a)["toEqual"](objectContaining(props))
    | ObjectContains(#Not(a, props)) => expect(a)["not"]["toEqual"](objectContaining(props))
    | ObjectMatch(#Just(a, b)) => expect(a)["toMatchObject"](b)
    | ObjectMatch(#Not(a, b)) => expect(a)["not"]["toMatchObject"](b)
    }
}

module Runner = (A: Asserter) => {
  let affirm = A.affirm
  @val external _test: (string, @uncurry (unit => Js.undefined<unit>)) => unit = "test"
  @val
  external _testAsync: (
    string,
    ((. unit) => unit) => Js.undefined<unit>,
    Js.Undefined.t<int>,
  ) => unit = "test"
  @val
  external _testPromise: (string, @uncurry (unit => promise<'a>), Js.Undefined.t<int>) => unit =
    "test"

  let test = (name, callback) =>
    _test(name, () => {
      affirm(callback())
      Js.undefined
    })

  let testAsync = (name, ~timeout=?, callback) =>
    _testAsync(
      name,
      finish => {
        callback(case => {
          affirm(case)
          finish(.)
        })
        Js.undefined
      },
      Js.Undefined.fromOption(timeout),
    )

  let testPromise = (name, ~timeout=?, callback) =>
    _testPromise(
      name,
      () => Promise.then(callback(), a => a->A.affirm->Promise.resolve),
      Js.Undefined.fromOption(timeout),
    )

  let testAll = (name, inputs, callback) => List.iter(input => {
      let name = `${name} - ${input->Js.String.make}`
      _test(name, () => {
        affirm(callback(input))
        Js.undefined
      })
    }, inputs)

  let testAllPromise = (name: string, inputs, ~timeout=?, callback) => List.iter(input => {
      let name = `${name} - ${input->Js.String.make}`
      _testPromise(
        name,
        () => Promise.then(callback(input), a => a->A.affirm->Promise.resolve),
        Js.Undefined.fromOption(timeout),
      )
    }, inputs)

  @val external describe: (string, @uncurry (unit => Js.undefined<unit>)) => unit = "describe"
  let describe = (label, f) =>
    describe(label, () => {
      f()
      Js.undefined
    })

  @val external beforeAll: (@uncurry (unit => unit)) => unit = "beforeAll"
  @val
  external beforeAllAsync: (((. unit) => unit) => Js.undefined<unit>, Js.Undefined.t<int>) => unit =
    "beforeAll"
  let beforeAllAsync = (~timeout=?, callback) => beforeAllAsync(finish => {
      callback(() => finish(.))
      Js.undefined
    }, Js.Undefined.fromOption(timeout))
  @val
  external beforeAllPromise: (@uncurry (unit => promise<'a>), Js.Undefined.t<int>) => unit =
    "beforeAll"
  let beforeAllPromise = (~timeout=?, callback) =>
    beforeAllPromise(() => Promise.resolve(callback()), Js.Undefined.fromOption(timeout))

  @val external beforeEach: (@uncurry (unit => unit)) => unit = "beforeEach"
  @val
  external beforeEachAsync: (
    ((. unit) => unit) => Js.undefined<unit>,
    Js.Undefined.t<int>,
  ) => unit = "beforeEach"
  let beforeEachAsync = (~timeout=?, callback) => beforeEachAsync(finish => {
      callback(() => finish(.))
      Js.undefined
    }, Js.Undefined.fromOption(timeout))
  @val
  external beforeEachPromise: (@uncurry (unit => promise<'a>), Js.Undefined.t<int>) => unit =
    "beforeEach"
  let beforeEachPromise = (~timeout=?, callback) =>
    beforeEachPromise(() => Promise.resolve(callback()), Js.Undefined.fromOption(timeout))

  @val external afterAll: (@uncurry (unit => unit)) => unit = "afterAll"
  @val
  external afterAllAsync: (((. unit) => unit) => Js.undefined<unit>, Js.Undefined.t<int>) => unit =
    "afterAll"
  let afterAllAsync = (~timeout=?, callback) => afterAllAsync(finish => {
      callback(() => finish(.))
      Js.undefined
    }, Js.Undefined.fromOption(timeout))
  @val
  external afterAllPromise: (@uncurry (unit => promise<'a>), Js.Undefined.t<int>) => unit =
    "afterAll"
  let afterAllPromise = (~timeout=?, callback) =>
    afterAllPromise(() => Promise.resolve(callback()), Js.Undefined.fromOption(timeout))

  @val external afterEach: (@uncurry (unit => unit)) => unit = "afterEach"
  @val
  external afterEachAsync: (((. unit) => unit) => Js.undefined<unit>, Js.Undefined.t<int>) => unit =
    "afterEach"
  let afterEachAsync = (~timeout=?, callback) => afterEachAsync(finish => {
      callback(() => finish(.))
      Js.undefined
    }, Js.Undefined.fromOption(timeout))
  @val
  external afterEachPromise: (@uncurry (unit => promise<'a>), Js.Undefined.t<int>) => unit =
    "afterEach"
  let afterEachPromise = (~timeout=?, callback) =>
    afterEachPromise(() => Promise.resolve(callback()), Js.Undefined.fromOption(timeout))

  module Only = {
    @val external _test: (string, @uncurry (unit => Js.undefined<unit>)) => unit = "it.only"
    @val
    external _testAsync: (
      string,
      ((. unit) => unit) => Js.undefined<unit>,
      Js.Undefined.t<int>,
    ) => unit = "it.only"
    @val
    external _testPromise: (string, @uncurry (unit => promise<'a>), Js.Undefined.t<int>) => unit =
      "it.only"

    let test = (name, callback) =>
      _test(name, () => {
        affirm(callback())
        Js.undefined
      })

    let testAsync = (name, ~timeout=?, callback) =>
      _testAsync(
        name,
        finish => {
          callback(assertion => {
            affirm(assertion)
            finish(.)
          })
          Js.undefined
        },
        Js.Undefined.fromOption(timeout),
      )

    let testPromise = (name, ~timeout=?, callback) =>
      _testPromise(
        name,
        () => Promise.then(callback(), a => a->affirm->Promise.resolve),
        Js.Undefined.fromOption(timeout),
      )

    let testAll = (name, inputs, callback) => List.iter(input => {
        let name = `${name} - ${input->Js.String.make}`
        _test(name, () => {
          affirm(callback(input))
          Js.undefined
        })
      }, inputs)

    let testAllPromise = (name, inputs, ~timeout=?, callback) => List.iter(input => {
        let name = `${name} - ${input->Js.String.make}`
        _testPromise(
          name,
          () => Promise.then(callback(input), a => a->A.affirm->Promise.resolve),
          Js.Undefined.fromOption(timeout),
        )
      }, inputs)

    @val
    external describe: (string, @uncurry (unit => Js.undefined<unit>)) => unit = "describe.only"
    let describe = (label, f) =>
      describe(label, () => {
        f()
        Js.undefined
      })
  }

  module Skip = {
    @val external test: (string, @uncurry (unit => A.t<'a>)) => unit = "it.skip"
    @val external testAsync: (string, (A.t<'a> => unit) => unit) => unit = "it.skip"
    let testAsync = (name, ~timeout as _=?, callback) => testAsync(name, callback)
    @val
    external testPromise: (string, @uncurry (unit => promise<A.t<'a>>)) => unit = "it.skip"
    let testPromise = (name, ~timeout as _=?, callback) => testPromise(name, callback)
    let testAll = (name, inputs, callback) => List.iter(input => {
        let name = `${name} - ${input->Js.String.make}`
        test(name, () => callback(input))
      }, inputs)
    let testAllPromise = (name, inputs, ~timeout as _=?, callback) => List.iter(input => {
        let name = `${name} - ${input->Js.String.make}`
        testPromise(name, () => callback(input))
      }, inputs)
    @val
    external describe: (string, @uncurry (unit => Js.undefined<unit>)) => unit = "describe.skip"
    let describe = (label, f) =>
      describe(label, () => {
        f()
        Js.undefined
      })
  }

  module Todo = {
    @val external test: string => unit = "it.todo"
  }
}

include Runner(LLExpect)

let pass = Ok
let fail = message => Fail(message)
/*
 * Not implemented:
 * - expect.anything - pointless when there's `option`, `Js.null` etc.
 * - expect.any - pointless when you have types, except against < .. > Js.t, but how to implement this?
 * - expect.arrayContaining - implement as overloads of `toEqual`, `toBeCalledWith`, `objectContaining` and `toMatchObject`
 * - expect.assertions - Not supported. There should be only one assertion per test.
 * - expect.objectContaining - implement as separate matcher and overload of `toBeCalledWith`
 * - expect.stringContaining - implement as overloads of `toEqual`, `toBeCalledWith`, `objectContaining` and `toMatchObject`
 * - expect.stringMatching - implement as overloads of `toEqual`, `toBeCalledWith`, `objectContaining` and `toMatchObject`
 */

module Expect = {
  type plainPartial<'a> = [#Just('a)]
  type invertedPartial<'a> = [#Not('a)]
  type partial<'a> = modifier<'a>

  let expect = a => #Just(a)

  let expectFn = (f, a) => #Just(() => f(a))

  let toBe = (b, p) => Be(mapMod(a => (a, p), b))
  /* toHaveBeenCalled* */
  let toBeCloseTo = (b, p) => FloatCloseTo(mapMod(a => (a, p), b))
  let toBeSoCloseTo = (b, ~digits, p) => FloatSoCloseTo(mapMod(a => (a, p, digits), b))
  let toBeGreaterThan = (b, p) => GreaterThan(mapMod(a => (a, p), b))
  let toBeGreaterThanOrEqual = (b, p) => GreaterThanOrEqual(mapMod(a => (a, p), b))
  let toBeLessThan = (b, p) => LessThan(mapMod(a => (a, p), b))
  let toBeLessThanOrEqual = (b, p) => LessThanOrEqual(mapMod(a => (a, p), b))
  @ocaml.doc(" replaces expect.arrayContaining ")
  let toBeSupersetOf = (b, p) => ArraySuperset(mapMod(a => (a, p), b))
  let toContain = (b, p) => ArrayContains(mapMod(a => (a, p), b))
  let toContainEqual = (b, p) => ArrayContainsEqual(mapMod(a => (a, p), b))
  @ocaml.doc(" replaces expect.stringContaining ")
  let toContainString = (b, p) => StringContains(mapMod(a => (a, p), b))
  let toEqual = (b, p) => Equal(mapMod(a => (a, p), b))
  let toHaveLength = (l, p) => ArrayLength(mapMod(a => (a, p), l))
  let toMatch = (p, s) => StringMatch(mapMod(a => (a, Js.Re.fromString(s)), p))
  let toMatchInlineSnapshot = (#Just(a), inlineSnapshot) => MatchInlineSnapshot(a, inlineSnapshot)
  let toMatchRe = (re, p) => StringMatch(mapMod(a => (a, p), re))
  let toMatchSnapshot = (#Just(a)) => MatchSnapshot(a)
  let toMatchSnapshotWithName = (#Just(a), name) => MatchSnapshotName(a, name)
  let toThrow = f => Throws((f :> modifier<_>))
  let toThrowErrorMatchingSnapshot = (#Just(f)) => ThrowsMatchSnapshot(f)
  let not_ = (#Just(a)) => #Not(a)
  let not__ = not_ /* For Reason syntax compatibility. TODO: deprecate and remove */

  module Operators = {
    @@ocaml.text(" experimental ")

    let \"==" = (a, b) => toBe(a, b)
    let \">" = (a, b) => toBeGreaterThan(a, b)
    let \">=" = (a, b) => toBeGreaterThanOrEqual(a, b)
    let \"<" = (a, b) => toBeLessThan(a, b)
    let \"<=" = (a, b) => toBeLessThanOrEqual(a, b)
    let \"=" = (a, b) => toEqual(a, b)
    let \"<>" = (a, b) => a->not_->toEqual(b)
    let \"!=" = (a, b) => a->not_->toBe(b)
  }
}

module ExpectJs = {
  include Expect

  let toBeDefined = a => Defined((a :> modifier<_>))
  let toBeFalsy = a => Falsy((a :> modifier<_>))
  /* toBeInstanceOf */
  let toBeNull = a => Null((a :> modifier<_>))
  let toBeTruthy = a => Truthy((a :> modifier<_>))
  let toBeUndefined = a => Undefined((a :> modifier<_>))

  @ocaml.doc(" replaces expect.objectContaining ")
  let toContainProperties = (props, p) => ObjectContains(mapMod(a => (a, p), props))

  let toMatchObject = (b, p) => ObjectMatch(mapMod(a => (a, p), b))
}

module MockJs = {
  @@ocaml.text(" experimental ")

  type fn<'fn, 'args, 'ret>

  %%raw(`
    function makeNewMock(self) {
      return new (Function.prototype.bind.apply(self, arguments));
    }
  `)

  @val external new0: fn<unit => 'ret, unit, 'ret> => 'ret = "makeNewMock"
  let new0 = new0
  @val external new1: (fn<'a => 'ret, 'a, 'ret>, 'a) => 'ret = "makeNewMock"
  let new1 = (self, a) => new1(self, a)
  @val external new2: (fn<(. 'a, 'b) => 'ret, ('a, 'b), 'ret>, 'a, 'b) => 'ret = "makeNewMock"
  let new2 = (self, a, b) => new2(self, a, b)

  external fn: fn<'fn, _, _> => 'fn = "%identity"
  @get @scope("mock") external calls: fn<_, 'args, _> => array<'args> = "calls"
  let calls = self =>
    Js.Array.copy(calls(self)) /* Awesome, the bloody things are mutated so we need to copy */
  let calls = self =>
    Array.map(
      %raw(`
    function (args) { return args.length === 1 ? args[0] : args }
  `),
      calls(self),
    ) /* there's no such thing as aa 1-ary tuple, so we need to unbox single-element arrays */
  @get @scope("mock")
  external instances: fn<_, _, 'ret> => array<'ret> =
    "instances" /* TODO: semms this only records "instances" created by `new` */
  let instances = self =>
    Js.Array.copy(instances(self)) /* Awesome, the bloody things are mutated so we need to copy */

  @ocaml.doc(" Beware: this actually replaces `mock`, not just `mock.instances` and `mock.calls` ")
  @send
  external mockClear: fn<'fn, 'a, 'b> => unit = "mockClear"
  @send external mockReset: fn<'fn, 'a, 'b> => unit = "mockReset"
  @send external mockImplementation: (fn<'fn, 'a, 'b> as 'self, 'fn) => 'self = "mockImplementation"
  @send
  external mockImplementationOnce: (fn<'fn, _, _> as 'self, 'fn) => 'self = "mockImplementationOnce"
  @send
  external mockReturnThis: fn<_, _, 'ret> => 'ret =
    "mockReturnThis" /* not type safe, we don't know what `this` actually is */
  @send external mockReturnValue: (fn<_, _, 'ret> as 'self, 'ret) => 'self = "mockReturnValue"
  @send
  external mockReturnValueOnce: (fn<_, _, 'ret> as 'self, 'ret) => 'self = "mockReturnValueOnce"
}

module Jest = {
  type fakeTimerImplementation = [#legacy | #modern]
  @val external clearAllTimers: unit => unit = "jest.clearAllTimers"
  @val external runAllTicks: unit => unit = "jest.runAllTicks"
  @val external runAllTimers: unit => unit = "jest.runAllTimers"
  @val external runAllImmediates: unit => unit = "jest.runAllImmediates"
  @val external runTimersToTime: int => unit = "jest.runTimersToTime"
  @val external advanceTimersByTime: int => unit = "jest.advanceTimersByTime"
  @val external runOnlyPendingTimers: unit => unit = "jest.runOnlyPendingTimers"
  @val external useFakeTimers: unit => unit = "jest.useFakeTimers"
  @val external useFakeTimersImplementation: fakeTimerImplementation => unit = "jest.useFakeTimers"
  let useFakeTimers = (~implementation: option<fakeTimerImplementation>=?, ()) => {
    switch implementation {
    | None => useFakeTimers()
    | Some(implString) => useFakeTimersImplementation(implString)
    }
  }
  @val external useRealTimers: unit => unit = "jest.useRealTimers"

  @val external setSystemTimeWithInt: int => unit = "jest.setSystemTime"
  @val external setSystemTimeWithDate: Js.Date.t => unit = "jest.setSystemTime"

  type systemTime = [#int(int) | #date(Js.Date.t)]
  let setSystemTime = systemTime =>
    switch systemTime {
    | #date(date) => setSystemTimeWithDate(date)
    | #int(num) => setSystemTimeWithInt(num)
    }
}

module JestJs = {
  @@ocaml.text(" experimental ")

  @val external disableAutomock: unit => unit = "jest.disableAutomock"
  @val external enableAutomock: unit => unit = "jest.enableAutomock"
  /* genMockFromModule */
  @val external resetModules: unit => unit = "jest.resetModules"
  @val
  external inferred_fn: unit => MockJs.fn<(. 'a) => Js.undefined<'b>, 'a, Js.undefined<'b>> =
    "jest.fn" /* not sure how useful this really is */
  @val external fn: ('a => 'b) => MockJs.fn<'a => 'b, 'a, 'b> = "jest.fn"
  @val external fn2: ((. 'a, 'b) => 'c) => MockJs.fn<(. 'a, 'b) => 'c, ('a, 'b), 'c> = "jest.fn"
  /* TODO
  external fn3 : ('a -> 'b -> 'c -> 'd) -> ('a * 'b * 'c) MockJs.fn = "jest.fn" [@@bs.val]
  external fn4 : ('a -> 'b -> 'c -> 'd -> 'e) -> ('a * 'b * 'c * 'd) MockJs.fn = "jest.fn" [@@bs.val]
  external fn5 : ('a -> 'b -> 'c -> 'd -> 'e -> 'f) -> ('a * 'a * 'c * 'd * 'e) MockJs.fn = "jest.fn" [@@bs.val]
  external fn6 : ('a -> 'b -> 'c -> 'd -> 'e -> 'f -> 'g) -> ('a * 'b * 'c * 'd * 'e * 'f) MockJs.fn = "jest.fn" [@@bs.val]
 */
  /* external isMockFunction : MockJs.fn -> Js.boolean = "jest.isMockFunction" [@@bs.val] */ /* pointless with types? */
  @val external mock: string => unit = "jest.mock"
  @val external mockWithFactory: (string, unit => 'a) => unit = "jest.mock"
  @val external mockVirtual: (string, unit => 'a, {..}) => unit = "jest.mock"
  /* TODO If this is merely defined, babel-plugin-jest-hoist fails with "The second argument of `jest.mock` must be a function." Silly thing.
  let mockVirtual : string -> (unit -> 'a) -> unit =
    fun moduleName factory -> mockVirtual moduleName factory [%bs.obj { _virtual = Js.true_ }]
 */
  @val external clearAllMocks: unit => unit = "jest.clearAllMocks"
  @val external resetAllMocks: unit => unit = "jest.resetAllMocks"
  @val external setMock: (string, {..}) => unit = "jest.setMock"
  @val external unmock: string => unit = "jest.unmock"
  @val
  external spyOn: ({..} as 'this, string) => MockJs.fn<unit, unit, 'this> =
    "jest.spyOn" /* this is a bit too dynamic */
}
