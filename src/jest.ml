
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
| Null of 'a Js.null
| ObjectContains of 'a Js.t * string array
| StringContains of string * string
| StringMatch of string * Js.Re.t
| Truthy of 'a
| Undefined of 'a Js.undefined

type 'a matchModifier =
| Just : 'a -> 'a matchModifier
| Not : 'a -> 'a matchModifier

let mapMod f = function
| Just a -> Just (f a)
| Not a -> Not (f a)

type 'a matchSpec = 'a simpleMatchSpec matchModifier
  
module LLExpect : sig
  val exec : 'a matchSpec -> unit
end = struct
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

  let exec: 'a matchSpec -> unit = function
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
  | Just Null a -> (expect a) ## toBeNull ()
  | Not Null a -> (expect a) ## not ## toBeNull ()
  | Just ObjectContains (a, props) -> (expect a) ## toEqual (objectContaining props)
  | Not ObjectContains (a, props) -> (expect a) ## not ## toEqual (objectContaining props)
  | Just StringMatch (s, re) -> (expect s) ## toMatch re
  | Not StringMatch (s, re) -> (expect s) ## not ## toMatch re
  | Just StringContains (a, b) -> (expect a) ## toEqual (stringContaining b)
  | Not StringContains (a, b) -> (expect a) ## not ## toEqual (stringContaining b)
  | Just Truthy a -> (expect a) ## toBeTruthy ()
  | Not Truthy a -> (expect a) ## not ## toBeTruthy ()
  | Just Undefined a -> (expect a) ## toBeUndefined ()
  | Not Undefined a -> (expect a) ## not ## toBeUndefined ()
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
  type 'a partial = 'a matchModifier
  
  let expect : 'a -> 'a partial = fun a -> Just a
  
  let toBe : 'a -> 'a partial -> 'a matchSpec =
    fun b -> mapMod (fun a -> Be (a, b))
  let (==) = fun a b -> toBe b a

  (* toHaveBeenCalled* *)
  
  let toBeCloseTo : 'a -> 'a partial -> 'a matchSpec =
    fun b -> mapMod (fun a -> FloatCloseTo (a, b, None))
  
  let toBeSoCloseTo : float -> digits:int -> float partial -> float matchSpec =
    fun b ~digits -> mapMod (fun a -> FloatCloseTo (a, b, Some digits))

  let toBeDefined : 'a Js.undefined partial -> 'a matchSpec =
    fun a -> mapMod (fun a -> Defined a) a

  let toBeFalsy : 'a partial -> 'a matchSpec = (* js-y *)
    fun a -> mapMod (fun a -> Falsy a) a

  let toBeGreaterThan : 'a -> 'a partial -> 'a matchSpec =
    fun b -> mapMod (fun a -> GreaterThan (a, b))
  let (>) = fun a b -> toBeGreaterThan b a

  let toBeGreaterThanOrEqual : 'a -> 'a partial -> 'a matchSpec =
    fun b -> mapMod (fun a -> GreaterThanOrEqual (a, b))
  let (>=) = fun a b -> toBeGreaterThanOrEqual b a

  let toBeLessThan : 'a -> 'a partial -> 'a matchSpec =
    fun b -> mapMod (fun a -> LessThan (a, b))
  let (<) = fun a b -> toBeLessThan b a

  let toBeLessThanOrEqual : 'a -> 'a partial -> 'a matchSpec =
    fun b -> mapMod (fun a -> LessThanOrEqual (a, b))
  let (<=) = fun a b -> toBeLessThanOrEqual b a

  (* toBeInstanceOf *) (* js-y *)

  let toBeNull : 'a Js.null partial -> 'a matchSpec =
    fun a -> mapMod (fun a -> Null a) a

  (** replaces expect.arrayContaining *)
  let toBeSupersetOf : 'a array -> 'a array partial -> 'a matchSpec =
    fun b -> mapMod (fun a -> ArraySuperset (a, b))

  let toBeTruthy : 'a partial -> 'a matchSpec = (* js-y *)
    fun a -> mapMod (fun a -> Truthy a) a

  let toBeUndefined : 'a Js.undefined partial -> 'a matchSpec =
    fun a -> mapMod (fun a -> Undefined a) a

  let toContain : 'a -> 'a array partial -> 'a matchSpec =
    fun b -> mapMod (fun a -> ArrayContains (a, b))

  (** replaces expect.stringContaining *)
  let toContainString : string -> string partial -> 'a matchSpec =
    fun b -> mapMod (fun a -> StringContains (a, b))

  (** replaces expect.stringContaining *)
  let toContainProperties : string array -> 'a Js.t partial -> 'a matchSpec = (* js-y *)
    fun props -> mapMod (fun a -> ObjectContains (a, props))

  let toEqual : 'a -> 'a partial -> 'a matchSpec =
    fun b -> mapMod (fun a -> Equal (a, b))
  let (=) = fun a b -> toEqual b a

  let toHaveLength : int -> 'a array partial -> 'a matchSpec =
    fun l -> mapMod (fun a -> ArrayLength (a, l))

  let toMatch : string -> string partial -> string matchSpec =
    fun s -> mapMod (fun a -> StringMatch (a, Js.Re.fromString s))

  let toMatchRe : Js.Re.t -> string partial -> string matchSpec =
    fun re -> mapMod (fun a -> StringMatch (a, re))

  (* toMatchObject *) (* js-y *)
  (* toMatchSnaphsot *)
  (* toThrow *) (* js-y? *)
  (* toThrowErrorMatchingSnapshot *) (* js-y? *)

  let not_ : 'a partial -> 'a partial = function
    | Just a -> Not a
    | Not _ -> raise (Invalid_argument "I suck at GADTs")
    let (<>) = fun a b -> a |> not_ |> toEqual b
    let (!=) = fun a b -> a |> not_ |> toBe b
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
  
  let expect : 'a -> to_:('a partial -> 'a matchSpec) -> 'a matchSpec =
    fun a ~to_ -> Just a |> to_
    
  let not_ : ('a partial -> 'a matchSpec) -> 'a partial -> 'a matchSpec = fun f p ->
    match f p with
    | Just a -> Not a
    | Not _ -> raise (Invalid_argument "I suck at GADTs")
