open Jest

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
    let mockFn = Jest.inferred_fn () in
    let fn = Mock.fn mockFn in
    
    Just (Undefined (call fn ()))
  );
  
  test "black hole for argument type object" (fun _ ->
    let mockFn = Jest.inferred_fn () in
    let fn = Mock.fn mockFn in
    
    Just (Undefined (call fn [%bs.obj { property = 42 }]))
  );
  
  test "black hole for argument type string" (fun _ ->
    let mockFn = Jest.inferred_fn () in
    let fn = Mock.fn mockFn in
    
    Just (Undefined (call fn "some string"))
  );
  
  test "calls - records call arguments" (fun _ ->
    let mockFn = Jest.inferred_fn () in
    let fn = Mock.fn mockFn in
    
    let _ = call fn "first" in
    let _ = call fn "second" in
    let calls  = mockFn |> Mock.mock |> Mock.calls in
    
    Just (Equal (calls, [| "first"; "second" |]))
  );
  
  test "mockClear - resets calls" (fun _ ->
    let mockFn = Jest.inferred_fn () in
    let fn = Mock.fn mockFn in
    
    let before  = mockFn |> Mock.mock |> Mock.calls in 
    let _ = (call fn 1, call fn 2) in
    let inbetween  = mockFn |> Mock.mock |> Mock.calls in
    Mock.mockClear mockFn;
    let after  = mockFn |> Mock.mock |> Mock.calls in
    
    Just (Equal (
      (before, inbetween, after),
      ([||], [| 1; 2 |], [||])
    ))
  );
  
  test "mockReset - resets calls" (fun _ ->
    let mockFn = Jest.inferred_fn () in
    let fn = Mock.fn mockFn in
    
    let before  = mockFn |> Mock.mock |> Mock.calls in 
    let _ = (call fn 1, call fn 2) in
    let inbetween  = mockFn |> Mock.mock |> Mock.calls in
    Mock.mockReset mockFn;
    let after  = mockFn |> Mock.mock |> Mock.calls in
    
    Just (Equal (
      (before, inbetween, after),
      ([||], [| 1; 2 |], [||])
    ))
  );
  
  test "mockReset - resets implementations" (fun _ ->
    let mockFn = Jest.inferred_fn () in
    mockFn |> Mock.mockReturnValue (Js.Undefined.return 128) |> ignore;
    let fn = Mock.fn mockFn in
    
    let before = call fn () in 
    Mock.mockReset mockFn;
    let after = call fn () in 
    
    Just (Equal (
      (before, after),
      (Js.Undefined.return 128, Js.Undefined.empty)
    ))
  );
  
  test "mockImplementation - sets implementation to use for subsequent invocations" (fun _ ->
    let mockFn = Jest.inferred_fn () in
    let fn = Mock.fn mockFn in
    
    let before = call fn 10 in
    mockFn |> Mock.mockImplementation ((fun a -> Js.Undefined.return (string_of_int a)) [@bs]) |> ignore;
    
    Just (Equal (
      (before, call fn 18, call fn 24),
      (Js.Undefined.empty, Js.Undefined.return "18", Js.Undefined.return "24")
    ))
  );
  
  test "mockImplementationOnce - queues implementation for one subsequent invocation" (fun _ ->
    let mockFn = Jest.inferred_fn () in
    let fn = Mock.fn mockFn in
    
    let before = call fn 10 in
    mockFn |> Mock.mockImplementationOnce ((fun a -> Js.Undefined.return (string_of_int a)) [@bs]) |> ignore;
    mockFn |> Mock.mockImplementationOnce ((fun a -> Js.Undefined.return (string_of_int (a * 2))) [@bs]) |> ignore;
    
    Just (Equal (
      (before, call fn 18, call fn 24, call fn 12),
      (Js.Undefined.empty, Js.Undefined.return "18", Js.Undefined.return "48", Js.Undefined.empty)
    ))
  );
  
  test "mockReturnThis - returns `this` on subsequent invocations" (fun _ ->
    let mockFn = Jest.inferred_fn () in
    let this = "this" in
    let fn = bindThis (mockFn |> Mock.fn) this in
    
    let before = call fn () in
    mockFn |> Mock.mockReturnThis |> ignore;
    
    Just (Equal (
      (before, call fn (), call fn ()),
      (Js.Undefined.empty, Js.Undefined.return this, Js.Undefined.return this)
    ))
  );
  
  test "mockReturnValue - returns given value on subsequent invocations" (fun _ ->
    let mockFn = Jest.inferred_fn () in
    let fn = Mock.fn mockFn in
    
    let before = call fn 10 in
    mockFn |> Mock.mockReturnValue (Js.Undefined.return 146) |> ignore;
    
    Just (Equal (
      (before, call fn 18, call fn 24),
      (Js.Undefined.empty, Js.Undefined.return 146, Js.Undefined.return 146)
    ))
  );
  
  test "mockReturnValueOnce - queues implementation for one subsequent invocation" (fun _ ->
    let mockFn = Jest.inferred_fn () in
    let fn = Mock.fn mockFn in
    
    let before = call fn 10 in
    mockFn |> Mock.mockReturnValueOnce (Js.Undefined.return 29) |> ignore;
    mockFn |> Mock.mockReturnValueOnce (Js.Undefined.return 41) |> ignore;
    
    Just (Equal (
      (before, call fn 18, call fn 24, call fn 12),
      (Js.Undefined.empty, Js.Undefined.return 29, Js.Undefined.return 41, Js.Undefined.empty)
    ))
  );
  
  (*
  testSkip "bindThis" (fun _ ->
    let fn = ((fun a -> string_of_int a) [@bs]) in
    let boundFn = bindThis fn "this" in
    
    Just (Equal (call boundFn () 2, "2"))
  );
  *)
  
  (* TODO: Not applicable for function calls, should only be available for new calls
  test "mockClear - resets instances" (fun _ ->
    let mockFn = Jest.inferred_fn () in
    
    let before  = mockFn |> Mock.mock |> Mock.instances in 
    let _ = (Mock.fn mockFn (), Mock.fn mockFn ()) in
    let inbetween  = mockFn |> Mock.mock |> Mock.instances in
    Mock.mockClear mockFn; (* doesn't do anything? *)
    let after  = mockFn |> Mock.mock |> Mock.instances in
    
    Just (Equal (
      (before, inbetween, after),
      ([||], [| Js.Undefined.empty; Js.Undefined.empty |], [||])
    ))
  );
  *)
);
  
