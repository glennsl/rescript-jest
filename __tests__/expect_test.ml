open Jest

let _ =

describe "Expect" (fun _ -> 
  let open Expect in

  test "expect1 - toBe" (fun _ -> expect (1 + 2) |> toBe 3);
  test "expect1 - ==" (fun _ -> expect (1 + 2) == 3);
  test "expect1 - toBeCloseTo" (fun _ -> expect (1. +. 2.) |> toBeCloseTo 3.);
  test "expect1 - toBeSoCloseTo" (fun _ -> expect (1. +. 2.) |> toBeSoCloseTo 3. ~digits:9);
  test "expect1 - toBeGreaterThan" (fun _ -> expect 4 |> toBeGreaterThan 3);
  test "expect1 - >" (fun _ -> expect 4 > 3);
  test "expect1 - toBeGreaterThanOrEqual" (fun _ -> expect 4 |> toBeGreaterThanOrEqual 4);
  test "expect1 - >=" (fun _ -> expect 4 >= 4);
  test "expect1 - toBeLessThan" (fun _ -> expect 4 |> toBeLessThan 5);
  test "expect1 - " (fun _ -> expect 4 < 5);
  test "expect1 - toBeLessThanOrEqual" (fun _ -> expect 4 |> toBeLessThanOrEqual 4);
  test "expect1 - <=" (fun _ -> expect 4 <= 4);
  test "expect1 - toBeSuperSetOf" (fun _ -> expect [| "a"; "b"; "c" |] |> toBeSupersetOf [| "a"; "c" |]);
  test "expect1 - toContain" (fun _ -> expect [| "a"; "b"; "c" |] |> toContain "b");
  test "expect1 - toContainString" (fun _ -> expect "banana" |> toContainString "nana");
  test "expect1 - toHaveLength" (fun _ -> expect [| "a"; "b"; "c" |] |> toHaveLength 3);
  test "expect1 - toEqual" (fun _ -> expect (1 + 2) |> toEqual 3);
  test "expect1 - toMatch" (fun _ -> expect "banana" |> toMatch "nana");
  test "expect1 - toMatchRe" (fun _ -> expect "banana" |> toMatchRe [%re "/ana/"]);
  test "expect1 - =" (fun _ -> expect (1 + 2) = 3);
  test "expect1 - not_ |> toBe" (fun _ -> expect (1 + 2) |> not_ |> toBe 4);
  test "expect1 - <>" (fun _ -> expect (1 + 2) <> 4);
  test "expect1 - !=" (fun _ -> expect (1 + 2) != 4);
);

describe "ExpectJS" (fun _ -> 
  let open ExpectJS in

  test "expect1 - toBe" (fun _ -> expect (1 + 2) |> toBe 3);
  test "expect1 - ==" (fun _ -> expect (1 + 2) == 3);
  test "expect1 - toBeCloseTo" (fun _ -> expect (1. +. 2.) |> toBeCloseTo 3.);
  test "expect1 - toBeSoCloseTo" (fun _ -> expect (1. +. 2.) |> toBeSoCloseTo 3. ~digits:9);
  test "expect1 - toBeDefined" (fun _ -> expect (Js.Undefined.return 3) |> toBeDefined);
  test "expect1 - toBeFalsy" (fun _ -> expect nan |> toBeFalsy);
  test "expect1 - toBeGreaterThan" (fun _ -> expect 4 |> toBeGreaterThan 3);
  test "expect1 - >" (fun _ -> expect 4 > 3);
  test "expect1 - toBeGreaterThanOrEqual" (fun _ -> expect 4 |> toBeGreaterThanOrEqual 4);
  test "expect1 - >=" (fun _ -> expect 4 >= 4);
  test "expect1 - toBeLessThan" (fun _ -> expect 4 |> toBeLessThan 5);
  test "expect1 - " (fun _ -> expect 4 < 5);
  test "expect1 - toBeLessThanOrEqual" (fun _ -> expect 4 |> toBeLessThanOrEqual 4);
  test "expect1 - <=" (fun _ -> expect 4 <= 4);
  test "expect1 - toBeNull" (fun _ -> expect nan |> toBeFalsy);
  test "expect1 - toBeSuperSetOf" (fun _ -> expect [| "a"; "b"; "c" |] |> toBeSupersetOf [| "a"; "c" |]);
  test "expect1 - toBeTruthy" (fun _ -> expect [||] |> toBeTruthy);
  test "expect1 - toBeUndefined" (fun _ -> expect Js.Undefined.empty |> toBeUndefined);
  test "expect1 - toContain" (fun _ -> expect [| "a"; "b"; "c" |] |> toContain "b");
  test "expect1 - toContainString" (fun _ -> expect "banana" |> toContainString "nana");
  test "expect1 - toContainProperties" (fun _ -> expect [%obj { foo = 0; bar = true }] |> toContainProperties [| "foo"; "bar" |]);
  test "expect1 - toHaveLength" (fun _ -> expect [| "a"; "b"; "c" |] |> toHaveLength 3);
  test "expect1 - toEqual" (fun _ -> expect (1 + 2) |> toEqual 3);
  test "expect1 - toMatch" (fun _ -> expect "banana" |> toMatch "nana");
  test "expect1 - toMatchRe" (fun _ -> expect "banana" |> toMatchRe [%re "/ana/"]);
  test "expect1 - =" (fun _ -> expect (1 + 2) = 3);
  test "expect1 - not_ |> toBe" (fun _ -> expect (1 + 2) |> not_ |> toBe 4);
  test "expect1 - <>" (fun _ -> expect (1 + 2) <> 4);
  test "expect1 - !=" (fun _ -> expect (1 + 2) != 4);
);