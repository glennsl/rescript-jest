
module Promise = Bs_promise
type ('a, 'e) promise = ('a, 'e) Promise.t

type 'a matchSpec

module type Asserter = sig
  type 'a t
  val assert_ : 'a t -> unit
end

module Runner (A : Asserter) : sig
  val test : string -> (unit -> 'a A.t) -> unit
  val testAsync : string -> (('a A.t -> unit) -> unit) -> unit
  val testPromise : string -> (unit -> ('a A.t, 'e) promise) -> unit

  external describe : string -> (unit -> unit) -> unit = "" [@@bs.val]

  external beforeAll : (unit -> unit) -> unit = "" [@@bs.val]
  external beforeEach : (unit -> unit) -> unit = "" [@@bs.val]
  external afterAll : (unit -> unit) -> unit = "" [@@bs.val]
  external afterEach : (unit -> unit) -> unit = "" [@@bs.val]

  module Only : sig
    val test : string -> (unit -> 'a A.t) -> unit
    val testAsync : string -> (('a A.t -> unit) -> unit) -> unit
    val testPromise : string -> (unit -> ('a A.t, 'e) promise) -> unit
    external describe : string -> (unit -> unit) -> unit = "describe.only" [@@bs.val]
  end

  module Skip : sig
    external test : string -> (unit -> 'a A.t) -> unit = "test.skip" [@@bs.val]
    external testAsync : string -> (('a A.t -> unit) -> unit) -> unit = "test.skip" [@@bs.val]
    external testPromise : string -> (unit -> ('a A.t, 'e) promise) -> unit = "test.skip" [@@bs.val]
    external describe : string -> (unit -> unit) -> unit = "describe.skip" [@@bs.val]
  end
end

val test : string -> (unit -> 'a matchSpec) -> unit
val testAsync : string -> (('a matchSpec -> unit) -> unit) -> unit
val testPromise : string -> (unit -> ('a matchSpec, 'e) promise) -> unit

external describe : string -> (unit -> unit) -> unit = "" [@@bs.val]

external beforeAll : (unit -> unit) -> unit = "" [@@bs.val]
external beforeEach : (unit -> unit) -> unit = "" [@@bs.val]
external afterAll : (unit -> unit) -> unit = "" [@@bs.val]
external afterEach : (unit -> unit) -> unit = "" [@@bs.val]

module Only : sig
  val test : string -> (unit -> 'a matchSpec) -> unit
  val testAsync : string -> (('a matchSpec -> unit) -> unit) -> unit
  val testPromise : string -> (unit -> ('a matchSpec, 'e) promise) -> unit
  external describe : string -> (unit -> unit) -> unit = "describe.only" [@@bs.val]
end

module Skip : sig
  external test : string -> (unit -> 'a matchSpec) -> unit = "test.skip" [@@bs.val]
  external testAsync : string -> (('a matchSpec -> unit) -> unit) -> unit = "test.skip" [@@bs.val]
  external testPromise : string -> (unit -> ('a matchSpec, 'e) promise) -> unit = "test.skip" [@@bs.val]
  external describe : string -> (unit -> unit) -> unit = "describe.skip" [@@bs.val]
end

val pass : unit matchSpec
val fail : string -> string matchSpec

val testOnly : string -> (unit -> 'a matchSpec) -> unit
[@@ocaml.deprecated "Use `Only.test` instead"]
external testSkip : string -> (unit -> 'a matchSpec) -> unit = "test.skip" [@@bs.val]
[@@ocaml.deprecated "Use `Skip.test` instead"]
val testAsyncOnly : string -> (('a matchSpec -> unit) -> unit) -> unit
[@@ocaml.deprecated "Use `Only.testAsync` instead"]
external testAsyncSkip : string -> (('a matchSpec -> unit) -> unit) -> unit = "test.skip" [@@bs.val]
[@@ocaml.deprecated "Use `Skip.testAsync` instead"]
val testPromiseOnly : string -> (unit -> ('a matchSpec, 'e) promise) -> unit
[@@ocaml.deprecated "Use `Only.testPromise` instead"]
external testPromiseSkip : string -> (unit -> ('a matchSpec, 'e) promise) -> unit = "test.skip" [@@bs.val]
[@@ocaml.deprecated "Use `Skip.testPromise` instead"]
external describeOnly : string -> (unit -> unit) -> unit = "describe.only" [@@bs.val]
[@@ocaml.deprecated "Use `Only.describe` instead"]
external describeSkip : string -> (unit -> unit) -> unit = "describe.skip" [@@bs.val]
[@@ocaml.deprecated "Use `Skip.describe` instead"]

module Expect : sig
  type 'a partial
  
  val expect : 'a -> 'a partial

  val toBe : 'a -> 'a partial -> 'a matchSpec
  val toBeCloseTo : float -> float partial -> 'a matchSpec
  val toBeSoCloseTo : float -> digits:int -> float partial -> float matchSpec
  val toBeGreaterThan : 'a -> 'a partial -> 'a matchSpec
  val toBeGreaterThanOrEqual : 'a -> 'a partial -> 'a matchSpec
  val toBeLessThan : 'a -> 'a partial -> 'a matchSpec
  val toBeLessThanOrEqual : 'a -> 'a partial -> 'a matchSpec
  val toBeSupersetOf : 'a array -> 'a array partial -> 'a matchSpec
  val toContain : 'a -> 'a array partial -> 'a matchSpec
  val toContainString : string -> string partial -> 'a matchSpec
  val toEqual : 'a -> 'a partial -> 'a matchSpec
  val toHaveLength : int -> 'a array partial -> 'a matchSpec
  val toMatch : string -> string partial -> string matchSpec
  val toMatchRe : Js.Re.t -> string partial -> string matchSpec
  val toMatchSnapshot : 'a partial -> 'a matchSpec
  val toMatchSnapshotWithName : string -> 'a partial -> 'a matchSpec
  val toThrow : (unit -> unit) partial -> (unit -> unit) matchSpec
  val toThrowErrorMatchingSnapshot : (unit -> unit) partial -> (unit -> unit) matchSpec
  val toThrowMessage : string -> (unit -> unit) partial -> (unit -> unit) matchSpec
  val toThrowMessageRe : Js.Re.t -> (unit -> unit) partial -> (unit -> unit) matchSpec
  val not_ : 'a partial -> 'a partial

  module Operators : sig
    (** experimental *)

    val (==) : 'a partial -> 'a -> 'a matchSpec
    val (>)  : 'a partial -> 'a -> 'a matchSpec
    val (>=) : 'a partial -> 'a -> 'a matchSpec
    val (<)  : 'a partial -> 'a -> 'a matchSpec
    val (<=) : 'a partial -> 'a -> 'a matchSpec
    val (=)  : 'a partial -> 'a -> 'a matchSpec
    val (<>) : 'a partial -> 'a -> 'a matchSpec
    val (!=) : 'a partial -> 'a -> 'a matchSpec
  end
end

module ExpectJs : sig
  type 'a partial

  val expect : 'a -> 'a partial

  val toBe : 'a -> 'a partial -> 'a matchSpec
  val toBeCloseTo : float -> float partial -> 'a matchSpec
  val toBeSoCloseTo : float -> digits:int -> float partial -> float matchSpec
  val toBeGreaterThan : 'a -> 'a partial -> 'a matchSpec
  val toBeGreaterThanOrEqual : 'a -> 'a partial -> 'a matchSpec
  val toBeLessThan : 'a -> 'a partial -> 'a matchSpec
  val toBeLessThanOrEqual : 'a -> 'a partial -> 'a matchSpec
  val toBeSupersetOf : 'a array -> 'a array partial -> 'a matchSpec
  val toContain : 'a -> 'a array partial -> 'a matchSpec
  val toContainString : string -> string partial -> 'a matchSpec
  val toEqual : 'a -> 'a partial -> 'a matchSpec
  val toHaveLength : int -> 'a array partial -> 'a matchSpec
  val toMatch : string -> string partial -> string matchSpec
  val toMatchRe : Js.Re.t -> string partial -> string matchSpec
  val toMatchSnapshot : 'a partial -> 'a matchSpec
  val toMatchSnapshotWithName : string -> 'a partial -> 'a matchSpec
  val toThrow : (unit -> unit) partial -> (unit -> unit) matchSpec
  val toThrowErrorMatchingSnapshot : (unit -> unit) partial -> (unit -> unit) matchSpec
  val toThrowMessage : string -> (unit -> unit) partial -> (unit -> unit) matchSpec
  val toThrowMessageRe : Js.Re.t -> (unit -> unit) partial -> (unit -> unit) matchSpec
  val not_ : 'a partial -> 'a partial

  module Operators : sig
    (** experimental *)

    val (==) : 'a partial -> 'a -> 'a matchSpec
    val (>)  : 'a partial -> 'a -> 'a matchSpec
    val (>=) : 'a partial -> 'a -> 'a matchSpec
    val (<)  : 'a partial -> 'a -> 'a matchSpec
    val (<=) : 'a partial -> 'a -> 'a matchSpec
    val (=)  : 'a partial -> 'a -> 'a matchSpec
    val (<>) : 'a partial -> 'a -> 'a matchSpec
    val (!=) : 'a partial -> 'a -> 'a matchSpec
  end

  val toBeDefined : 'a Js.undefined partial -> 'a matchSpec
  val toBeFalsy : 'a partial -> 'a matchSpec
  val toBeNull : 'a Js.null partial -> 'a matchSpec
  val toBeTruthy : 'a partial -> 'a matchSpec
  val toBeUndefined : 'a Js.undefined partial -> 'a matchSpec
  val toContainProperties : string array -> 'a Js.t partial -> 'a matchSpec
  val toMatchObject : < .. > Js.t -> < .. > Js.t partial -> unit matchSpec
end

module MockJs : sig
  (** experimental *)

  type ('fn, 'args, 'ret) fn
  type ('args, 'ret) mock
  
  external fn : ('fn, _, _) fn -> 'fn = "%identity"
  external mock : (_, 'args, 'ret) fn -> ('args, 'ret) mock = "" [@@bs.get]
  val calls : ('args, _) mock -> 'args array
  val instances : (_, 'ret') mock -> 'ret array
  
  (** Beware: this actually replaces `mock`, not just `mock.instances` and `mock.calls` *)
  external mockClear : unit = "" [@@bs.send.pipe: _ fn]
  external mockReset : unit = "" [@@bs.send.pipe: _ fn]
  external mockImplementation : 'fn -> 'self = "" [@@bs.send.pipe: ('fn, _, _) fn as 'self]
  external mockImplementationOnce : 'fn -> 'self = "" [@@bs.send.pipe: ('fn, _, _) fn as 'self]
  external mockReturnThis : unit = "" [@@bs.send.pipe: (_, _, 'ret) fn] (* not type safe, we don't know what `this` actually is *)
  external mockReturnValue : 'ret -> 'self = "" [@@bs.send.pipe: (_, _, 'ret) fn as 'self]
  external mockReturnValueOnce : 'ret -> 'self = "" [@@bs.send.pipe: (_, _, 'ret) fn as 'self]
end

module Jest : sig
  external clearAllTimers : unit -> unit = "jest.clearAllTimers" [@@bs.val]
  external runAllTicks : unit -> unit = "jest.runAllTicks" [@@bs.val]
  external runAllTimers : unit -> unit = "jest.runAllTimers" [@@bs.val]
  external runAllImmediates : unit -> unit = "jest.runAllImmediates" [@@bs.val]
  external runTimersToTime : int -> unit = "jest.runTimersToTime" [@@bs.val]
  external runOnlyPendingTimers : unit -> unit = "jest.runOnlyPendingTimers" [@@bs.val]
  external useFakeTimers : unit -> unit = "jest.useFakeTimers" [@@bs.val]
  external useRealTimers : unit -> unit = "jest.useRealTimers" [@@bs.val]
end

module JestJs : sig
  (** experimental *)

  external disableAutomock : unit -> unit = "jest.disableAutomock" [@@bs.val]
  external enableAutomock : unit -> unit = "jest.enableAutomock" [@@bs.val]
  external resetModules : unit -> unit = "jest.resetModules" [@@bs.val]
  external inferred_fn : unit -> ('a -> 'b Js.undefined [@bs], 'a, 'b Js.undefined) MockJs.fn = "jest.fn" [@@bs.val]
  external fn : ('a -> 'b) -> ('a -> 'b, 'a, 'b) MockJs.fn = "jest.fn" [@@bs.val]
  external fn2 : ('a -> 'b -> 'c [@bs]) -> (('a -> 'b -> 'c [@bs]), 'a * 'b, 'c) MockJs.fn = "jest.fn" [@@bs.val]
  external mock : string -> unit = "jest.mock" [@@bs.val]
  external mockWithFactory : string -> (unit -> 'a) ->unit = "jest.mock" [@@bs.val]
  external mockVirtual : string -> (unit -> 'a) -> < .. > Js.t -> unit = "jest.mock" [@@bs.val]
  external clearAllMocks : unit -> unit = "jest.clearAllMocks" [@@bs.val]
  external resetAllMocks : unit -> unit = "jest.resetAllMocks" [@@bs.val]
  external setMock : string -> < .. > Js.t -> unit = "jest.setMock" [@@bs.val]
  external unmock : string -> unit = "jest.unmock" [@@bs.val]
  external spyOn : (< .. > Js.t as 'this) -> string -> (unit, unit, 'this) MockJs.fn = "jest.spyOn" [@@bs.val]
end