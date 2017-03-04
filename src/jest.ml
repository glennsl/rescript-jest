module Promise = Bs_promise
type ('a, 'e) promise = ('a, 'e) Promise.t

type 'a simple_case =
| Ok
| Fail of string
| Be of 'a * 'a
| Equal of 'a * 'a
| CloseTo of 'a * 'a * int option
| ArrayContains of 'a array * 'a
| Undefined of 'a Js.undefined

type 'a mod_ =
| Just : 'a -> 'a mod_
| Not : 'a -> 'a mod_

let mapMod f = function
| Just a -> Just (f a)
| Not a -> Not (f a)

type 'a case = 'a simple_case mod_
  
module LLExpect = struct
  external expect : 'a -> < .. > Js.t = "" [@@bs.val]
  external fail : string -> unit = "" [@@bs.val]

  let exec: 'a case -> unit = function
  | Just Ok -> ()
  | Not Ok -> fail "not ok"
  | Just Fail message -> fail message
  | Not Fail _ -> ()
  | Just Be (a, b) -> (expect a) ## toBe b
  | Not Be (a, b) -> (expect a) ## not ## toBe b
  | Just Equal (a, b) -> (expect a) ## toEqual b
  | Not Equal (a, b) -> (expect a) ## not ## toEqual b
  | Just CloseTo (a, b, p) -> (expect a) ## toBeCloseTo a b (Js.Undefined.from_opt p)
  | Not CloseTo (a, b, p) -> (expect a) ## not ## toBeCloseTo a b (Js.Undefined.from_opt p)
  | Just ArrayContains (a, b) -> (expect a) ## toContain b
  | Not ArrayContains (a, b) -> (expect a) ## not ## toContain b
  | Just Undefined a -> (expect a) ## toBeUndefined ()
  | Not Undefined a -> (expect a) ## toBeUndefined ()
end

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

module Expect1 = struct
  type 'a partial = 'a mod_
  
  let expect : 'a -> 'a partial = fun a -> Just a
  
  let toBe : 'a -> 'a partial -> 'a case =
    fun b -> mapMod (fun a -> Be (a, b))
  
  let toEqual : 'a -> 'a partial -> 'a case =
    fun b -> mapMod (fun a -> Equal (a, b))
    
  let toBeCloseTo : 'a -> 'a partial -> 'a case =
    fun b -> mapMod (fun a -> CloseTo (a, b, None))
  
  let toBeSoCloseTo : float -> digits:int -> float partial -> float case =
    fun b ~digits -> mapMod (fun a -> CloseTo (a, b, Some digits))
    
  let toContain : 'a -> 'a array partial -> 'a case =
    fun b -> mapMod (fun a -> ArrayContains (a, b))
    
  let not_ : 'a partial -> 'a partial = function
    | Just a -> Not a
    | Not _ -> raise (Invalid_argument "I suck at GADTs")
end

module Expect1_WithoutTo = struct
  include Expect1
  
  let be = toBe
  let equal = toEqual
  let beCloseTo = toBeCloseTo
  let beSoCloseTo = toBeSoCloseTo
  let contain = toContain
  
  let toBe = ()
  let toEqual = ()
  let toBeCloseTo = ()
  let toBeSoCloseTo = ()
  let toContain = ()
end

module Expect2 = struct
  include Expect1_WithoutTo
  
  let expect : 'a -> to_:('a partial -> 'a case) -> 'a case =
    fun a ~to_ -> Just a |> to_
    
  let not_ : ('a partial -> 'a case) -> 'a partial -> 'a case = fun f p ->
    match f p with
    | Just a -> Not a
    | Not _ -> raise (Invalid_argument "I suck at GADTs")
end

module Expect3 = struct
  include Expect1
  
  let expect : 'a -> ('a partial -> 'a case) -> 'a case =
    fun a to_ -> Just a |> to_
    
  let not_ : ('a partial -> 'a case) -> 'a partial -> 'a case = fun f p ->
    match f p with
    | Just a -> Not a
    | Not _ -> raise (Invalid_argument "I suck at GADTs")
end

module Expect4 = struct
  include Expect1_WithoutTo
