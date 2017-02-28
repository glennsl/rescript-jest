module Promise = Bs_promise
type ('a, 'e) promise = ('a, 'e) Promise.t

type 'a simple_case =
| StrictEqual of 'a * 'a
| Equal of 'a * 'a
| CloseTo of 'a * 'a * int option

type 'a mod_ =
| Just : 'a -> 'a mod_
| Not : 'a -> 'a mod_

let mapMod f = function
| Just a -> Just (f a)
| Not a -> Not (f a)

type 'a case = 'a simple_case mod_
  
module LLExpect = struct
  external expect : 'a -> < .. > Js.t = "" [@@bs.val]

  let exec: 'a case -> unit = function
  | Just StrictEqual (a, b) -> (expect a) ## toBe b
  | Not StrictEqual (a, b) -> (expect a) ## not ## toBe b
  | Just Equal (a, b) -> (expect a) ## toEqual b
  | Not Equal (a, b) -> (expect a) ## not ## toEqual b
  | Just CloseTo (a, b, p) -> (expect a) ## toBeCloseTo a b (Js.Undefined.from_opt p)
  | Not CloseTo (a, b, p) -> (expect a) ## not ## toBeCloseTo a b (Js.Undefined.from_opt p)
end

module Expect1 = struct
  type 'a partial = 'a mod_
  
  let expect : 'a -> 'a partial = fun a -> Just a
  
  let toBe : 'a -> 'a partial -> 'a case =
    fun b -> mapMod (fun a -> StrictEqual (a, b))
  
  let toEqual : 'a -> 'a partial -> 'a case =
    fun b -> mapMod (fun a -> Equal (a, b))
    
  let toBeCloseTo : 'a -> 'a partial -> 'a case =
    fun b -> mapMod (fun a -> CloseTo (a, b, None))
  
  let toBeSoCloseTo : 'a -> digits:int -> 'a partial -> 'a case =
    fun b ~digits -> mapMod (fun a -> CloseTo (a, b, Some digits))
    
  let not_ : 'a partial -> 'a partial = function
    | Just a -> Not a
    | Not _ -> raise (Invalid_argument "I suck at GADTs")
end

module Expect1_NoTo = struct
  include Expect1
  
  let be = toBe
  let equal = toEqual
  let beCloseTo = toBeCloseTo
  let beSoCloseTo = toBeSoCloseTo
  
  let toBe = ()
  let toEqual = ()
  let toBeCloseTo = ()
  let toBeSoCloseTo = ()
end

module Expect2 = struct
  include Expect1_NoTo
  
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
  include Expect1_NoTo
end

module Expect5 = struct
  type 'a partial =
  | StrictEqual of 'a
  | Equal of 'a
  | CloseTo of 'a * int option

  let expect : ('a * 'a partial) -> 'a case =
    fun (a, partial) ->
      match partial with
      | StrictEqual b -> Just (StrictEqual (a, b))
      | Equal b -> Just (Equal (a, b))
      | CloseTo (b, p) -> Just (CloseTo (a, b, p))

  let expectNot : ('a * 'a partial) -> 'a case = fun (a, p) ->
    match p with
    | StrictEqual b -> Not (StrictEqual (a, b))
    | Equal b -> Not (Equal (a, b))
    | CloseTo (b, p) -> Not (CloseTo (a, b, p))
      
  let toBe : 'a -> 'a partial = fun b -> StrictEqual b
  let toEqual : 'a -> 'a partial = fun b -> Equal b
  let toCloseTo : 'a -> 'a partial = fun b -> CloseTo (b, None)
  let toBeSoCloseTo : 'a -> digits:int -> 'a partial = fun b ~digits -> CloseTo (b, Some digits)
end

