
module Promise = Bs_promise
type ('a, 'e) promise = ('a, 'e) Promise.t

type 'a simpleMatchSpec =
| Ok
| Fail of string
| ArrayContains of 'a array * 'a
| ArrayLength of 'a array * int
| ArraySuperset of 'a array * 'a array
| Be of 'a * 'a
| Defined of 'a Js.undefined
| Equal of 'a * 'a
| Falsy of 'a
| FloatCloseTo of float * float * int option
| GreaterThan of 'a * 'a
| GreaterThanOrEqual of 'a * 'a
| LessThan of 'a * 'a
| LessThanOrEqual of 'a * 'a
| MatchSnapshot of 'a
| MatchSnapshotName of 'a * string
| Null of 'a Js.null
| ObjectContains of 'a Js.t * string array
(*| ObjectMatch of < .. > Js.t * < .. > Js.t*) (* unable to implement this due to unbound type vars *)
| StringContains of string * string
| StringMatch of string * Js.Re.t
| Throws of (unit -> unit)
| ThrowsException of (unit -> unit) * exn
| ThrowsMatchSnapshot of (unit -> unit)
| ThrowsMessage of (unit -> unit) * string
| ThrowsMessageRe of (unit -> unit) * Js.Re.t
| Truthy of 'a
| Undefined of 'a Js.undefined

type 'a matchModifier =
| Just : 'a -> 'a matchModifier
| Not : 'a -> 'a matchModifier

let mapMod f = function
| Just a -> Just (f a)
| Not a -> Not (f a)

type 'a matchSpec = 'a simpleMatchSpec matchModifier
  
module type Asserter = sig
  type 'a t
  val assert_ : 'a t -> unit
end

(* internal *)
module LLExpect : sig
  type 'a t = 'a matchSpec
  external expect : 'a -> < .. > Js.t = "" [@@bs.val] (* exposed to support toMatchObject *)
  val assert_ : 'a t -> unit