describe "fn" (fun _ ->
  test "calls implementation" (fun _ ->
    let mockFn = Jest.fn (fun a -> string_of_int a) in
    let fn = Mock.fn mockFn in
    
    Just (Be (fn 18, "18"))
  );
  
  test "calls - records call arguments" (fun _ ->
    let mockFn = Jest.fn (fun a -> string_of_int a) in
    
    let _ = Mock.fn mockFn 74 in
    let _ = Mock.fn mockFn 89435 in
    let calls  = mockFn |> Mock.mock |> Mock.calls in
    
    Just (Equal (calls, [| 74; 89435 |]))
  );
  
  testSkip "mockClear - resets calls" (fun _ ->
    let mockFn = Jest.fn (fun a -> string_of_int a) in
    
    let before = mockFn |> Mock.mock |> Mock.calls in 
    let _ = (Mock.fn mockFn 1, Mock.fn mockFn 2) in
    let inbetween = mockFn |> Mock.mock |> Mock.calls in
    Mock.mockClear mockFn;
    let after = mockFn |> Mock.mock |> Mock.calls in
    
    Just (Equal (
      (before, inbetween, after),
      ([||], [| 1; 2 |], [||])
    ))
  );
  
  test "mockReset - resets calls" (fun _ ->
    let mockFn = Jest.fn (fun a -> string_of_int a) in
    let fn = Mock.fn mockFn in
    
    let before  = mockFn |> Mock.mock |> Mock.calls in 
    let _ = (fn 1, fn 2) in
    let inbetween  = mockFn |> Mock.mock |> Mock.calls in
    Mock.mockReset mockFn;
    let after  = mockFn |> Mock.mock |> Mock.calls in
    
    Just (Equal (
      (before, inbetween, after),
      ([||], [| 1; 2 |], [||])
    ))
  );
  
  (* TODO: Actually removes the original imlementation too, causing it to return undefined, which usually won't be a valid return value for the function type it mocks *)
  testSkip "mockReset - resets implementations" (fun _ ->
    let mockFn = Jest.fn (fun a -> string_of_int a) in
    mockFn |> Mock.mockReturnValue "128" |> ignore;
    let fn = Mock.fn mockFn in
    
    let before = fn 0 in 
    Mock.mockReset mockFn;
    let after = fn 1 in 
    
    Just (Equal (
      (before, after),
      ("128", "1")
    ))
  );
  
  test "mockImplementation - sets implementation to use for subsequent invocations" (fun _ ->
    let mockFn = Jest.fn (fun a -> string_of_int a) in
    let fn = Mock.fn mockFn in
    
    let before = fn 10 in
    mockFn |> Mock.mockImplementation (fun a -> string_of_int (a * 2)) |> ignore;
    
    Just (Equal (
      (before, fn 18, fn 24),
      ("10", "36", "48")
    ))
  );
  
  test "mockImplementationOnce - queues implementation for one subsequent invocation" (fun _ ->
    let mockFn = Jest.fn (fun a -> string_of_int a) in
    let fn = Mock.fn mockFn in
    
    let before = fn 10 in
    mockFn |> Mock.mockImplementationOnce (fun a -> string_of_int (a * 3)) |> ignore;
    mockFn |> Mock.mockImplementationOnce (fun a -> string_of_int (a * 2)) |> ignore;
    
    Just (Equal (
      (before, fn 18, fn 24, fn 12),
      ("10", "54", "48", "12")
    ))
  );

  (* mockReturnThis doesn't make sense for native functions
  test "mockReturnThis - returns `this` on subsequent invocations" (fun _ ->
    let mockFn = Jest.fn (fun a -> string_of_int a) in
    let this = "this" in
    let fn = bindThis (mockFn |> Mock.fn) this in
    
    let before = fn () in
    mockFn |> Mock.mockReturnThis |> ignore;
    
    Just (Equal (
      (before, fn (), fn ()),
      (Js.Undefined.empty, Js.Undefined.return this, Js.Undefined.return this)
    ))
  );
  *)
  
  test "mockReturnValue - returns given value on subsequent invocations" (fun _ ->
    let mockFn = Jest.fn (fun a -> string_of_int a) in
    let fn = Mock.fn mockFn in
    
    let before = fn 10 in
    mockFn |> Mock.mockReturnValue "146" |> ignore;
    
    Just (Equal (
      (before, fn 18, fn 24),
      ("10", "146", "146")
    ))
  );
  
  test "mockReturnValueOnce - queues implementation for one subsequent invocation" (fun _ ->
    let mockFn = Jest.fn (fun a -> string_of_int a) in
    let fn = Mock.fn mockFn in
    
    let before = fn 10 in
    mockFn |> Mock.mockReturnValueOnce "29" |> ignore;
    mockFn |> Mock.mockReturnValueOnce "41" |> ignore;
    
    Just (Equal (
      (before, fn 18, fn 24, fn 12),
      ("10", "29", "41", "12")
    ))
  );
);

describe "fn2" (fun _ ->
  test "calls implementation" (fun _ ->
    let mockFn = Jest.fn2 ((fun a b -> string_of_int (a + b)) [@bs]) in
    let fn = Mock.fn mockFn in
    
    Just (Be (call2 fn 18 24, "42"))
  );
);

(* TODO: depends on Mock.make
describe "Mock.make" (fun _ ->
  test "Mock.make" (fun _ ->
    let mockFn = Jest.fn (fun a -> string_of_int a) in
    
    let instance  = mockFn |> Mock.make 4 in
    let instances  = mockFn |> Mock.mock |> Mock.instances in
    
    Just (Equal (instances, [| instance |]))
  );
);
*)