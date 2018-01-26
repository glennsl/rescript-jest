type assertion

module type Asserter = sig
  type 'a t
  val affirm : 'a t -> unit
end

module Runner (A : Asserter) : sig
  val test : string -> (unit -> _ A.t) -> unit
  val testAsync : string -> ((_ A.t -> unit) -> unit) -> unit
  val testPromise : string -> (unit -> _ A.t Js.Promise.t) -> unit
  val testAll : string -> 'a list -> ('a -> _ A.t) -> unit

  external describe : string -> (unit -> unit) -> unit = "" [@@bs.val]

  external beforeAll : (unit -> unit) -> unit = "" [@@bs.val]
  val beforeAllAsync : ((_ A.t -> unit) -> unit) -> unit
  val beforeAllPromise : (unit -> _ A.t Js.Promise.t) -> unit
  external beforeEach : (unit -> unit) -> unit = "" [@@bs.val]
  external afterAll : (unit -> unit) -> unit = "" [@@bs.val]
  val afterAllAsync : ((_ A.t -> unit) -> unit) -> unit
  external afterEach : (unit -> unit) -> unit = "" [@@bs.val]

  module Only : sig
    val test : string -> (unit -> _ A.t) -> unit
    val testAsync : string -> ((_ A.t -> unit) -> unit) -> unit
    val testPromise : string -> (unit -> _ A.t Js.Promise.t) -> unit
    val testAll : string -> 'a list -> ('a -> _ A.t) -> unit
    external describe : string -> (unit -> unit) -> unit = "describe.only" [@@bs.val]
  end

  module Skip : sig
    external test : string -> (unit -> _ A.t) -> unit = "it.skip" [@@bs.val]
    external testAsync : string -> ((_ A.t -> unit) -> unit) -> unit = "it.skip" [@@bs.val]
    external testPromise : string -> (unit -> _ A.t Js.Promise.t) -> unit = "it.skip" [@@bs.val]
    val testAll : string -> 'a list -> ('a -> _ A.t) -> unit
    external describe : string -> (unit -> unit) -> unit = "describe.skip" [@@bs.val]
  end
end

val test : string -> (unit -> assertion) -> unit
val testAsync : string -> ((assertion -> unit) -> unit) -> unit
val testPromise : string -> (unit -> assertion Js.Promise.t) -> unit
val testAll : string -> 'a list -> ('a -> assertion) -> unit

external describe : string -> (unit -> unit) -> unit = "" [@@bs.val]

external beforeAll : (unit -> unit) -> unit = "" [@@bs.val]
external beforeEach : (unit -> unit) -> unit = "" [@@bs.val]
external afterAll : (unit -> unit) -> unit = "" [@@bs.val]
external afterEach : (unit -> unit) -> unit = "" [@@bs.val]

module Only : sig
  val test : string -> (unit -> assertion) -> unit
  val testAsync : string -> ((assertion -> unit) -> unit) -> unit
  val testPromise : string -> (unit -> assertion Js.Promise.t) -> unit
  val testAll : string -> 'a list -> ('a -> assertion) -> unit
  external describe : string -> (unit -> unit) -> unit = "describe.only" [@@bs.val]
end

module Skip : sig
  external test : string -> (unit -> assertion) -> unit = "it.skip" [@@bs.val]
  external testAsync : string -> ((assertion -> unit) -> unit) -> unit = "it.skip" [@@bs.val]
  external testPromise : string -> (unit -> assertion Js.Promise.t) -> unit = "it.skip" [@@bs.val]
  external testAll : string -> 'a list -> ('a -> assertion) -> unit = "it.skip" [@@bs.val]
  external describe : string -> (unit -> unit) -> unit = "describe.skip" [@@bs.val]
end

val pass : assertion
val fail : string -> assertion

module Expect : sig
  type 'a plainPartial = [`Just of 'a]
  type 'a invertedPartial = [`Not of 'a]
  type 'a partial = [
    | 'a plainPartial
    | 'a invertedPartial
  ]

  val expect : 'a -> 'a plainPartial
  val expectFn : ('a -> 'b) -> 'a -> (unit -> 'b) plainPartial (* EXPERIMENTAL *)

  val toBe : 'a -> [< 'a partial] -> assertion
  val toBeCloseTo : float -> [< float partial] -> assertion
  val toBeSoCloseTo : float -> digits:int -> [< float partial] -> assertion
  val toBeGreaterThan : 'a -> [< 'a partial] -> assertion
  val toBeGreaterThanOrEqual : 'a -> [< 'a partial] -> assertion
  val toBeLessThan : 'a -> [< 'a partial] -> assertion
  val toBeLessThanOrEqual : 'a -> [< 'a partial] -> assertion
  val toBeSupersetOf : 'a array -> [< 'a array partial] -> assertion
  val toContain : 'a -> [< 'a array partial] -> assertion
  val toContainString : string -> [< string partial] -> assertion
  val toEqual : 'a -> [< 'a partial] -> assertion
  val toHaveLength : int -> [< 'a array partial] -> assertion
  val toMatch : string -> [< string partial] -> assertion
  val toMatchRe : Js.Re.t -> [< string partial] -> assertion
  val toMatchSnapshot : _ plainPartial -> assertion
  val toMatchSnapshotWithName : string -> _ plainPartial -> assertion
  val toThrow : [< (unit -> _) partial] -> assertion
  val toThrowErrorMatchingSnapshot : (unit -> _) plainPartial -> assertion
  val toThrowException : exn -> [< (unit -> _) partial] -> assertion
  val toThrowMessage : string -> [< (unit -> _) partial] -> assertion
  val toThrowMessageRe : Js.Re.t -> [< (unit -> _) partial] -> assertion
  val not_ : 'a plainPartial -> 'a invertedPartial

  module Operators : sig
    (** experimental *)

    val (==) : [< 'a partial] -> 'a -> assertion
    val (>)  : [< 'a partial] -> 'a -> assertion
    val (>=) : [< 'a partial] -> 'a -> assertion
    val (<)  : [< 'a partial] -> 'a -> assertion
    val (<=) : [< 'a partial] -> 'a -> assertion
    val (=)  : [< 'a partial] -> 'a -> assertion
    val (<>) : 'a plainPartial -> 'a -> assertion
    val (!=) : 'a plainPartial -> 'a -> assertion
  end
end

module ExpectJs : sig
  include module type of Expect

  val toBeDefined : [< _ Js.undefined partial] -> assertion
  val toBeFalsy : [< _ partial] -> assertion
  val toBeNull : [< _ Js.null partial] -> assertion
  val toBeTruthy : [< _ partial] -> assertion
  val toBeUndefined : [< _ Js.undefined partial] -> assertion
  val toContainProperties : string array -> [< < .. > Js.t partial] -> assertion
  val toMatchObject : < .. > Js.t -> [< < .. > Js.t partial] -> assertion
end

module MockJs : sig
  (** experimental *)

  type ('fn, 'args, 'ret) fn

  external fn : ('fn, _, _) fn -> 'fn = "%identity"
  val calls : (_, 'args, _) fn -> 'args array
  val instances : (_, _, 'ret) fn -> 'ret array

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