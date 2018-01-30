include Jest.Runner(struct
  type _ t = bool
  let affirm ok = assert ok
end)

let () =

  Only.test "Only.test" (fun () -> true);

  Only.testAsync "Only.testAsync" (fun finish ->
    finish true);
  Only.testAsync "testAsync - timeout ok" ~timeout:1 (fun finish ->
    finish true);

  Only.testPromise "Only.testPromise" (fun () ->
    Js.Promise.resolve true);
  Only.testPromise "testPromise - timeout ok" ~timeout:1 (fun () ->
    Js.Promise.resolve true);

  Only.testAll "testAll" ["foo"; "bar"; "baz"] (fun input ->
    Js.String.length input == 3);
  Only.testAll "testAll - tuples" [("foo", 3); ("barbaz", 6); ("bananas!", 8)] (fun (input, output) ->
    Js.String.length input == output);

  Only.describe "Only.describe" (fun () ->
    test "some aspect" (fun () -> 1 + 2 ==3)
  );