module Expect6 = struct
  let expect (a: 'a) =
    object
      method toBe (b: 'a) = Just (StrictEqual (a, b))
      method toEqual (b: 'a) = Just (Equal (a, b))
      method toBeCloseTo (b: 'a) = Just (CloseTo (a, b, None))
      method toBeSoCloseTo (b: 'a) ~digits:(digits:int) = Just (CloseTo (a, b, Some digits))
      method not =
        object
          method toBe (b: 'a) = Not (StrictEqual (a, b))
          method toEqual (b: 'a) = Not (Equal (a, b))
          method toBeCloseTo (b: 'a) = Not (CloseTo (a, b, None))
          method toBeSoCloseTo (b: 'a) ~digits:(digits:int) = Not (CloseTo (a, b, Some digits))
        end
    end
end

external test : string -> (unit -> unit) -> unit = "" [@@bs.val]
let test : string -> (unit -> 'a case) -> unit = fun name callback ->
  test name (fun () -> LLExpect.exec (callback ()))
external testOnly : string -> (unit -> unit) -> unit = "test.only" [@@bs.val]
let testOnly : string -> (unit -> 'a case) -> unit = fun name callback ->
  testOnly name (fun () -> LLExpect.exec (callback ()))
external testSkip : string -> (unit -> 'a case) -> unit = "test.skip" [@@bs.val]
    
external testAsync : string -> ((unit -> unit) -> unit) -> unit = "test" [@@bs.val]
let testAsync : string -> (('a case -> unit) -> unit) -> unit = fun name callback ->
  testAsync name (fun done_ -> callback (fun case -> LLExpect.exec case; done_ ()))
external testAsyncOnly : string -> ((unit -> unit) -> unit) -> unit = "test.only" [@@bs.val]
let testAsyncOnly : string -> (('a case -> unit) -> unit) -> unit = fun name callback ->
  testAsyncOnly name (fun done_ -> callback (fun case -> LLExpect.exec case; done_ ()))
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
    type ('fn, 'args) mock
    
    external mock : ('fn, 'args, _) fn -> ('fn, 'args) mock = "" [@@bs.get]
    external calls : (_, 'args) mock -> 'args array = "" [@@bs.get]
    external instances : ('fn, _) mock -> 'fn array = "" [@@bs.get]
    (* "Type variables cannot be generalized"
    let calls : 'args fn -> 'args = [%bs.raw {|
      function (fn) { fn.mock.calls; }()
    |}]
    let instances : _ fn -> 'a = [%bs.raw {|
      function (fn) { fn.mock.instances; }()
    |}]
    *)
    
    external mockClear : unit = "" [@@bs.send.pipe: _ fn]
    external mockReset : unit = "" [@@bs.send.pipe: _ fn]
    external mockImplementation : 'fn -> unit = "" [@@bs.send.pipe: ('fn, _, _) fn]
    external mockImplementationOnce : 'fn -> unit = "" [@@bs.send.pipe: ('fn, _, _) fn]
    external mockReturnThis : unit = "" [@@bs.send.pipe: (_, _, 'ret) fn] (* not type safe, we don't know what `this` actually is *)
    external mockReturnValue : 'ret -> unit = "" [@@bs.send.pipe: (_, _, 'ret) fn]
    external mockReturnValueOnce : 'ret -> unit = "" [@@bs.send.pipe: (_, _, 'ret) fn]
end

module Jest = struct
  external clearAllTimers : unit -> unit = "jest.clearAllTimers" [@@bs.val]
  external disableAutomock : unit -> unit = "jest.disableAutomock" [@@bs.val]
  external enableAutomock : unit -> unit = "jest.enableAutomock" [@@bs.val]
  external fn : ('a -> 'b) -> ('a -> 'b, 'a, 'b) Mock.fn = "jest.fn" [@@bs.val]
  external fn2 : ('a -> 'b -> 'c) -> ('a -> 'b -> 'c, 'a * 'b, 'c) Mock.fn = "jest.fn" [@@bs.val]
  (*
  external fn3 : ('a -> 'b -> 'c -> 'd) -> ('a * 'b * 'c) Mock.fn = "jest.fn" [@@bs.val]
  external fn4 : ('a -> 'b -> 'c -> 'd -> 'e) -> ('a * 'b * 'c * 'd) Mock.fn = "jest.fn" [@@bs.val]
  external fn5 : ('a -> 'b -> 'c -> 'd -> 'e -> 'f) -> ('a * 'a * 'c * 'd * 'e) Mock.fn = "jest.fn" [@@bs.val]
  external fn6 : ('a -> 'b -> 'c -> 'd -> 'e -> 'f -> 'g) -> ('a * 'b * 'c * 'd * 'e * 'f) Mock.fn = "jest.fn" [@@bs.val]
  *)
  (* external isMockFunction : Mock.fn -> Js.boolean = "jest.isMockFunction" [@@bs.val] *) (* pointless with types? *)
  external mock : string -> unit = "jest.mock" [@@bs.val]
  external mockWithFactory : string -> (unit -> 'a) ->unit = "jest.mock" [@@bs.val]
  (* If this is merely defined, babel-plugin-jest-hoist fails with "The second argument of `jest.mock` must be a function." Silly thing.
  external mockVirtual : string -> (unit -> 'a) -> < .. > Js.t -> unit = "jest.mock" [@@bs.val]
  let mockVirtual : string -> (unit -> 'a) -> unit =
    fun moduleName factory -> mockVirtual moduleName factory [%bs.obj { _virtual = Js.true_ }]
  *)
  external clearAllMocks : unit -> unit = "jest.clearAllMocks" [@@bs.val]
  external resetAllMocks : unit -> unit = "jest.resetAllMocks" [@@bs.val]
  external resetModules : unit -> unit = "jest.resetModules" [@@bs.val]
  external runAllTicks : unit -> unit = "jest.runAllTicks" [@@bs.val]
  external runAllTimers : unit -> unit = "jest.runAllTimers" [@@bs.val]
  external runTimersToTime : unit -> unit = "jest.runTimersToTime" [@@bs.val]
  external runOnlyPendingTimers : unit -> unit = "jest.runOnlyPendingTimers" [@@bs.val]
  external setMock : string -> < .. > Js.t -> unit = "jest.setMock" [@@bs.val]
  external unmock : string -> unit = "jest.unmock" [@@bs.val]
  external useFakeTimers : unit -> unit = "jest.useFakeTimers" [@@bs.val]
  external useRealTimers : unit -> unit = "jest.useRealTimers" [@@bs.val]
  external spyOn : (< .. > Js.t as 'this) -> string -> (unit, unit, 'this) Mock.fn = "jest.spyOn" [@@bs.val] (* this is a bit too dynamic *)
end
