open Jest
open ExpectJs

(* TODO: move to BS std lib *)
external bind : ('a -> 'b) -> 'c -> 'a -> ('a -> 'b) = "" [@@bs.send]
external bindThis : ('a -> 'b [@bs]) -> 'c -> ('a -> 'b [@bs]) = "bind" [@@bs.send]
external call : ('a -> 'b [@bs]) -> 'c -> 'a -> 'b = "" [@@bs.send]
let call self arg = call self () arg
external callThis : ('a -> 'b [@bs]) -> 'c -> 'a -> 'b = "call" [@@bs.send]
external call2 : ('a -> 'b -> 'c [@bs]) -> (_ [@bs.as 0]) -> 'a -> 'b -> 'c = "call" [@@bs.send]

let _ = 

describe "inferred_fn" (fun _ ->
  test "returns undefined" (fun _ ->
    let mockFn = JestJs.inferred_fn () in
    let fn = MockJs.fn mockFn in
    
    expect (call fn ()) |> toBeUndefined
  );
  
  test "black hole for argument type object" (fun _ ->
    let mockFn = JestJs.inferred_fn () in
    let fn = MockJs.fn mockFn in
    
    expect (call fn [%obj { property = 42 }]) |> toBeUndefined
  );
  
  test "black hole for argument type string" (fun _ ->
    let mockFn = JestJs.inferred_fn () in
    let fn = MockJs.fn mockFn in
    
    expect (call fn "some string") |> toBeUndefined
  );
  
  test "calls - records call arguments" (fun _ ->
    let mockFn = JestJs.inferred_fn () in
    let fn = MockJs.fn mockFn in
    
    let _ = call fn "first" in
    let _ = call fn "second" in
    let calls  = mockFn |> MockJs.calls in
    
    expect calls |> toEqual [| "first"; "second" |]
  );
  
  test "mockClear - resets calls" (fun _ ->
    let mockFn = JestJs.inferred_fn () in
    let fn = MockJs.fn mockFn in
    
    let before  = mockFn |> MockJs.calls in 
    let _ = (call fn 1, call fn 2) in
    let inbetween  = mockFn |> MockJs.calls in
    MockJs.mockClear mockFn;
    let after  = mockFn |> MockJs.calls in
    
    expect
      (before, inbetween, after)
    |> toEqual
      ([||], [| 1; 2 |], [||])
  );
  
  test "mockReset - resets calls" (fun _ ->
    let mockFn = JestJs.inferred_fn () in
    let fn = MockJs.fn mockFn in
    
    let before  = mockFn |> MockJs.calls in 
    let _ = (call fn 1, call fn 2) in
    let inbetween  = mockFn |> MockJs.calls in
    MockJs.mockReset mockFn;
    let after  = mockFn |> MockJs.calls in
    
    expect
      (before, inbetween, after)
    |> toEqual
      ([||], [| 1; 2 |], [||])
  );
  
  test "mockReset - resets implementations" (fun _ ->
    let mockFn = JestJs.inferred_fn () in
    mockFn |> MockJs.mockReturnValue (Js.Undefined.return 128) |> ignore;
    let fn = MockJs.fn mockFn in
    
    let before = call fn () in 
    MockJs.mockReset mockFn;
    let after = call fn () in 
    
    expect
      (before, after)
    |> toEqual
      (Js.Undefined.return 128, Js.Undefined.empty)
  );
  
  test "mockImplementation - sets implementation to use for subsequent invocations" (fun _ ->
    let mockFn = JestJs.inferred_fn () in
    let fn = MockJs.fn mockFn in
    
    let before = call fn 10 in
    mockFn |> MockJs.mockImplementation ((fun a -> Js.Undefined.return (string_of_int a)) [@bs]) |> ignore;
    
    expect
      (before, call fn 18, call fn 24)
    |> toEqual
      (Js.Undefined.empty, Js.Undefined.return "18", Js.Undefined.return "24")
  );
  
  test "mockImplementationOnce - queues implementation for one subsequent invocation" (fun _ ->
    let mockFn = JestJs.inferred_fn () in
    let fn = MockJs.fn mockFn in
    
    let before = call fn 10 in
    mockFn |> MockJs.mockImplementationOnce ((fun a -> Js.Undefined.return (string_of_int a)) [@bs]) |> ignore;
    mockFn |> MockJs.mockImplementationOnce ((fun a -> Js.Undefined.return (string_of_int (a * 2))) [@bs]) |> ignore;
    
    expect
      (before, call fn 18, call fn 24, call fn 12)
    |> toEqual
      (Js.Undefined.empty, Js.Undefined.return "18", Js.Undefined.return "48", Js.Undefined.empty)
  );
  
  test "mockReturnThis - returns `this` on subsequent invocations" (fun _ ->
    let mockFn = JestJs.inferred_fn () in
    let this = "this" in
    let fn = bindThis (mockFn |> MockJs.fn) this in
    
    let before = call fn () in
    mockFn |> MockJs.mockReturnThis |> ignore;
    
    expect
      (before, call fn (), call fn ())
    |> toEqual
      (Js.Undefined.empty, Js.Undefined.return this, Js.Undefined.return this)
  );
  
  test "mockReturnValue - returns given value on subsequent invocations" (fun _ ->
    let mockFn = JestJs.inferred_fn () in
    let fn = MockJs.fn mockFn in
    
    let before = call fn 10 in
    mockFn |> MockJs.mockReturnValue (Js.Undefined.return 146) |> ignore;
    
    expect
      (before, call fn 18, call fn 24)
    |> toEqual
      (Js.Undefined.empty, Js.Undefined.return 146, Js.Undefined.return 146)
  );
  
  test "mockReturnValueOnce - queues implementation for one subsequent invocation" (fun _ ->
    let mockFn = JestJs.inferred_fn () in
    let fn = MockJs.fn mockFn in
    
    let before = call fn 10 in
    mockFn |> MockJs.mockReturnValueOnce (Js.Undefined.return 29) |> ignore;
    mockFn |> MockJs.mockReturnValueOnce (Js.Undefined.return 41) |> ignore;
    
    expect
      (before, call fn 18, call fn 24, call fn 12)
    |> toEqual
      (Js.Undefined.empty, Js.Undefined.return 29, Js.Undefined.return 41, Js.Undefined.empty)
  );
  
  (*
  Skip.test "bindThis" (fun _ ->
    let fn = ((fun a -> string_of_int a) [@bs]) in
    let boundFn = bindThis fn "this" in
    
    expect (call boundFn () 2) |> toEqual "2"
  );
  *)
  
  (* TODO: Not applicable for function calls, should only be available for new calls
  test "mockClear - resets instances" (fun _ ->
    let mockFn = JestJs.inferred_fn () in
    
    let before  = mockFn |> MockJs.mock |> MockJs.instances in 
    let _ = (MockJs.fn mockFn (), MockJs.fn mockFn ()) in
    let inbetween  = mockFn |> MockJs.mock |> MockJs.instances in
    MockJs.mockClear mockFn; (* doesn't do anything? *)
    let after  = mockFn |> MockJs.mock |> MockJs.instances in
    
    expect
      (before, inbetween, after)
    |> toEqual
      ([||], [| Js.Undefined.empty; Js.Undefined.empty |], [||])
  );
  *)
);
  
describe "fn" (fun _ ->
  test "calls implementation" (fun _ ->
    let mockFn = JestJs.fn (fun a -> string_of_int a) in
    let fn = MockJs.fn mockFn in
    
    expect (fn 18) |> toBe "18"
  );
  
  test "calls - records call arguments" (fun _ ->
    let mockFn = JestJs.fn (fun a -> string_of_int a) in
    
    let _ = MockJs.fn mockFn 74 in
    let _ = MockJs.fn mockFn 89435 in
    let calls  = mockFn |> MockJs.calls in
    
    expect calls |> toEqual [| 74; 89435 |]
  );
  
  Skip.test "mockClear - resets calls" (fun _ ->
    let mockFn = JestJs.fn (fun a -> string_of_int a) in
    
    let before = mockFn |> MockJs.calls in 
    let _ = (MockJs.fn mockFn 1, MockJs.fn mockFn 2) in
    let inbetween = mockFn |> MockJs.calls in
    MockJs.mockClear mockFn;
    let after = mockFn |> MockJs.calls in
    
    expect
      (before, inbetween, after)
    |> toEqual
      ([||], [| 1; 2 |], [||])
  );
  
  test "mockReset - resets calls" (fun _ ->
    let mockFn = JestJs.fn (fun a -> string_of_int a) in
    let fn = MockJs.fn mockFn in
    
    let before  = mockFn |> MockJs.calls in 
    let _ = (fn 1, fn 2) in
    let inbetween  = mockFn |> MockJs.calls in
    MockJs.mockReset mockFn;
    let after  = mockFn |> MockJs.calls in
    
    expect
      (before, inbetween, after)
    |> toEqual
      ([||], [| 1; 2 |], [||])
  );
  
  (* TODO: Actually removes the original imlementation too, causing it to return undefined, which usually won't be a valid return value for the function type it mocks *)
  Skip.test "mockReset - resets implementations" (fun _ ->
    let mockFn = JestJs.fn (fun a -> string_of_int a) in
    mockFn |> MockJs.mockReturnValue "128" |> ignore;
    let fn = MockJs.fn mockFn in
    
    let before = fn 0 in 
    MockJs.mockReset mockFn;
    let after = fn 1 in 
    
    expect
      (before, after)
    |> toEqual
      ("128", "1")
  );
  
  test "mockImplementation - sets implementation to use for subsequent invocations" (fun _ ->
    let mockFn = JestJs.fn (fun a -> string_of_int a) in
    let fn = MockJs.fn mockFn in
    
    let before = fn 10 in
    mockFn |> MockJs.mockImplementation (fun a -> string_of_int (a * 2)) |> ignore;
    
    expect
      (before, fn 18, fn 24)
    |> toEqual
      ("10", "36", "48")
  );
  
  test "mockImplementationOnce - queues implementation for one subsequent invocation" (fun _ ->
    let mockFn = JestJs.fn (fun a -> string_of_int a) in
    let fn = MockJs.fn mockFn in
    
    let before = fn 10 in
    mockFn |> MockJs.mockImplementationOnce (fun a -> string_of_int (a * 3)) |> ignore;
    mockFn |> MockJs.mockImplementationOnce (fun a -> string_of_int (a * 2)) |> ignore;
    
    expect
      (before, fn 18, fn 24, fn 12)
    |> toEqual
      ("10", "54", "48", "12")
  );

  (* mockReturnThis doesn't make sense for native functions
  test "mockReturnThis - returns `this` on subsequent invocations" (fun _ ->
    let mockFn = JestJs.fn (fun a -> string_of_int a) in
    let this = "this" in
    let fn = bindThis (mockFn |> MockJs.fn) this in
    
    let before = fn () in
    mockFn |> MockJs.mockReturnThis |> ignore;
    
    expect
      (before, fn (), fn ())
    |> toEqual
      (Js.Undefined.empty, Js.Undefined.return this, Js.Undefined.return this)
  );
  *)
  
  test "mockReturnValue - returns given value on subsequent invocations" (fun _ ->
    let mockFn = JestJs.fn (fun a -> string_of_int a) in
    let fn = MockJs.fn mockFn in
    
    let before = fn 10 in
    mockFn |> MockJs.mockReturnValue "146" |> ignore;
    
    expect
      (before, fn 18, fn 24)
    |> toEqual
      ("10", "146", "146")
  );
  
  test "mockReturnValueOnce - queues implementation for one subsequent invocation" (fun _ ->
    let mockFn = JestJs.fn (fun a -> string_of_int a) in
    let fn = MockJs.fn mockFn in
    
    let before = fn 10 in
    mockFn |> MockJs.mockReturnValueOnce "29" |> ignore;
    mockFn |> MockJs.mockReturnValueOnce "41" |> ignore;
    
    expect
      (before, fn 18, fn 24, fn 12)
    |> toEqual
      ("10", "29", "41", "12")
  );
);

describe "fn2" (fun _ ->
  test "calls implementation" (fun _ ->
    let mockFn = JestJs.fn2 ((fun a b -> string_of_int (a + b)) [@bs]) in
    let fn = MockJs.fn mockFn in
    
    expect (call2 fn 18 24) |> toBe "42"
  );
);

(* TODO: depends on MockJs.make
describe "MockJs.make" (fun _ ->
  test "MockJs.make" (fun _ ->
    let mockFn = JestJs.fn (fun a -> string_of_int a) in
    
    let instance  = mockFn |> MockJs.make 4 in
    let instances  = mockFn |> MockJs.mock |> MockJs.instances in
    
    expect instances |> toEqual [| instance |]
  );
);
*)