open Jest

type test_record = {
  value: string
}

let () =

describe "Expect" (fun () -> 
  let open Expect in

  test "toBe" (fun () ->
    expect (1 + 2) |> toBe 3);
  test "toBeCloseTo" (fun () ->
    expect (1. +. 2.) |> toBeCloseTo 3.);
  test "toBeSoCloseTo" (fun () ->
    expect (1. +. 2.123) |> toBeSoCloseTo 3.123 ~digits:3);
  test "toBeGreaterThan" (fun () ->
    expect 4 |> toBeGreaterThan 3);
  test "toBeGreaterThanOrEqual" (fun () ->
    expect 4 |> toBeGreaterThanOrEqual 4);
  test "toBeLessThan" (fun () ->
    expect 4 |> toBeLessThan 5);
  test "toBeLessThanOrEqual" (fun () ->
    expect 4 |> toBeLessThanOrEqual 4);
  test "toBeSuperSetOf" (fun () ->
    expect [| "a"; "b"; "c" |] |> toBeSupersetOf [| "a"; "c" |]);
  test "toContain" (fun () ->
    expect [| "a"; "b"; "c" |] |> toContain "b");
  test "toContainEqual" (fun () ->
    expect [| {value = "a"}; {value = "b"}; {value = "c"} |] |> toContainEqual {value = "b"});
  test "toContainString" (fun () ->
    expect "banana" |> toContainString "nana");
  test "toHaveLength" (fun () ->
    expect [| "a"; "b"; "c" |] |> toHaveLength 3);
  test "toEqual" (fun () ->
    expect (1 + 2) |> toEqual 3);
  test "toMatch" (fun () ->
    expect "banana" |> toMatch "nana");
  test "toMatchRe" (fun () ->
    expect "banana" |> toMatchRe [%re "/ana/"]);
  test "toThrow" (fun () ->
    expect (fun () -> assert false) |> toThrow);

  test "toMatchInlineSnapshot" (fun () ->
    expect "foo" |> toMatchInlineSnapshot "\"foo\"");
  test "toMatchSnapshot" (fun () ->
    expect "foo" |> toMatchSnapshot);
  test "toMatchSnapshotWithName" (fun () ->
    expect "foo" |> toMatchSnapshotWithName "bar");
  test "toThrowErrorMatchingSnapshot" (fun () ->
    expect (fun () -> Js.Exn.raiseError "foo error") |> toThrowErrorMatchingSnapshot);

  test "not toBe" (fun () ->
    expect (1 + 2) |> not_ |> toBe 4);
  test "not toBeCloseTo" (fun () ->
    expect (1. +. 2.) |> not_ |> toBeCloseTo 4.);
  test "not toBeSoCloseTo" (fun () ->
    expect (1. +. 2.123) |> not_ |> toBeSoCloseTo 3.12 ~digits:3);
  test "not toBeGreaterThan" (fun () ->
    expect 4 |> not_ |> toBeGreaterThan 4);
  test "not toBeGreaterThanOrEqual" (fun () ->
    expect 4 |> not_ |> toBeGreaterThanOrEqual 5);
  test "not toBeLessThan" (fun () ->
    expect 4 |> not_ |> toBeLessThan 4);
  test "not toBeLessThanOrEqual" (fun () ->
    expect 4 |> not_ |> toBeLessThanOrEqual 3);
  test "not toBeSuperSetOf" (fun () ->
    expect [| "a"; "b"; "c" |] |> not_ |> toBeSupersetOf [| "a"; "d" |]);
  test "not toContain" (fun () ->
    expect [| "a"; "b"; "c" |] |> not_ |> toContain "d");
  test "not toContainEqual" (fun () ->
    expect [| {value = "a"}; {value = "b"}; {value = "c"} |] |> not_ |> toContainEqual {value = "d"});
  test "not toContainString" (fun () ->
    expect "banana" |> not_ |> toContainString "nanan");
  test "not toHaveLength" (fun () ->
    expect [| "a"; "b"; "c" |] |> not_ |> toHaveLength 2);
  test "not toEqual" (fun () ->
    expect (1 + 2) |> not_ |> toEqual 4);
  test "not toMatch" (fun () ->
    expect "banana" |> not_ |> toMatch "nanan");
  test "not toMatchRe" (fun () ->
    expect "banana" |> not_ |> toMatchRe [%re "/anas/"]);
  test "not toThrow" (fun () ->
    expect (fun () -> 2) |> not_ |> toThrow);

  test "expectFn" (fun () ->
    expectFn raise (Invalid_argument "foo") |> toThrow);
);

describe "Expect.Operators" (fun () -> 
  let open Expect in
  let open! Expect.Operators in

  test "==" (fun () ->
    expect (1 + 2) == 3);
  test ">" (fun () ->
    expect 4 > 3);
  test ">=" (fun () ->
    expect 4 >= 4);
  test "<" (fun () ->
    expect 4 < 5);
  test "<=" (fun () ->
    expect 4 <= 4);
  test "=" (fun () ->
    expect (1 + 2) = 3);
  test "<>" (fun () ->
    expect (1 + 2) <> 4);
  test "!=" (fun () ->
    expect (1 + 2) != 4);
);

describe "ExpectJs" (fun () -> 
  let open ExpectJs in

  test "toBeDefined" (fun () ->
    expect (Js.Undefined.return 3) |> toBeDefined);
  test "toBeFalsy" (fun () ->
    expect nan |> toBeFalsy);
  test "toBeNull" (fun () ->
    expect Js.null |> toBeNull);
  test "toBeTruthy" (fun () ->
    expect [||] |> toBeTruthy);
  test "toBeUndefined" (fun () ->
    expect Js.Undefined.empty |> toBeUndefined);
  test "toContainProperties" (fun () ->
    expect [%obj { foo = 0; bar = true }] |> toContainProperties [| "foo"; "bar" |]);
  test "toMatchObject" (fun () ->
    expect [%obj { a = 1; b = 2; c = 3 }] |> toMatchObject [%obj { a = 1; b = 2 }]);

  test "not toBeDefined" (fun () ->
    expect (Js.undefined) |> not_ |> toBeDefined);
  test "not toBeFalsy" (fun () ->
    expect [||] |> not_ |> toBeFalsy);
  test "not toBeNull" (fun () ->
    expect (Js.Null.return 4) |> not_ |> toBeNull);
  test "not toBeTruthy" (fun () ->
    expect nan |> not_ |> toBeTruthy);
  test "not toBeUndefined" (fun () ->
    expect (Js.Undefined.return 4) |> not_ |> toBeUndefined);
  test "not toContainProperties" (fun () ->
    expect [%obj { foo = 0; bar = true }] |> not_ |> toContainProperties [| "foo"; "zoo" |]);
  test "not toMatchObject" (fun () ->
    expect [%obj { a = 1; b = 2; c = 3 }] |> not_ |> toMatchObject [%obj { a = 1; c = 2 }]);
);