end

module Expect5 = struct
  type 'a partial =
  | Be of 'a
  | Equal of 'a
  | CloseTo of 'a * int option
  (* | ArrayContains of 'a *)
  
  let expect : ('a * 'a partial) -> 'a case =
    fun (a, partial) ->
      match partial with
      | Be b -> Just (Be (a, b))
      | Equal b -> Just (Equal (a, b))
      | CloseTo (b, p) -> Just (CloseTo (a, b, p))
      (* | ArrayContains b -> Just (ArrayContains (a, b)) *)
      
  let expectNot : ('a * 'a partial) -> 'a case = fun (a, p) ->
    match p with
    | Be b -> Not (Be (a, b))
    | Equal b -> Not (Equal (a, b))
    | CloseTo (b, p) -> Not (CloseTo (a, b, p))
    (* | ArrayContains b -> Not (ArrayContains (a, b)) *)
      
  let toBe : 'a -> 'a partial = fun b -> Be b
  let toEqual : 'a -> 'a partial = fun b -> Equal b
  let toCloseTo : (float as 'a) -> 'a partial = fun b -> CloseTo (b, None)
  let toBeSoCloseTo : (float as 'a) -> digits:int -> 'a partial = fun b ~digits -> CloseTo (b, Some digits)
  (* let toContain : 'a -> 'a partial = fun b -> ArrayContains b *)
end

module Expect6 = struct
  let expect (a: 'a) =
    object
      method toBe (b: 'a) = Just (Be (a, b))
      method toEqual (b: 'a) = Just (Equal (a, b))
      method not =
        object
          method toBe (b: 'a) = Not (Be (a, b))
          method toEqual (b: 'a) = Not (Equal (a, b))
        end
    end
    
  let expectFloat (a: float as 'a) =
    object
      method toBe (b: 'a) = Just (Be (a, b))
      method toEqual (b: 'a) = Just (Equal (a, b))
      method toBeCloseTo (b: 'a) = Just (CloseTo (a, b, None))
      method toBeSoCloseTo (b: 'a) ~digits:(digits:int) = Just (CloseTo (a, b, Some digits))
      method not =
        object
          method toBe (b: 'a) = Not (Be (a, b))
          method toEqual (b: 'a) = Not (Equal (a, b))
          method toBeCloseTo (b: 'a) = Not (CloseTo (a, b, None))
          method toBeSoCloseTo (b: 'a) ~digits:(digits:int) = Not (CloseTo (a, b, Some digits))
        end
    end
    
  let expectArray (a: 'v array as 'a) =
    object
      method toBe (b: 'a) = Just (Be (a, b))
      method toEqual (b: 'a) = Just (Equal (a, b))
      method toContain (b: 'v) = Just (ArrayContains (a, b))
      method not =
        object
          method toBe (b: 'a) = Not (Be (a, b))
          method toEqual (b: 'a) = Not (Equal (a, b))
          method toContain (b: 'v) = Not (ArrayContains (a, b))
        end
    end
end

module Assert1 = struct
  let assertBe a b = Just (Be (a, b))
  let assertNotBe a b = Not (Be (a, b))
  let assertEqual a b = Just (Equal (a, b))
  let assertNotEqual a b = Not (Equal (a, b))
  let assertCloseTo a b = Just (CloseTo (a, b, None))
  let assertNotCloseTo a b = Not (CloseTo (a, b, None))
  let assertSoCloseTo a b ~digits = Just (CloseTo (a, b, Some digits))
  let assertNotSoCloseTo a b ~digits = Not (CloseTo (a, b, Some digits))
  let assertContain a v = Just (ArrayContains (a, v))
  let assertNotContain a v = Not (ArrayContains (a, v))
end

module Assert2 = struct
  module Assert = struct
    let be ~actual:a ~expected:b = Just (Be (a, b))
    let notBe ~actual:a ~expected:b = Not (Be (a, b))
    let equal ~actual:a ~expected:b = Just (Equal (a, b))
    let notEqual ~actual:a ~expected:b = Not (Equal (a, b))
    let closeTo ~actual:a ~expected:b = Just (CloseTo (a, b, None))
    let notCloseTo ~actual:a ~expected:b = Not (CloseTo (a, b, None))
    let soCloseTo ~actual:a ~expected:b ~digits = Just (CloseTo (a, b, Some digits))
    let notSoCloseTo ~actual:a ~expected:b ~digits = Not (CloseTo (a, b, Some digits))
    let contain ~actual:a ~element:v = Just (ArrayContains (a, v))
    let notContain ~actual:a ~element:v = Not (ArrayContains (a, v))
  end
end

module Assert3 = struct
  module Assert = struct
    let be a ~toBe:b = Just (Be (a, b))
    let notBe a ~toNotBe:b = Not (Be (a, b))
    let equal a ~toEqual:b = Just (Equal (a, b))
    let notEqual a ~toNotEqual:b = Not (Equal (a, b))
    let closeTo a ~toBeCloseTo:b = Just (CloseTo (a, b, None))
    let notCloseTo a ~toNotBeCloseTo:b = Not (CloseTo (a, b, None))
    let soCloseTo a ~toBeSoCloseTo:b ~digits = Just (CloseTo (a, b, Some digits))
    let notSoCloseTo a ~toNotBeSoCloseTo:b ~digits = Not (CloseTo (a, b, Some digits))
    let contain a ~toContain:v = Just (ArrayContains (a, v))
    let notContain a ~toNotContain:v = Not (ArrayContains (a, v))
  end
end

module Variant1 = struct
  type 'a t = 'a case (* completely unnecessary, just for "documentation" *)
end

let returnUndefined callback a = callback a; Js.Undefined.empty

external test : string -> (unit -> unit Js.undefined) -> unit = "" [@@bs.val]
let test : string -> (unit -> 'a case) -> unit = fun name callback ->
  test name (returnUndefined (fun () -> LLExpect.exec (callback ())))
external testOnly : string -> (unit -> unit Js.undefined) -> unit = "test.only" [@@bs.val]
let testOnly : string -> (unit -> 'a case) -> unit = fun name callback ->
  testOnly name (returnUndefined (fun () -> LLExpect.exec (callback ())))
external testSkip : string -> (unit -> 'a case) -> unit = "test.skip" [@@bs.val]
    
external testAsync : string -> ((unit -> unit) -> unit Js.undefined) -> unit = "test" [@@bs.val]
let testAsync : string -> (('a case -> unit) -> unit) -> unit = fun name callback ->
  testAsync name (returnUndefined (fun done_ -> callback (fun case -> LLExpect.exec case; done_ ())))
external testAsyncOnly : string -> ((unit -> unit) -> unit Js.undefined) -> unit = "test.only" [@@bs.val]
let testAsyncOnly : string -> (('a case -> unit) -> unit) -> unit = fun name callback ->
  testAsyncOnly name (returnUndefined (fun done_ -> callback (fun case -> LLExpect.exec case; done_ ())))
external testAsyncSkip : string -> (('a case -> unit) -> unit) -> unit = "test.skip" [@@bs.val]

external testPromise : string -> (unit -> ('a, 'e) promise) -> unit = "test" [@@bs.val]
let testPromise : string -> (unit -> ('a case, 'e) promise) -> unit = fun name callback ->
  testPromise name (fun () -> callback () |> Promise.then_ LLExpect.exec)
external testPromiseOnly : string -> (unit -> ('a, 'e) promise) -> unit = "test.only" [@@bs.val]
let testPromiseOnly : string -> (unit -> ('a case, 'e) promise) -> unit = fun name callback ->
  testPromiseOnly name (fun () -> callback () |> Promise.then_ LLExpect.exec)
external testPromiseSkip : string -> (unit -> ('a case, 'e) promise) -> unit = "test.skip" [@@bs.val]

external describe : string -> (unit -> unit) -> unit = "" [@@bs.val]
external describeOnly : string -> (unit -> unit) -> unit = "describe.only" [@@bs.val]
external describeSkip : string -> (unit -> unit) -> unit = "describe.skip" [@@bs.val]

external beforeAll : (unit -> unit) -> unit = "" [@@bs.val]
external beforeEach : (unit -> unit) -> unit = "" [@@bs.val]
external afterAll : (unit -> unit) -> unit = "" [@@bs.val]
external afterEach : (unit -> unit) -> unit = "" [@@bs.val]

module Mock = struct
    type ('fn, 'args, 'ret) fn
    type ('args, 'ret) mock
    
    (* TODO: "... contains type variables cannot be generalized"
    (** Equiavelnt to calling new mock() *)
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
  external disableAutomock : unit -> unit = "jest.disableAutomock" [@@bs.val]
  external enableAutomock : unit -> unit = "jest.enableAutomock" [@@bs.val]
  external inferred_fn : unit -> ('a -> 'b Js.undefined [@bs], 'a, 'b Js.undefined) Mock.fn = "jest.fn" [@@bs.val] (* not sure how useful this really is *)
  external fn : ('a -> 'b) -> ('a -> 'b, 'a, 'b) Mock.fn = "jest.fn" [@@bs.val]
  external fn2 : ('a -> 'b -> 'c [@bs]) -> (('a -> 'b -> 'c [@bs]), 'a * 'b, 'c) Mock.fn = "jest.fn" [@@bs.val]
  (* TODO
  external fn3 : ('a -> 'b -> 'c -> 'd) -> ('a * 'b * 'c) Mock.fn = "jest.fn" [@@bs.val]
  external fn4 : ('a -> 'b -> 'c -> 'd -> 'e) -> ('a * 'b * 'c * 'd) Mock.fn = "jest.fn" [@@bs.val]
  external fn5 : ('a -> 'b -> 'c -> 'd -> 'e -> 'f) -> ('a * 'a * 'c * 'd * 'e) Mock.fn = "jest.fn" [@@bs.val]
  external fn6 : ('a -> 'b -> 'c -> 'd -> 'e -> 'f -> 'g) -> ('a * 'b * 'c * 'd * 'e * 'f) Mock.fn = "jest.fn" [@@bs.val]
  *)
  (* external isMockFunction : Mock.fn -> Js.boolean = "jest.isMockFunction" [@@bs.val] *) (* pointless with types? *)
  external mock : string -> unit = "jest.mock" [@@bs.val]
  external mockWithFactory : string -> (unit -> 'a) ->unit = "jest.mock" [@@bs.val]
  external mockVirtual : string -> (unit -> 'a) -> < .. > Js.t -> unit = "jest.mock" [@@bs.val]
  (* TODO If this is merely defined, babel-plugin-jest-hoist fails with "The second argument of `jest.mock` must be a function." Silly thing.
  let mockVirtual : string -> (unit -> 'a) -> unit =
    fun moduleName factory -> mockVirtual moduleName factory [%bs.obj { _virtual = Js.true_ }]
  *)
  external clearAllMocks : unit -> unit = "jest.clearAllMocks" [@@bs.val]
  external resetAllMocks : unit -> unit = "jest.resetAllMocks" [@@bs.val]
  external resetModules : unit -> unit = "jest.resetModules" [@@bs.val]
  external runAllTicks : unit -> unit = "jest.runAllTicks" [@@bs.val]
  external runAllTimers : unit -> unit = "jest.runAllTimers" [@@bs.val]
  external runAllImmediates : unit -> unit = "jest.runAllImmediates" [@@bs.val]
  external runTimersToTime : int -> unit = "jest.runTimersToTime" [@@bs.val]
  external runOnlyPendingTimers : unit -> unit = "jest.runOnlyPendingTimers" [@@bs.val]
  external setMock : string -> < .. > Js.t -> unit = "jest.setMock" [@@bs.val]
  external unmock : string -> unit = "jest.unmock" [@@bs.val]
  external useFakeTimers : unit -> unit = "jest.useFakeTimers" [@@bs.val]
  external useRealTimers : unit -> unit = "jest.useRealTimers" [@@bs.val]
  external spyOn : (< .. > Js.t as 'this) -> string -> (unit, unit, 'this) Mock.fn = "jest.spyOn" [@@bs.val] (* this is a bit too dynamic *)
end
