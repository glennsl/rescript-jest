open Jest

let _ =

describe "Expect" (fun _ -> 
  let open Expect in

  test "toBe" (fun _ ->
    expect (1 + 2) |> toBe 3);
  test "toBeCloseTo" (fun _ ->
    expect (1. +. 2.) |> toBeCloseTo 3.);
  test "toBeSoCloseTo" (fun _ ->
    expect (1. +. 2.) |> toBeSoCloseTo 3. ~digits:9);
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
  Skip.test "toThrow - no throw - should compile, but fail test" (fun _ ->
    expect (fun () -> 2) |> toThrow);
  (*test "toThrowException" (fun _ ->
    expect (fun () -> raise (Invalid_argument "foo")) |> toThrowException (Invalid_argument "foo"));*)
  test "toThrowMessage" (fun _ ->
    expect (fun () -> raise (Invalid_argument "foo")) |> toThrowMessage "Invalid_argument,-3,foo");
  test "toThrowMessageRe" (fun _ ->
    expect (fun () -> assert false) |> toThrowMessageRe [%re "/Assert_failure/"]);
  test "not_ |> toBe" (fun _ ->
    expect (1 + 2) |> not_ |> toBe 4);

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

  test "toBe" (fun _ ->
    expect (1 + 2) |> toBe 3);
  test "toBeCloseTo" (fun _ ->
    expect (1. +. 2.) |> toBeCloseTo 3.);
  test "toBeSoCloseTo" (fun _ ->
    expect (1. +. 2.) |> toBeSoCloseTo 3. ~digits:9);
  test "toBeDefined" (fun _ ->
    expect (Js.Undefined.return 3) |> toBeDefined);
  test "toBeFalsy" (fun _ ->
    expect nan |> toBeFalsy);
  test "toBeGreaterThan" (fun _ ->
    expect 4 |> toBeGreaterThan 3);
  test "toBeGreaterThanOrEqual" (fun _ ->
    expect 4 |> toBeGreaterThanOrEqual 4);
  test "toBeLessThan" (fun _ ->
    expect 4 |> toBeLessThan 5);
  test "toBeLessThanOrEqual" (fun _ ->
    expect 4 |> toBeLessThanOrEqual 4);
  test "toBeNull" (fun _ ->
    expect nan |> toBeFalsy);
  test "toBeSuperSetOf" (fun _ ->
    expect [| "a"; "b"; "c" |] |> toBeSupersetOf [| "a"; "c" |]);
  test "toBeTruthy" (fun _ ->
    expect [||] |> toBeTruthy);
  test "toBeUndefined" (fun _ ->
    expect Js.Undefined.empty |> toBeUndefined);
  test "toContain" (fun _ ->
    expect [| "a"; "b"; "c" |] |> toContain "b");
  test "toContainString" (fun _ ->
    expect "banana" |> toContainString "nana");
  test "toContainProperties" (fun _ ->
    expect [%obj { foo = 0; bar = true }] |> toContainProperties [| "foo"; "bar" |]);
  test "toHaveLength" (fun _ ->
    expect [| "a"; "b"; "c" |] |> toHaveLength 3);
  test "toEqual" (fun _ ->
    expect (1 + 2) |> toEqual 3);
  test "toMatch" (fun _ ->
    expect "banana" |> toMatch "nana");
  test "toMatchRe" (fun _ ->
    expect "banana" |> toMatchRe [%re "/ana/"]);
  test "toMatchObject" (fun _ ->
    expect [%obj { a = 1; b = 2; c = 3 }] |> toMatchObject [%obj { a = 1; b = 2 }]);
  test "toThrow" (fun _ ->
    expect (fun () -> assert false) |> toThrow);
  (*test "toThrowException" (fun _ ->
    expect (fun () -> raise (Invalid_argument "foo")) |> toThrowException (Invalid_argument "foo"));*)
  test "toThrowMessage" (fun _ ->
    expect (fun () -> raise (Invalid_argument "foo")) |> toThrowMessage "Invalid_argument,-3,foo");
  test "toThrowMessageRe" (fun _ ->
    expect (fun () -> assert false) |> toThrowMessageRe [%re "/Assert_failure/"]);
  test "not_ |> toBe" (fun _ ->
    expect (1 + 2) |> not_ |> toBe 4);
);