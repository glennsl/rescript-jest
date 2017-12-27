open Jest

let _ =

  Only.test "Only.test" (fun _ -> pass);

  Only.testAsync "Only.testAsync" (fun finish ->
    finish pass);

  Only.testPromise "Only.testPromise" (fun _ ->
    Js.Promise.resolve pass);

  Only.testAll "testAll" ["foo"; "bar"; "baz"] (fun input ->
    if Js.String.length input == 3 then pass else fail "");
  Only.testAll "testAll - tuples" [("foo", 3); ("barbaz", 6); ("bananas!", 8)] (fun (input, output) ->
    if Js.String.length input == output then pass else fail "");

  Only.describe "Only.describe" (fun _ ->
    test "some aspect" (fun _ -> pass)
  );