end = struct
  type 'a t = 'a matchSpec
  type specialMatch
  external expect : 'a -> < .. > Js.t = "" [@@bs.val]
  external fail : string -> unit = "" [@@bs.val]
  external arrayContaining : 'a array -> specialMatch = "expect.arrayContaining" [@@bs.val]
  external stringContaining : string -> specialMatch = "expect.stringContaining" [@@bs.val]
  let objectContaining : string array -> < .. > Js.t = [%raw {|
    function (properties) {
      var spec = {};
      properties.forEach(function (property) {
        spec[property] = expect.anything();
      });
      return spec;
    }
  |}]

  let assert_: 'a matchSpec -> unit = function
  | Just Ok -> ()
  | Not Ok -> fail "not ok"
  | Just Fail message -> fail message
  | Not Fail _ -> ()
  | Just ArrayContains (a, b) -> (expect a) ## toContain b
  | Not ArrayContains (a, b) -> (expect a) ## not ## toContain b
  | Just ArrayLength (a, l) -> (expect a) ## toHaveLength l
  | Not ArrayLength (a, l) -> (expect a) ## not ## toHaveLength l
  | Just ArraySuperset (a, b) -> (expect a) ## toEqual (arrayContaining b)
  | Not ArraySuperset (a, b) -> (expect a) ## not ## toEqual (arrayContaining b)
  | Just Be (a, b) -> (expect a) ## toBe b
  | Not Be (a, b) -> (expect a) ## not ## toBe b
  | Just Defined a -> (expect a) ## toBeDefined ()
  | Not Defined a -> (expect a) ## not ## toBeDefined ()
  | Just Equal (a, b) -> (expect a) ## toEqual b
  | Not Equal (a, b) -> (expect a) ## not ## toEqual b
  | Just Falsy a -> (expect a) ## toBeFalsy ()
  | Not Falsy a -> (expect a) ## not ## toBeFalsy ()
  | Just FloatCloseTo (a, b, p) -> (expect a) ## toBeCloseTo a b (Js.Undefined.from_opt p)
  | Not FloatCloseTo (a, b, p) -> (expect a) ## not ## toBeCloseTo a b (Js.Undefined.from_opt p)
  | Just GreaterThan (a, b) -> (expect a) ## toBeGreaterThan b
  | Not GreaterThan (a, b) -> (expect a) ## not ## toBeGreaterThan b
  | Just GreaterThanOrEqual (a, b) -> (expect a) ## toBeGreaterThanOrEqual b
  | Not GreaterThanOrEqual (a, b) -> (expect a) ## not ## toBeGreaterThanOrEqual b
  | Just LessThan (a, b) -> (expect a) ## toBeLessThan b
  | Not LessThan (a, b) -> (expect a) ## not ## toBeLessThan b
  | Just LessThanOrEqual (a, b) -> (expect a) ## toBeLessThanOrEqual b
  | Not LessThanOrEqual (a, b) -> (expect a) ## not ## toBeLessrThanOrEqual b
  | Just MatchSnapshot a -> (expect a) ## toMatchSnapshot ()
  | Not MatchSnapshot a -> (expect a) ## not ## toMatchSnapshot ()
  | Just MatchSnapshotName (a, name) -> (expect a) ## toMatchSnapshot name
  | Not MatchSnapshotName (a, name) -> (expect a) ## not ## toMatchSnapshot name
  | Just Null a -> (expect a) ## toBeNull ()
  | Not Null a -> (expect a) ## not ## toBeNull ()
  | Just ObjectContains (a, props) -> (expect a) ## toEqual (objectContaining props)
  | Not ObjectContains (a, props) -> (expect a) ## not ## toEqual (objectContaining props)
  (*
  | Just ObjectMatch (a, b) -> (expect a) ## toMatchObject b
  | Not ObjectMatch (a, b) -> (expect a) ## not ## toMatchObject b
  *)
  | Just StringMatch (s, re) -> (expect s) ## toMatch re
  | Not StringMatch (s, re) -> (expect s) ## not ## toMatch re
  | Just StringContains (a, b) -> (expect a) ## toEqual (stringContaining b)
  | Not StringContains (a, b) -> (expect a) ## not ## toEqual (stringContaining b)
  | Just Throws f -> (expect f) ## toThrow ()
  | Not Throws f -> (expect f) ## not ## toThrow ()
  | Just ThrowsException (f, e) -> (expect f) ## toThrow e
  | Not ThrowsException (f, e) -> (expect f) ## not ## toThrow e
  | Just ThrowsMatchSnapshot f -> (expect f) ## toThrowErrorMatchingSnapshot ()
  | Not ThrowsMatchSnapshot f -> (expect f) ## not ## toThrowErrorMatchingSnapshot ()
  | Just ThrowsMessage (f, msg) -> (expect f) ## toThrow msg
  | Not ThrowsMessage (f, msg) -> (expect f) ## not ## toThrow msg
  | Just ThrowsMessageRe (f, re) -> (expect f) ## toThrow re
  | Not ThrowsMessageRe (f, re) -> (expect f) ## not ## toThrow re
  | Just Truthy a -> (expect a) ## toBeTruthy ()
  | Not Truthy a -> (expect a) ## not ## toBeTruthy ()
  | Just Undefined a -> (expect a) ## toBeUndefined ()
  | Not Undefined a -> (expect a) ## not ## toBeUndefined ()
end

