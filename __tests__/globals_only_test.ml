open Jest
open Expect

let _ =

  Only.test "Only.test" (fun _ -> (expect (1 + 2) |> toBe 3));

  Only.testAsync "Only.testAsync" (fun done_ ->
    done_ (expect (1 + 2) |> toBe 3));

  Only.testPromise "Only.testPromise" (fun _ ->
    Js.Promise.resolve (expect (1 + 2) |> toBe 3));

  Only.testAll "testAll" ["foo"; "bar"; "baz"] (fun input ->
    expect (Js.String.length input) |> toEqual 3);
  Only.testAll "testAll - tuples" [("foo", 3); ("barbaz", 6); ("bananas!", 8)] (fun (input, output) ->
    expect (Js.String.length input) |> toEqual output);

  Only.describe "Only.describe" (fun _ ->
    test "some aspect" (fun _ -> (expect (1 + 2)) |> toBe 3)
  );