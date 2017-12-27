include Jest.Runner(struct
  type _ t = bool
  let assert_ ok = assert ok
end)


let _ =
  test "test" (fun () ->
    true);

  Skip.test "test - expect fail" (fun _ ->
    false);
  
  testAsync "testAsync" (fun finish ->
    finish true);

  Skip.testAsync "testAsync - no done" (fun _ -> ());

  Skip.testAsync "testAsync - expect fail" (fun done_ ->
    done_ false);

  testPromise "testPromise" (fun _ ->
    Js.Promise.resolve true);

  Skip.testPromise "testPromise - reject" (fun _ ->
    Js.Promise.reject (Failure ""));
  Skip.testPromise "testPromise - expect fail" (fun _ ->
    Js.Promise.resolve false);

  testAll "testAll" ["foo"; "bar"; "baz"] (fun input ->
    Js.String.length input == 3);
  testAll "testAll - tuples" [("foo", 3); ("barbaz", 6); ("bananas!", 8)] (fun (input, output) ->
    Js.String.length input == output);
  
  describe "describe" (fun _ ->
    test "some aspect" (fun _ ->
      true)
  );
  
  describe "beforeAll" (fun _ -> 
    let x = ref 0 in
    
    beforeAll (fun _ -> x := !x + 4);
    test "x is 4" (fun _ -> !x == 4);
    test "x is still 4" (fun _ -> !x == 4);
  );
  
  describe "beforeEach" (fun _ -> 
    let x = ref 0 in
    
    beforeEach (fun _ -> x := !x + 4);
    test "x is 4" (fun _ -> !x == 4);
    test "x is suddenly 8" (fun _ -> !x == 8);
  );
  
  describe "afterAll" (fun _ -> 
    let x = ref 0 in
    
    describe "phase 1" (fun _ ->
      afterAll (fun _ -> x := !x + 4);
      test "x is 0" (fun _ -> !x == 0)
    );
    
    describe "phase 2" (fun _ -> 
      test "x is suddenly 4" (fun _ -> !x == 4)
    );
  );
  
  describe "afterEach" (fun _ -> 
    let x = ref 0 in
    
    afterEach (fun _ -> x := !x + 4);
    test "x is 0" (fun _ -> !x == 0);
    test "x is suddenly 4" (fun _ -> !x == 4);
  );
  
  describe "Only" (fun _ ->
   (* See runner_only_test.ml *)
   ()
  );

  describe "Skip" (fun _ ->
    Skip.test "Skip.test" (fun _ -> 1 + 2 == 3);

    Skip.testAsync "Skip.testAsync" (fun finish ->
      finish (1 + 2 == 3));

    Skip.testPromise "Skip.testPromise" (fun _ ->
      Js.Promise.resolve (1 + 2 == 3));

    Skip.testAll "testAll" ["foo"; "bar"; "baz"] (fun input ->
      Js.String.length input == 3);
    Skip.testAll "testAll - tuples" [("foo", 3); ("barbaz", 6); ("bananas!", 8)] (fun (input, output) ->
      Js.String.length input == output);

    Skip.describe "Skip.describe" (fun _ ->
      test "some aspect" (fun _ -> 1 + 2 == 3)
    );
  );
  