end

module Expect3 = struct
  include Expect1
  
  let expect : 'a -> ('a partial -> 'a matchSpec) -> 'a matchSpec =
    fun a to_ -> Just a |> to_
    
  let not_ : ('a partial -> 'a matchSpec) -> 'a partial -> 'a matchSpec = fun f p ->
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
  (* | CloseTo of 'a * int option *)
  (* | ArrayContains of 'a *)
  
  let expect : ('a * 'a partial) -> 'a matchSpec =
    fun (a, partial) ->
      match partial with
      | Be b -> Just (Be (a, b))
      | Equal b -> Just (Equal (a, b))
      (* | CloseTo (b, p) -> Just (FloatCloseTo (a, b, p)) *)
      (* | ArrayContains b -> Just (ArrayContains (a, b)) *)
      
  let expectNot : ('a * 'a partial) -> 'a matchSpec = fun (a, p) ->
    match p with
    | Be b -> Not (Be (a, b))
    | Equal b -> Not (Equal (a, b))
    (* | CloseTo (b, p) -> Not (FloatCloseTo (a, b, p)) *)
    (* | ArrayContains b -> Not (ArrayContains (a, b)) *)
      
  let toBe : 'a -> 'a partial = fun b -> Be b
  let toEqual : 'a -> 'a partial = fun b -> Equal b
  (*)
  let toBeCloseTo : (float as 'a) -> 'a partial = fun b -> CloseTo (b, None)
  let toBeSoCloseTo : (float as 'a) -> digits:int -> 'a partial = fun b ~digits -> CloseTo (b, Some digits)
  *)
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
      method toBeCloseTo (b: 'a) = Just (FloatCloseTo (a, b, None))
      method toBeSoCloseTo (b: 'a) ~digits:(digits:int) = Just (FloatCloseTo (a, b, Some digits))
      method not =
        object
          method toBe (b: 'a) = Not (Be (a, b))
          method toEqual (b: 'a) = Not (Equal (a, b))
          method toBeCloseTo (b: 'a) = Not (FloatCloseTo (a, b, None))
          method toBeSoCloseTo (b: 'a) ~digits:(digits:int) = Not (FloatCloseTo (a, b, Some digits))
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
  let assertCloseTo a b = Just (FloatCloseTo (a, b, None))
  let assertNotCloseTo a b = Not (FloatCloseTo (a, b, None))
  let assertSoCloseTo a b ~digits = Just (FloatCloseTo (a, b, Some digits))
  let assertNotSoCloseTo a b ~digits = Not (FloatCloseTo (a, b, Some digits))
  let assertContain a v = Just (ArrayContains (a, v))
  let assertNotContain a v = Not (ArrayContains (a, v))
end

module Assert2 = struct
  module Assert = struct
    let be ~actual:a ~expected:b = Just (Be (a, b))
    let notBe ~actual:a ~expected:b = Not (Be (a, b))
    let equal ~actual:a ~expected:b = Just (Equal (a, b))
    let notEqual ~actual:a ~expected:b = Not (Equal (a, b))
    let closeTo ~actual:a ~expected:b = Just (FloatCloseTo (a, b, None))
    let notCloseTo ~actual:a ~expected:b = Not (FloatCloseTo (a, b, None))
    let soCloseTo ~actual:a ~expected:b ~digits = Just (FloatCloseTo (a, b, Some digits))
    let notSoCloseTo ~actual:a ~expected:b ~digits = Not (FloatCloseTo (a, b, Some digits))
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
    let closeTo a ~toBeCloseTo:b = Just (FloatCloseTo (a, b, None))
    let notCloseTo a ~toNotBeCloseTo:b = Not (FloatCloseTo (a, b, None))
    let soCloseTo a ~toBeSoCloseTo:b ~digits = Just (FloatCloseTo (a, b, Some digits))
    let notSoCloseTo a ~toNotBeSoCloseTo:b ~digits = Not (FloatCloseTo (a, b, Some digits))
    let contain a ~toContain:v = Just (ArrayContains (a, v))
    let notContain a ~toNotContain:v = Not (ArrayContains (a, v))
  end
end

module Assert4 = struct
  module Assert = struct
    let toBe b a = Just (Be (a, b))
    let toNotBe b a = Not (Be (a, b))
    let toEqual b a = Just (Equal (a, b))
    let toNotEqual b a = Not (Equal (a, b))
    let toCloseTo b a = Just (FloatCloseTo (a, b, None))
    let toNotCloseTo b a = Not (FloatCloseTo (a, b, None))
    let toBeSoCloseTo b a ~digits = Just (FloatCloseTo (a, b, Some digits))
    let toNotBeSoCloseTo b a ~digits = Not (FloatCloseTo (a, b, Some digits))
    let toContain v a = Just (ArrayContains (a, v))
    let toNotContain v a = Not (ArrayContains (a, v))
  end
end

module Variant1 = struct
  type 'a t = 'a matchSpec (* completely unnecessary, just for "documentation" *)
end

let returnUndefined callback a = callback a; Js.Undefined.empty

external test : string -> (unit -> unit Js.undefined) -> unit = "" [@@bs.val]
let test : string -> (unit -> 'a matchSpec) -> unit = fun name callback ->
  test name (returnUndefined (fun () -> LLExpect.exec (callback ())))
external testOnly : string -> (unit -> unit Js.undefined) -> unit = "test.only" [@@bs.val]
let testOnly : string -> (unit -> 'a matchSpec) -> unit = fun name callback ->
  testOnly name (returnUndefined (fun () -> LLExpect.exec (callback ())))
external testSkip : string -> (unit -> 'a matchSpec) -> unit = "test.skip" [@@bs.val]
    
external testAsync : string -> ((unit -> unit) -> unit Js.undefined) -> unit = "test" [@@bs.val]
let testAsync : string -> (('a matchSpec -> unit) -> unit) -> unit = fun name callback ->
  testAsync name (returnUndefined (fun done_ -> callback (fun case -> LLExpect.exec case; done_ ())))
external testAsyncOnly : string -> ((unit -> unit) -> unit Js.undefined) -> unit = "test.only" [@@bs.val]
let testAsyncOnly : string -> (('a matchSpec -> unit) -> unit) -> unit = fun name callback ->
  testAsyncOnly name (returnUndefined (fun done_ -> callback (fun case -> LLExpect.exec case; done_ ())))
external testAsyncSkip : string -> (('a matchSpec -> unit) -> unit) -> unit = "test.skip" [@@bs.val]

external testPromise : string -> (unit -> ('a, 'e) promise) -> unit = "test" [@@bs.val]
let testPromise : string -> (unit -> ('a matchSpec, 'e) promise) -> unit = fun name callback ->
  testPromise name (fun () -> callback () |> Promise.then_ LLExpect.exec)
external testPromiseOnly : string -> (unit -> ('a, 'e) promise) -> unit = "test.only" [@@bs.val]
let testPromiseOnly : string -> (unit -> ('a matchSpec, 'e) promise) -> unit = fun name callback ->
  testPromiseOnly name (fun () -> callback () |> Promise.then_ LLExpect.exec)
external testPromiseSkip : string -> (unit -> ('a matchSpec, 'e) promise) -> unit = "test.skip" [@@bs.val]

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

