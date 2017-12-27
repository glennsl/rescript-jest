open Jest

let _ =

describe "Expect" (fun _ -> 
  let open Expect in

  test "toBe" (fun _ ->
    expect (1 + 2) |> toBe 3);
  test "toBeCloseTo" (fun _ ->
    expect (1. +. 2.) |> toBeCloseTo 3.);
  test "toBeSoCloseTo" (fun _ ->
    expect (1. +. 2.123) |> toBeSoCloseTo 3.123 ~digits:3);
  test "toBeGreaterThan" (fun _ ->
    expect 4 |> toBeGreaterThan 3);
  test "toBeGreaterThanOrEqual" (fun _ ->
    expect 4 |> toBeGreaterThanOrEqual 4);
  test "toBeLessThan" (fun _ ->
    expect 4 |> toBeLessThan 5);
  test "toBeLessThanOrEqual" (fun _ ->
    expect 4 |> toBeLessThanOrEqual 4);
  test "toBeSuperSetOf" (fun _ ->
    expect [| "a"; "b"; "c" |] |> toBeSupersetOf [| "a"; "c" |]);
  test "toContain" (fun _ ->
    expect [| "a"; "b"; "c" |] |> toContain "b");
  test "toContainString" (fun _ ->
    expect "banana" |> toContainString "nana");
  test "toHaveLength" (fun _ ->
    expect [| "a"; "b"; "c" |] |> toHaveLength 3);
  test "toEqual" (fun _ ->
    expect (1 + 2) |> toEqual 3);
  test "toMatch" (fun _ ->
    expect "banana" |> toMatch "nana");
  test "toMatchRe" (fun _ ->
    expect "banana" |> toMatchRe [%re "/ana/"]);
  test "toThrow" (fun _ ->
    expect (fun () -> assert false) |> toThrow);
  (*test "toThrowException" (fun _ ->
    expect (fun () -> raise (Invalid_argument "foo")) |> toThrowException (Invalid_argument "foo"));*)
  test "toThrowMessage" (fun _ ->
    expect (fun () -> raise (Invalid_argument "foo")) |> toThrowMessage "Invalid_argument,-3,foo");
  test "toThrowMessageRe" (fun _ ->
    expect (fun () -> assert false) |> toThrowMessageRe [%re "/Assert_failure/"]);

  test "not toBe" (fun _ ->
    expect (1 + 2) |> not_ |> toBe 4);
  test "not toBeCloseTo" (fun _ ->
    expect (1. +. 2.) |> not_ |> toBeCloseTo 4.);
  test "not toBeSoCloseTo" (fun _ ->
    expect (1. +. 2.123) |> not_ |> toBeSoCloseTo 3.12 ~digits:3);
  test "not toBeGreaterThan" (fun _ ->
    expect 4 |> not_ |> toBeGreaterThan 4);
  test "not toBeGreaterThanOrEqual" (fun _ ->
    expect 4 |> not_ |> toBeGreaterThanOrEqual 5);
  test "not toBeLessThan" (fun _ ->
    expect 4 |> not_ |> toBeLessThan 4);
  test "not toBeLessThanOrEqual" (fun _ ->
    expect 4 |> not_ |> toBeLessThanOrEqual 3);
  test "not toBeSuperSetOf" (fun _ ->
    expect [| "a"; "b"; "c" |] |> not_ |> toBeSupersetOf [| "a"; "d" |]);
  test "not toContain" (fun _ ->
    expect [| "a"; "b"; "c" |] |> not_ |> toContain "d");
  test "not toContainString" (fun _ ->
    expect "banana" |> not_ |> toContainString "nanan");
  test "not toHaveLength" (fun _ ->
    expect [| "a"; "b"; "c" |] |> not_ |> toHaveLength 2);
  test "not toEqual" (fun _ ->
    expect (1 + 2) |> not_ |> toEqual 4);
  test "not toMatch" (fun _ ->
    expect "banana" |> not_ |> toMatch "nanan");
  test "not toMatchRe" (fun _ ->
    expect "banana" |> not_ |> toMatchRe [%re "/anas/"]);
  test "not toThrow" (fun _ ->
    expect (fun () -> 2) |> not_ |> toThrow);
  (*test "toThrowException" (fun _ ->
    expect (fun () -> raise (Invalid_argument "foo")) |> toThrowException (Invalid_argument "foo"));*)
  test "not toThrowMessage" (fun _ ->
    expect (fun () -> raise (Invalid_argument "bar")) |> not_ |> toThrowMessage "Invalid_argument,-3,foo");
  test "not toThrowMessageRe" (fun _ ->
    expect (fun () -> assert false) |> not_ |> toThrowMessageRe [%re "/Assert_failure!/"]);

  test "expectFn" (fun _ ->
    expectFn raise (Invalid_argument "foo") |> toThrowMessage "Invalid_argument,-3,foo");
);

describe "Expect.Operators" (fun _ -> 
  let open Expect in
  let open! Expect.Operators in

  test "==" (fun _ ->
    expect (1 + 2) == 3);
  test ">" (fun _ ->
    expect 4 > 3);
  test ">=" (fun _ ->
    expect 4 >= 4);
  test "<" (fun _ ->
    expect 4 < 5);
  test "<=" (fun _ ->
    expect 4 <= 4);
  test "=" (fun _ ->
    expect (1 + 2) = 3);
  test "<>" (fun _ ->
    expect (1 + 2) <> 4);
  test "!=" (fun _ ->
    expect (1 + 2) != 4);
);

describe "ExpectJs" (fun _ -> 
  let open ExpectJs in

  test "toBeDefined" (fun _ ->
    expect (Js.Undefined.return 3) |> toBeDefined);
  test "toBeFalsy" (fun _ ->
    expect nan |> toBeFalsy);
  test "toBeNull" (fun _ ->
    expect Js.null |> toBeNull);
  test "toBeTruthy" (fun _ ->
    expect [||] |> toBeTruthy);
  test "toBeUndefined" (fun _ ->
    expect Js.Undefined.empty |> toBeUndefined);
  test "toContainProperties" (fun _ ->
    expect [%obj { foo = 0; bar = true }] |> toContainProperties [| "foo"; "bar" |]);
  test "toMatchObject" (fun _ ->
    expect [%obj { a = 1; b = 2; c = 3 }] |> toMatchObject [%obj { a = 1; b = 2 }]);

  test "not toBeDefined" (fun _ ->
    expect (Js.undefined) |> not_ |> toBeDefined);
  test "not toBeFalsy" (fun _ ->
    expect [||] |> not_ |> toBeFalsy);
  test "not toBeNull" (fun _ ->
    expect (Js.Null.return 4) |> not_ |> toBeNull);
  test "not toBeTruthy" (fun _ ->
    expect nan |> not_ |> toBeTruthy);
  test "not toBeUndefined" (fun _ ->
    expect (Js.Undefined.return 4) |> not_ |> toBeUndefined);
  test "not toContainProperties" (fun _ ->
    expect [%obj { foo = 0; bar = true }] |> not_ |> toContainProperties [| "foo"; "zoo" |]);
  test "not toMatchObject" (fun _ ->
    expect [%obj { a = 1; b = 2; c = 3 }] |> not_ |> toMatchObject [%obj { a = 1; c = 2 }]);
);