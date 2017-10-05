open Jest
open Expect

let _ =
  test "test" (fun _ ->
    expect (1 + 2) |> toBe 3);
  (*
  test "test - expect fail" (fun _ ->
    expect (1 + 2) |> toBe 4);
  *)
  
  testAsync "testAsync" (fun done_ ->
    done_ (expect (1 + 2) |> toBe 3));
  (*
  testAsync "testAsync - no done" (fun _ -> ());
  *)
  (*
  testAsync "testAsync - expect fail" (fun done_ ->
    done_ (expect (1 + 2) |> toBe 4));
  *)
  
  testPromise "testPromise" (fun _ ->
    Js.Promise.resolve (expect (1 + 2) |> toBe 3));
  (*
  testPromise "testPromise - reject" (fun _ ->
    Promise.reject ());
  *)
  (*
  testPromise "testPromise - expect fail" (fun _ ->
    Promise.resolve (expect (1 + 2) |> toBe 4));
  *)

  testAll "testAll" ["foo"; "bar"; "baz"] (fun input ->
    expect (Js.String.length input) |> toEqual 3);
  testAll "testAll - tuples" [("foo", 3); ("barbaz", 6); ("bananas!", 8)] (fun (input, output) ->
    expect (Js.String.length input) |> toEqual output);
  
  describe "describe" (fun _ ->
    test "some aspect" (fun _ -> expect (1 + 2) |> toBe 3)
  );
  
  describe "beforeAll" (fun _ -> 
    let x = ref 0 in
    
    beforeAll (fun _ -> x := !x + 4);
    test "x is 4" (fun _ -> expect !x |> toBe 4);
    test "x is still 4" (fun _ -> expect !x |> toBe 4);
  );
  
  describe "beforeEach" (fun _ -> 
    let x = ref 0 in
    
    beforeEach (fun _ -> x := !x + 4);
    test "x is 4" (fun _ -> expect !x |> toBe 4);
    test "x is suddenly 8" (fun _ -> expect !x |> toBe 8);
  );
  
  describe "afterAll" (fun _ -> 
    let x = ref 0 in
    
    describe "phase 1" (fun _ ->
      afterAll (fun _ -> x := !x + 4);
      test "x is 0" (fun _ -> expect !x |> toBe 0)
    );
    
    describe "phase 2" (fun _ -> 
      test "x is suddenly 4" (fun _ -> expect !x |> toBe 4)
    );
  );
  
  describe "afterEach" (fun _ -> 
    let x = ref 0 in
    
    afterEach (fun _ -> x := !x + 4);
    test "x is 0" (fun _ -> expect !x |> toBe 0);
    test "x is suddenly 4" (fun _ -> expect !x |> toBe 4);
  );

  describe "Only" (fun _ ->
    (*
    Only.test "Only.test" (fun _ -> (expect (1 + 2) |> toBe 3));

    Only.testAsync "Only.testAsync" (fun done_ ->
      done_ (expect (1 + 2) |> toBe 3));

    Only.testPromise "Only.testPromise" (fun _ ->
      Promise.resolve (expect (1 + 2) |> toBe 3));

    Only.testAll "testAll" ["foo"; "bar"; "baz"] (fun input ->
      expect (Js.String.length input) |> toEqual 3);
    Only.testAll "testAll - tuples" [("foo", 3); ("barbaz", 6); ("bananas!", 8)] (fun (input, output) ->
      expect (Js.String.length input) |> toEqual output);

    Only.describe "Only.describe" (fun _ ->
      test "some aspect" (fun _ -> (expect (1 + 2)) |> toBe 3)
    );
    *)
    ()
  );
  
  describe "Skip" (fun _ ->
    Skip.test "Skip.test" (fun _ -> expect (1 + 2) |> toBe 3);

    Skip.testAsync "Skip.testAsync" (fun done_ ->
      done_ (expect (1 + 2) |> toBe 3));

    Skip.testPromise "Skip.testPromise" (fun _ ->
      Js.Promise.resolve (expect (1 + 2) |> toBe 3));

    Skip.testAll "testAll" ["foo"; "bar"; "baz"] (fun input ->
      expect (Js.String.length input) |> toEqual 3);
    Skip.testAll "testAll - tuples" [("foo", 3); ("barbaz", 6); ("bananas!", 8)] (fun (input, output) ->
      expect (Js.String.length input) |> toEqual output);

    Skip.describe "Skip.describe" (fun _ ->
      test "some aspect" (fun _ -> expect (1 + 2) |> toBe 3)
    );
  );
  