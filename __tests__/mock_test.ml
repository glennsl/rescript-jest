open Jest

let _ = 

describe "inferred_fn" (fun _ ->
  (* TODO: should it return udnefined? Docs are very unclear *)
  test "returns undefined" (fun _ ->
    let mock = Jest.inferred_fn () in
    let fn = Mock.fn mock in
    
    Just (Undefined (fn ()))
  );
  
  test "black hole for argument type object" (fun _ ->
    let mock = Jest.inferred_fn () in
    let fn = Mock.fn mock in
    
    Just (Undefined (fn [%bs.obj { property = 42 }]))
  );
  
  test "black hole for argument type string" (fun _ ->
    let mock = Jest.inferred_fn () in
    let fn = Mock.fn mock in
    
    Just (Undefined (fn "some string"))
  );
  
  test "calls - records call arguments" (fun _ ->
    let mock = Jest.inferred_fn () in
    let _ = Mock.fn mock "first" in
    let _ = Mock.fn mock "second" in
    let calls = mock |> Mock.mock |> Mock.calls in
    
    Just (Equal (calls, [| "first"; "second" |]))
  );
  
  (* TODO: test fails *)
  testSkip "instances - records call returns" (fun _ ->
    let mock = Jest.inferred_fn () in
    let _ = mock
      |> Mock.mockReturnValueOnce (Js.Undefined.return "first")
      |> Mock.mockReturnValueOnce (Js.Undefined.return "second") in
    let _ = Mock.fn mock () in
    let _ = Mock.fn mock () in
    let instances = mock |> Mock.mock |> Mock.instances in
    
    Just (Equal (instances, [| Js.Undefined.return "first"; Js.Undefined.return "second" |]))
  );
  
  (* TODO: test fails *)
  testSkip "mockClear - resets calls" (fun _ ->
    let mock = Jest.inferred_fn () in
    let mockmock = Mock.mock mock in (* TODO: lol, maybe improve the terminology a bit *)
    let before = Mock.calls mockmock in 
    let _ = (Mock.fn mock 1, Mock.fn mock 2) in
    let inbetween = Mock.calls mockmock in
    let _ = Mock.mockClear mock in (* doesn't do anything? *)
    let after = Mock.calls mockmock in
    
    Just (Equal (
      (before, inbetween, after),
      ([||], [| 1; 2 |], [||])
    ))
  );
  
  (* TODO: test fails *)
  testSkip "mockClear - resets instances" (fun _ ->
    let mock = Jest.inferred_fn () in
    let mockmock = Mock.mock mock in
    let before = Mock.instances mockmock in 
    let _ = (Mock.fn mock (), Mock.fn mock ()) in
    let inbetween = Mock.instances mockmock in
    let _ = Mock.mockClear mock in (* doesn't do anything? *)
    let after = Mock.instances mockmock in
    
    Just (Equal (
      (before, inbetween, after),
      ([||], [| Js.Undefined.empty; Js.Undefined.empty |], [||])
    ))
  );
);
  
describe "fn" (fun _ ->
  test "calls implementation" (fun _ ->
    let mock = Jest.fn (fun a -> string_of_int a) in
    let fn = Mock.fn mock in
    
    Just (Be (fn 18, "18"))
  );
  
  test "calls - records call arguments" (fun _ ->
    let mock = Jest.fn (fun a -> string_of_int a) in
    let _ = Mock.fn mock 74 in
    let _ = Mock.fn mock 89435 in
    let calls = mock |> Mock.mock |> Mock.calls in
    
    Just (Equal (calls, [| 74; 89435 |]))
  );
  
  (* TODO: test fails *)
  testSkip "mockClear - resets calls" (fun _ ->
    let mock = Jest.fn (fun a -> string_of_int a) in
    let mockmock = Mock.mock mock in
    let before = Mock.calls mockmock in 
    let _ = (Mock.fn mock 1, Mock.fn mock 2) in
    let inbetween = Mock.calls mockmock in
    let _ = Mock.mockClear mock in (* doesn't do anything? *)
    let after = Mock.calls mockmock in
    
    Just (Equal (
      (before, inbetween, after),
      ([||], [| 1; 2 |], [||])
    ))
  );
  
  (* TODO: test fails *)
  testSkip "mockClear - resets instances" (fun _ ->
    let mock = Jest.fn (fun a -> string_of_int a) in
    let mockmock = Mock.mock mock in
    let before = Mock.instances mockmock in 
    let _ = (Mock.fn mock 1, Mock.fn mock 2) in
    let inbetween = Mock.instances mockmock in
    let _ = Mock.mockClear mock in (* doesn't do anything? *)
    let after = Mock.instances mockmock in
    
    Just (Equal (
      (before, inbetween, after),
      ([||], [| Js.Undefined.empty; Js.Undefined.empty |], [||])
    ))
  );
);

describe "fn2" (fun _ ->
  (* TODO: throws "TypeError: f.apply is not a function" :( *)
  testSkip "calls implementation" (fun _ ->
    let mock = Jest.fn2 (fun a b -> string_of_int (a + b)) in
    let fn = Mock.fn mock in
    
    Just (Be (fn 18 24, "42"))
  );
);

(* TODO: depends on Mock.make
describe "Mock.make" (fun _ ->
  test "Mock.make" (fun _ ->
    let mock = Jest.fn (fun a -> string_of_int a) in
    let instance = mock |> Mock.make 4 in
    let instances = mock |> Mock.mock |> Mock.instances in
    
    Just (Equal (instances, [| instance |]))
  );
);
*)