module Runner (A : Asserter) = struct
  let returnUndefined callback a = callback a; Js.Undefined.empty

  external test : string -> (unit -> unit Js.undefined) -> unit = "" [@@bs.val]
  let test : string -> (unit -> 'a A.t) -> unit = fun name callback ->
    test name (returnUndefined (fun () -> A.assert_ (callback ())))
  external testOnly : string -> (unit -> unit Js.undefined) -> unit = "test.only" [@@bs.val]
  let testOnly : string -> (unit -> 'a A.t) -> unit = fun name callback ->
    testOnly name (returnUndefined (fun () -> A.assert_ (callback ())))
  [@@ocaml.deprecated "Use `Only.test` instead"]
  external testSkip : string -> (unit -> 'a A.t) -> unit = "test.skip" [@@bs.val]
  [@@ocaml.deprecated "Use `Skip.test` instead"]
      
  external testAsync : string -> ((unit -> unit) -> unit Js.undefined) -> unit = "test" [@@bs.val]
  let testAsync : string -> (('a A.t -> unit) -> unit) -> unit = fun name callback ->
    testAsync name (returnUndefined (fun done_ -> callback (fun case -> A.assert_ case; done_ ())))
  external testAsyncOnly : string -> ((unit -> unit) -> unit Js.undefined) -> unit = "test.only" [@@bs.val]
  let testAsyncOnly : string -> (('a A.t -> unit) -> unit) -> unit = fun name callback ->
    testAsyncOnly name (returnUndefined (fun done_ -> callback (fun case -> A.assert_ case; done_ ())))
  [@@ocaml.deprecated "Use `Only.testAsync` instead"]
  external testAsyncSkip : string -> (('a A.t -> unit) -> unit) -> unit = "test.skip" [@@bs.val]
  [@@ocaml.deprecated "Use `Skip.testAsync` instead"]

  external testPromise : string -> (unit -> ('a, 'e) promise) -> unit = "test" [@@bs.val]
  let testPromise : string -> (unit -> ('a A.t, 'e) promise) -> unit = fun name callback ->
    testPromise name (fun () -> callback () |> Promise.then_ A.assert_)
  external testPromiseOnly : string -> (unit -> ('a, 'e) promise) -> unit = "test.only" [@@bs.val]
  let testPromiseOnly : string -> (unit -> ('a A.t, 'e) promise) -> unit = fun name callback ->
    testPromiseOnly name (fun () -> callback () |> Promise.then_ A.assert_)
  [@@ocaml.deprecated "Use `Only.testPromise` instead"]
  external testPromiseSkip : string -> (unit -> ('a A.t, 'e) promise) -> unit = "test.skip" [@@bs.val]
  [@@ocaml.deprecated "Use `Skip.testPromise` instead"]

  external describe : string -> (unit -> unit) -> unit = "" [@@bs.val]
  external describeOnly : string -> (unit -> unit) -> unit = "describe.only" [@@bs.val]
  [@@ocaml.deprecated "Use `Only.describe` instead"]
  external describeSkip : string -> (unit -> unit) -> unit = "describe.skip" [@@bs.val]
  [@@ocaml.deprecated "Use `Skip.describe` instead"]

  external beforeAll : (unit -> unit) -> unit = "" [@@bs.val]
  external beforeEach : (unit -> unit) -> unit = "" [@@bs.val]
  external afterAll : (unit -> unit) -> unit = "" [@@bs.val]
  external afterEach : (unit -> unit) -> unit = "" [@@bs.val]

  module Only = struct
    external test : string -> (unit -> unit Js.undefined) -> unit = "test.only" [@@bs.val]
    let test : string -> (unit -> 'a A.t) -> unit = fun name callback ->
      test name (returnUndefined (fun () -> A.assert_ (callback ())))

    external testAsync : string -> ((unit -> unit) -> unit Js.undefined) -> unit = "test.only" [@@bs.val]
    let testAsync : string -> (('a A.t -> unit) -> unit) -> unit = fun name callback ->
      testAsync name (returnUndefined (fun done_ -> callback (fun case -> A.assert_ case; done_ ())))

    external testPromise : string -> (unit -> ('a, 'e) promise) -> unit = "test.only" [@@bs.val]
    let testPromise : string -> (unit -> ('a A.t, 'e) promise) -> unit = fun name callback ->
      testPromise name (fun () -> callback () |> Promise.then_ A.assert_)

    external describe : string -> (unit -> unit) -> unit = "describe.only" [@@bs.val]
  end

  module Skip = struct
    external test : string -> (unit -> 'a A.t) -> unit = "test.skip" [@@bs.val]
    external testAsync : string -> (('a A.t -> unit) -> unit) -> unit = "test.skip" [@@bs.val]
    external testPromise : string -> (unit -> ('a A.t, 'e) promise) -> unit = "test.skip" [@@bs.val]
    external describe : string -> (unit -> unit) -> unit = "describe.skip" [@@bs.val]
  end
end

include Runner(LLExpect)

(*
 * Not implemented:
 * - expect.anything - pointless when there's `option`, `Js.null` etc.
 * - expect.any - pointless when you have types, except against < .. > Js.t, but how to implement this?
 * - expect.arrayContaining - implement as overloads of `toEqual`, `toBeCalledWith`, `objectContaining` and `toMatchObject`
 * - expect.assertions - Not supported. There should be only one assertion per test.
 * - expect.objectContaining - implement as separate matcher and overload of `toBeCalledWith`
 * - expect.stringContaining - implement as overloads of `toEqual`, `toBeCalledWith`, `objectContaining` and `toMatchObject`
 * - expect.stringMatching - implement as overloads of `toEqual`, `toBeCalledWith`, `objectContaining` and `toMatchObject`
 *)

module Expect = struct
  type 'a partial = 'a matchModifier
  
  let expect : 'a -> 'a partial = fun a -> Just a
  
  let toBe : 'a -> 'a partial -> 'a matchSpec =
    fun b -> mapMod (fun a -> Be (a, b))

  (* toHaveBeenCalled* *)
  
  let toBeCloseTo : 'a -> 'a partial -> 'a matchSpec =
    fun b -> mapMod (fun a -> FloatCloseTo (a, b, None))
  
  let toBeSoCloseTo : float -> digits:int -> float partial -> float matchSpec =
    fun b ~digits -> mapMod (fun a -> FloatCloseTo (a, b, Some digits))

  let toBeGreaterThan : 'a -> 'a partial -> 'a matchSpec =
    fun b -> mapMod (fun a -> GreaterThan (a, b))

  let toBeGreaterThanOrEqual : 'a -> 'a partial -> 'a matchSpec =
    fun b -> mapMod (fun a -> GreaterThanOrEqual (a, b))

  let toBeLessThan : 'a -> 'a partial -> 'a matchSpec =
    fun b -> mapMod (fun a -> LessThan (a, b))

  let toBeLessThanOrEqual : 'a -> 'a partial -> 'a matchSpec =
    fun b -> mapMod (fun a -> LessThanOrEqual (a, b))

  (** replaces expect.arrayContaining *)
  let toBeSupersetOf : 'a array -> 'a array partial -> 'a matchSpec =
    fun b -> mapMod (fun a -> ArraySuperset (a, b))

  let toContain : 'a -> 'a array partial -> 'a matchSpec =
    fun b -> mapMod (fun a -> ArrayContains (a, b))

  (** replaces expect.stringContaining *)
  let toContainString : string -> string partial -> 'a matchSpec =
    fun b -> mapMod (fun a -> StringContains (a, b))

  let toEqual : 'a -> 'a partial -> 'a matchSpec =
    fun b -> mapMod (fun a -> Equal (a, b))

  let toHaveLength : int -> 'a array partial -> 'a matchSpec =
    fun l -> mapMod (fun a -> ArrayLength (a, l))

  let toMatch : string -> string partial -> string matchSpec =
    fun s -> mapMod (fun a -> StringMatch (a, Js.Re.fromString s))

  let toMatchRe : Js.Re.t -> string partial -> string matchSpec =
    fun re -> mapMod (fun a -> StringMatch (a, re))

  let toMatchSnapshot : 'a partial -> 'a matchSpec =
    fun a -> mapMod (fun a -> MatchSnapshot a) a

  let toMatchSnapshotWithName : string -> 'a partial -> 'a matchSpec =
    fun name -> mapMod (fun a -> MatchSnapshotName (a, name))

  let toThrow : (unit -> unit) partial -> (unit -> unit) matchSpec =
    mapMod (fun f -> Throws f)
  
  let toThrowErrorMatchingSnapshot : (unit -> unit) partial -> (unit -> unit) matchSpec =
    mapMod (fun f -> ThrowsMatchSnapshot f)

  (*let toThrowException : exn -> (unit -> unit) partial -> (unit -> unit) matchSpec =
    fun e -> mapMod (fun f -> ThrowsException (f, e))*)

  let toThrowMessage : string -> (unit -> unit) partial -> (unit -> unit) matchSpec =
    fun msg -> mapMod (fun f -> ThrowsMessage (f, msg))

  let toThrowMessageRe : Js.Re.t -> (unit -> unit) partial -> (unit -> unit) matchSpec =
    fun re -> mapMod (fun f -> ThrowsMessageRe (f, re))

  let not_ : 'a partial -> 'a partial = function
    | Just a -> Not a
    | Not _ -> raise (Invalid_argument "I suck at GADTs")


  module Operators = struct
    (** experimental *)

    let (==) = fun a b -> toBe b a
    let (>) = fun a b -> toBeGreaterThan b a
    let (>=) = fun a b -> toBeGreaterThanOrEqual b a
    let (<) = fun a b -> toBeLessThan b a
    let (<=) = fun a b -> toBeLessThanOrEqual b a
    let (=) = fun a b -> toEqual b a
    let (<>) = fun a b -> a |> not_ |> toEqual b
    let (!=) = fun a b -> a |> not_ |> toBe b
  end
end

module ExpectJs = struct
  include Expect

  let toBeDefined : 'a Js.undefined partial -> 'a matchSpec =
    fun a -> mapMod (fun a -> Defined a) a

  let toBeFalsy : 'a partial -> 'a matchSpec =
    fun a -> mapMod (fun a -> Falsy a) a

  (* toBeInstanceOf *)

  let toBeNull : 'a Js.null partial -> 'a matchSpec =
    fun a -> mapMod (fun a -> Null a) a

  let toBeTruthy : 'a partial -> 'a matchSpec =
    fun a -> mapMod (fun a -> Truthy a) a

  let toBeUndefined : 'a Js.undefined partial -> 'a matchSpec =
    fun a -> mapMod (fun a -> Undefined a) a

  (** replaces expect.objectContaining *)
  let toContainProperties : string array -> 'a Js.t partial -> 'a matchSpec =
    fun props -> mapMod (fun a -> ObjectContains (a, props))

  let toMatchObject : < .. > Js.t -> < .. > Js.t partial -> unit matchSpec =
    (*fun b -> mapMod (fun a -> ObjectMatch (a, b))*)
    fun b -> function
    | Just a -> LLExpect.(expect a) ## toMatchObject b; Just Ok
    | Not a -> LLExpect.(expect a) ## not ## toMatchObject b; Just Ok
end

module MockJs = struct
  (** experimental *)

  type ('fn, 'args, 'ret) fn
  type ('args, 'ret) mock
  
  (* TODO: "... contains type variables cannot be generalized"
  (** Equiavlent to calling new mock() *)
  let make : ('fn, _, _) fn -> 'fn = [%bs.raw {|
    function(self) {
      return new (Function.prototype.bind.apply(self, arguments));
    }
  |}]
  *)
  
  external fn : ('fn, _, _) fn -> 'fn = "%identity"
  external mock : (_, 'args, 'ret) fn -> ('args, 'ret) mock = "" [@@bs.get]
  external calls : ('args, _) mock -> 'args array = "" [@@bs.get]
  let calls self = Js.Array.copy (calls self) (* Awesome, the bloody things are mutated so we need to copy *)
  let calls self = calls self |> Array.map [%bs.raw {|
    function (args) { return args.length === 1 ? args[0] : args }
  |}] (* there's no such thing as aa 1-ary tuple, so we need to unbox single-element arrays *)
  external instances : (_, 'ret') mock -> 'ret array = "" [@@bs.get] (* TODO: semms this only records "instances" created by `new` *)
  let instances self = Js.Array.copy (instances self) (* Awesome, the bloody things are mutated so we need to copy *)
  (* "... contains type variables cannot be generalized"
  let calls : 'args fn -> 'args = [%bs.raw {|
    function (fn) { fn.mock.calls; }()
  |}]
  let instances : _ fn -> 'a = [%bs.raw {|
    function (fn) { fn.mock.instances; }()
  |}]
  *)
  
  (** Beware: this actually replaces `mock`, not just `mock.instances` and `mock.calls` *)
  external mockClear : unit = "" [@@bs.send.pipe: _ fn]
  external mockReset : unit = "" [@@bs.send.pipe: _ fn]
  external mockImplementation : 'fn -> 'self = "" [@@bs.send.pipe: ('fn, _, _) fn as 'self]
  external mockImplementationOnce : 'fn -> 'self = "" [@@bs.send.pipe: ('fn, _, _) fn as 'self]
  external mockReturnThis : unit = "" [@@bs.send.pipe: (_, _, 'ret) fn] (* not type safe, we don't know what `this` actually is *)
  external mockReturnValue : 'ret -> 'self = "" [@@bs.send.pipe: (_, _, 'ret) fn as 'self]
  external mockReturnValueOnce : 'ret -> 'self = "" [@@bs.send.pipe: (_, _, 'ret) fn as 'self]
end

module Jest = struct
  external clearAllTimers : unit -> unit = "jest.clearAllTimers" [@@bs.val]
  external runAllTicks : unit -> unit = "jest.runAllTicks" [@@bs.val]
  external runAllTimers : unit -> unit = "jest.runAllTimers" [@@bs.val]
  external runAllImmediates : unit -> unit = "jest.runAllImmediates" [@@bs.val]
  external runTimersToTime : int -> unit = "jest.runTimersToTime" [@@bs.val]
  external runOnlyPendingTimers : unit -> unit = "jest.runOnlyPendingTimers" [@@bs.val]
  external useFakeTimers : unit -> unit = "jest.useFakeTimers" [@@bs.val]
  external useRealTimers : unit -> unit = "jest.useRealTimers" [@@bs.val]
end

module JestJs = struct
  (** experimental *)

  external disableAutomock : unit -> unit = "jest.disableAutomock" [@@bs.val]
  external enableAutomock : unit -> unit = "jest.enableAutomock" [@@bs.val]
  (* genMockFromModule *)
  external resetModules : unit -> unit = "jest.resetModules" [@@bs.val]
  external inferred_fn : unit -> ('a -> 'b Js.undefined [@bs], 'a, 'b Js.undefined) MockJs.fn = "jest.fn" [@@bs.val] (* not sure how useful this really is *)
  external fn : ('a -> 'b) -> ('a -> 'b, 'a, 'b) MockJs.fn = "jest.fn" [@@bs.val]
  external fn2 : ('a -> 'b -> 'c [@bs]) -> (('a -> 'b -> 'c [@bs]), 'a * 'b, 'c) MockJs.fn = "jest.fn" [@@bs.val]
  (* TODO
  external fn3 : ('a -> 'b -> 'c -> 'd) -> ('a * 'b * 'c) MockJs.fn = "jest.fn" [@@bs.val]
  external fn4 : ('a -> 'b -> 'c -> 'd -> 'e) -> ('a * 'b * 'c * 'd) MockJs.fn = "jest.fn" [@@bs.val]
  external fn5 : ('a -> 'b -> 'c -> 'd -> 'e -> 'f) -> ('a * 'a * 'c * 'd * 'e) MockJs.fn = "jest.fn" [@@bs.val]
  external fn6 : ('a -> 'b -> 'c -> 'd -> 'e -> 'f -> 'g) -> ('a * 'b * 'c * 'd * 'e * 'f) MockJs.fn = "jest.fn" [@@bs.val]
  *)
  (* external isMockFunction : MockJs.fn -> Js.boolean = "jest.isMockFunction" [@@bs.val] *) (* pointless with types? *)
  external mock : string -> unit = "jest.mock" [@@bs.val]
  external mockWithFactory : string -> (unit -> 'a) ->unit = "jest.mock" [@@bs.val]
  external mockVirtual : string -> (unit -> 'a) -> < .. > Js.t -> unit = "jest.mock" [@@bs.val]
  (* TODO If this is merely defined, babel-plugin-jest-hoist fails with "The second argument of `jest.mock` must be a function." Silly thing.
  let mockVirtual : string -> (unit -> 'a) -> unit =
    fun moduleName factory -> mockVirtual moduleName factory [%bs.obj { _virtual = Js.true_ }]
  *)
  external clearAllMocks : unit -> unit = "jest.clearAllMocks" [@@bs.val]
  external resetAllMocks : unit -> unit = "jest.resetAllMocks" [@@bs.val]
  external setMock : string -> < .. > Js.t -> unit = "jest.setMock" [@@bs.val]
  external unmock : string -> unit = "jest.unmock" [@@bs.val]
  external spyOn : (< .. > Js.t as 'this) -> string -> (unit, unit, 'this) MockJs.fn = "jest.spyOn" [@@bs.val] (* this is a bit too dynamic *)
end
