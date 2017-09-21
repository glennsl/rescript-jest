type 'a simpleAssertion =
| Ok : 'a simpleAssertion
| Fail : string -> 'a simpleAssertion
| ArrayContains : 'a array * 'a -> 'a simpleAssertion
| ArrayLength : 'a array * int -> 'a simpleAssertion
| ArraySuperset : 'a array * 'a array -> 'a simpleAssertion
| Be : 'a * 'a -> 'a simpleAssertion
| Defined : 'a Js.undefined -> 'a simpleAssertion
| Equal : 'a * 'a -> 'a simpleAssertion
| Falsy : 'a -> 'a simpleAssertion
| FloatCloseTo : float * float * int option -> 'a simpleAssertion
| GreaterThan : 'a * 'a -> 'a simpleAssertion
| GreaterThanOrEqual : 'a * 'a -> 'a simpleAssertion
| LessThan : 'a * 'a -> 'a simpleAssertion
| LessThanOrEqual : 'a * 'a -> 'a simpleAssertion
| MatchSnapshot : 'a -> 'a simpleAssertion
| MatchSnapshotName : 'a * string -> 'a simpleAssertion
| Null : 'a Js.null -> 'a simpleAssertion
| ObjectContains : 'a Js.t * string array -> 'a simpleAssertion
| ObjectMatch : < .. > Js.t * < .. > Js.t -> 'a simpleAssertion
| StringContains : string * string -> 'a simpleAssertion
| StringMatch : string * Js.Re.t -> 'a simpleAssertion
| Throws : (unit -> 'b) -> 'a simpleAssertion
(*| ThrowsException : (unit -> unit) * exn -> 'a simpleAssertion*)
| ThrowsMatchSnapshot : (unit -> 'b) -> 'a simpleAssertion
| ThrowsMessage : (unit -> 'b) * string -> 'a simpleAssertion
| ThrowsMessageRe : (unit -> 'b) * Js.Re.t -> 'a simpleAssertion
| Truthy : 'a -> 'a simpleAssertion
| Undefined : 'a Js.undefined -> 'a simpleAssertion

type 'a modifier =
| Just of 'a
| Not of 'a

type 'a assertion = 'a simpleAssertion modifier

let mapMod f = function
| Just a -> Just (f a)
| Not a -> Not (f a)
  
module type Asserter = sig
  type 'a t
  val assert_ : 'a t -> unit
end

(* internal *)
module LLExpect : sig
  type 'a t = 'a assertion
  val assert_ : 'a t -> unit
end = struct
  type 'a t = 'a assertion
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

  let assert_ = function
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
  | Just FloatCloseTo (a, b, p) -> (expect a) ## toBeCloseTo b (Js.Undefined.from_opt p)
  | Not FloatCloseTo (a, b, p) -> (expect a) ## not ## toBeCloseTo b (Js.Undefined.from_opt p)
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
  | Just ObjectMatch (a, b) -> (expect a) ## toMatchObject b
  | Not ObjectMatch (a, b) -> (expect a) ## not ## toMatchObject b
  | Just StringMatch (s, re) -> (expect s) ## toMatch re
  | Not StringMatch (s, re) -> (expect s) ## not ## toMatch re
  | Just StringContains (a, b) -> (expect a) ## toEqual (stringContaining b)
  | Not StringContains (a, b) -> (expect a) ## not ## toEqual (stringContaining b)
  | Just Throws f -> (expect f) ## toThrow ()
  | Not Throws f -> (expect f) ## not ## toThrow ()
  (*
  | Just ThrowsException (f, e) -> (expect f) ## toThrow e
  | Not ThrowsException (f, e) -> (expect f) ## not ## toThrow e
  *)
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
  external _test : string -> (unit -> unit Js.undefined) -> unit = "test" [@@bs.val]
  external _testAsync : string -> ((unit -> unit) -> unit Js.undefined) -> unit = "test" [@@bs.val]
  external _testPromise : string -> (unit -> 'a Js.Promise.t) -> unit = "test" [@@bs.val]

  let test name callback =
    _test name (fun () ->
      A.assert_ @@ callback ();
      Js.undefined)
      
  let testAsync name callback =
    _testAsync name (fun done_ ->
      callback (fun case ->
        A.assert_ case;
        done_ ());
      Js.undefined)

  let testPromise name callback =
    _testPromise name (fun () ->
      callback () |> Js.Promise.then_ (fun a -> a |> A.assert_ |> Js.Promise.resolve))

  let testAll name inputs callback =
    inputs |> List.iter (fun input ->
      let name = {j|$name - $input|j} in
      _test name (fun () ->
        A.assert_ @@ callback input;
        Js.undefined))

  external describe : string -> (unit -> unit) -> unit = "" [@@bs.val]

  external beforeAll : (unit -> unit) -> unit = "" [@@bs.val]
  external beforeEach : (unit -> unit) -> unit = "" [@@bs.val]
  external afterAll : (unit -> unit) -> unit = "" [@@bs.val]
  external afterEach : (unit -> unit) -> unit = "" [@@bs.val]

  module Only = struct
    external _test : string -> (unit -> unit Js.undefined) -> unit = "test.only" [@@bs.val]
    external _testAsync : string -> ((unit -> unit) -> unit Js.undefined) -> unit = "test.only" [@@bs.val]
    external _testPromise : string -> (unit -> 'a Js.Promise.t) -> unit = "test.only" [@@bs.val]

    let test name callback =
      _test name (fun () ->
        A.assert_ @@ callback ();
        Js.undefined)

    let testAsync name callback =
      _testAsync name (fun done_ ->
        callback (fun assertion ->
          A.assert_ assertion;
          done_ ());
        Js.undefined)

    let testPromise name callback =
      _testPromise name (fun () ->
        callback () |> Js.Promise.then_ (fun a -> a |> A.assert_ |> Js.Promise.resolve))

    let testAll name inputs callback =
      inputs |> List.iter (fun input ->
        let name = {j|$name - $input|j} in
        _test name (fun () ->
          A.assert_ @@ callback input;
          Js.undefined))

    external describe : string -> (unit -> unit) -> unit = "describe.only" [@@bs.val]
  end

  module Skip = struct
    external test : string -> (unit -> 'a A.t) -> unit = "test.skip" [@@bs.val]
    external testAsync : string -> (('a A.t -> unit) -> unit) -> unit = "test.skip" [@@bs.val]
    external testPromise : string -> (unit -> 'a A.t Js.Promise.t) -> unit = "test.skip" [@@bs.val]
    external testAll : string -> 'a list -> ('a -> 'b A.t) -> unit = "test.skip" [@@bs.val]
    external describe : string -> (unit -> unit) -> unit = "describe.skip" [@@bs.val]
  end
end

include Runner(LLExpect)

let pass = Just Ok
let fail message = Just (Fail message)

external testOnly : string -> (unit -> unit Js.undefined) -> unit = "test.only" [@@bs.val]
let testOnly name callback =
  testOnly name (fun () -> LLExpect.assert_ @@ callback (); Js.undefined)
[@@ocaml.deprecated "Use `Only.test` instead"]
external testSkip : string -> (unit -> 'a assertion) -> unit = "test.skip" [@@bs.val]
[@@ocaml.deprecated "Use `Skip.test` instead"]

external testAsyncOnly : string -> ((unit -> unit) -> unit Js.undefined) -> unit = "test.only" [@@bs.val]
let testAsyncOnly name callback =
  testAsyncOnly name (fun done_ -> callback (fun assertion -> LLExpect.assert_ assertion; done_ ()); Js.undefined)
[@@ocaml.deprecated "Use `Only.testAsync` instead"]
external testAsyncSkip : string -> (('a assertion -> unit) -> unit) -> unit = "test.skip" [@@bs.val]
[@@ocaml.deprecated "Use `Skip.testAsync` instead"]

external testPromiseOnly : string -> (unit -> 'a Js.Promise.t) -> unit = "test.only" [@@bs.val]
let testPromiseOnly name callback =
  testPromiseOnly name (fun () -> callback () |> Js.Promise.then_ (fun assertion -> Js.Promise.resolve @@ LLExpect.assert_ assertion))
[@@ocaml.deprecated "Use `Only.testPromise` instead"]
external testPromiseSkip : string -> (unit -> 'a assertion Js.Promise.t) -> unit = "test.skip" [@@bs.val]
[@@ocaml.deprecated "Use `Skip.testPromise` instead"]

external describeOnly : string -> (unit -> unit) -> unit = "describe.only" [@@bs.val]
[@@ocaml.deprecated "Use `Only.describe` instead"]
external describeSkip : string -> (unit -> unit) -> unit = "describe.skip" [@@bs.val]
[@@ocaml.deprecated "Use `Skip.describe` instead"]

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
  type 'a partial = 'a modifier
  
  let expect a =
    Just a

  let expectFn f a =
    Just (fun () -> f a)
  
  let toBe b =
    mapMod (fun a -> Be (a, b))

  (* toHaveBeenCalled* *)
  
  let toBeCloseTo b =
    mapMod (fun a -> FloatCloseTo (a, b, None))
  
  let toBeSoCloseTo b ~digits =
    mapMod (fun a -> FloatCloseTo (a, b, Some digits))

  let toBeGreaterThan b =
    mapMod (fun a -> GreaterThan (a, b))

  let toBeGreaterThanOrEqual b =
    mapMod (fun a -> GreaterThanOrEqual (a, b))

  let toBeLessThan b =
    mapMod (fun a -> LessThan (a, b))

  let toBeLessThanOrEqual b =
    mapMod (fun a -> LessThanOrEqual (a, b))

  (** replaces expect.arrayContaining *)
  let toBeSupersetOf b =
    mapMod (fun a -> ArraySuperset (a, b))

  let toContain b =
    mapMod (fun a -> ArrayContains (a, b))

  (** replaces expect.stringContaining *)
  let toContainString b =
    mapMod (fun a -> StringContains (a, b))

  let toEqual b =
    mapMod (fun a -> Equal (a, b))

  let toHaveLength l =
    mapMod (fun a -> ArrayLength (a, l))

  let toMatch s =
    mapMod (fun a -> StringMatch (a, Js.Re.fromString s))

  let toMatchRe re =
    mapMod (fun a -> StringMatch (a, re))

  let toMatchSnapshot =
    fun a -> mapMod (fun a -> MatchSnapshot a) a

  let toMatchSnapshotWithName name =
    mapMod (fun a -> MatchSnapshotName (a, name))

  let toThrow: (unit -> 'a) partial -> unit assertion = function
    | Just a -> Just (Throws a)
    | Not a -> Not (Throws a)
  
  let toThrowErrorMatchingSnapshot = function
    | Just a -> Just (ThrowsMatchSnapshot a)
    | Not a -> Not (ThrowsMatchSnapshot a)

  (*let toThrowException : exn -> (unit -> unit) partial -> (unit -> unit) matchSpec =
    fun e -> mapMod (fun f -> ThrowsException (f, e))*)

  let toThrowMessage message = function
    | Just a -> Just (ThrowsMessage (a, message))
    | Not a -> Not (ThrowsMessage (a, message))

  let toThrowMessageRe re = function
    | Just a -> Just (ThrowsMessageRe (a, re))
    | Not a -> Not (ThrowsMessageRe (a, re))

  let not_ = function
    | Just a -> Not a
    | Not _ -> raise (Invalid_argument "I suck at GADTs")


  module Operators = struct
    (** experimental *)

    let (==) = fun a b -> toBe b a
    let (>)  = fun a b -> toBeGreaterThan b a
    let (>=) = fun a b -> toBeGreaterThanOrEqual b a
    let (<)  = fun a b -> toBeLessThan b a
    let (<=) = fun a b -> toBeLessThanOrEqual b a
    let (=)  = fun a b -> toEqual b a
    let (<>) = fun a b -> a |> not_ |> toEqual b
    let (!=) = fun a b -> a |> not_ |> toBe b
  end
end

module ExpectJs = struct
  include Expect

  let toBeDefined =
    fun a -> mapMod (fun a -> Defined a) a

  let toBeFalsy =
    fun a -> mapMod (fun a -> Falsy a) a

  (* toBeInstanceOf *)

  let toBeNull =
    fun a -> mapMod (fun a -> Null a) a

  let toBeTruthy =
    fun a -> mapMod (fun a -> Truthy a) a

  let toBeUndefined =
    fun a -> mapMod (fun a -> Undefined a) a

  (** replaces expect.objectContaining *)
  let toContainProperties props =
    mapMod (fun a -> ObjectContains (a, props))

  let toMatchObject b =
    mapMod (fun a -> ObjectMatch (a, b))
end

module MockJs = struct
  (** experimental *)

  type ('fn, 'args, 'ret) fn
  
  (* TODO: "... contains type variables cannot be generalized"
  (** Equiavlent to calling new mock() *)
  let make : ('fn, _, _) fn -> 'fn = [%bs.raw {|
    function(self) {
      return new (Function.prototype.bind.apply(self, arguments));
    }
  |}]
  *)
  
  external fn : ('fn, _, _) fn -> 'fn = "%identity"
  external calls : (_, 'args, _) fn -> 'args array = "" [@@bs.get] [@@bs.scope "mock"]
  let calls self = Js.Array.copy (calls self) (* Awesome, the bloody things are mutated so we need to copy *)
  let calls self = calls self |> Array.map [%bs.raw {|
    function (args) { return args.length === 1 ? args[0] : args }
  |}] (* there's no such thing as aa 1-ary tuple, so we need to unbox single-element arrays *)
  external instances : (_, _, 'ret) fn -> 'ret array = "" [@@bs.get] [@@bs.scope "mock"] (* TODO: semms this only records "instances" created by `new` *)
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
