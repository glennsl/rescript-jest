include Jest.Runner(struct
  type _ t = bool
  let assert_ ok = assert ok
end)

let _ =

  Only.test "Only.test" (fun _ -> true);

  Only.testAsync "Only.testAsync" (fun done_ ->
    done_ true);

  Only.testPromise "Only.testPromise" (fun _ ->
    Js.Promise.resolve true);

  Only.testAll "testAll" ["foo"; "bar"; "baz"] (fun input ->
    Js.String.length input == 3);
  Only.testAll "testAll - tuples" [("foo", 3); ("barbaz", 6); ("bananas!", 8)] (fun (input, output) ->
    Js.String.length input == output);

  Only.describe "Only.describe" (fun _ ->
    test "some aspect" (fun _ -> 1 + 2 ==3)
  );