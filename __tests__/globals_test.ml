open Jest

let _ =
  test "pass" (fun _ ->
    pass);

  Skip.test "fail" (fun _ ->
    fail "");

  test "test" (fun _ ->
    pass);
    
  Skip.test "test - expect fail" (fun _ ->
    fail "");
  
  testAsync "testAsync" (fun finish ->
    finish pass);
    
  Skip.testAsync "testAsync - no done" (fun _ -> ());

  Skip.testAsync "testAsync - expect fail" (fun finish ->
    finish (fail ""));
  
  testPromise "testPromise" (fun _ ->
    Js.Promise.resolve pass);

  Skip.testPromise "testPromise - reject" (fun _ ->
    Js.Promise.reject (Failure ""));

  Skip.testPromise "testPromise - expect fail" (fun _ ->
    Js.Promise.resolve (fail ""));

  testAll "testAll" ["foo"; "bar"; "baz"] (fun input ->
    if Js.String.length input == 3 then pass else fail "");
  testAll "testAll - tuples" [("foo", 3); ("barbaz", 6); ("bananas!", 8)] (fun (input, output) ->
    if Js.String.length input == output then pass else fail "");
  
  describe "describe" (fun _ ->
    test "some aspect" (fun _ -> pass)
  );
  
  describe "beforeAll" (fun _ -> 
    let x = ref 0 in
    
    beforeAll (fun _ -> x := !x + 4);
    test "x is 4" (fun _ -> if !x == 4 then pass else fail "");
    test "x is still 4" (fun _ -> if !x == 4 then pass else fail "");
  );
  
  describe "beforeEach" (fun _ -> 
    let x = ref 0 in
    
    beforeEach (fun _ -> x := !x + 4);
    test "x is 4" (fun _ -> if !x == 4 then pass else fail "");
    test "x is suddenly 8" (fun _ -> if !x == 8 then pass else fail "");
  );
  
  describe "afterAll" (fun _ -> 
    let x = ref 0 in
    
    describe "phase 1" (fun _ ->
      afterAll (fun _ -> x := !x + 4);
      test "x is 0" (fun _ -> if !x == 0 then pass else fail "")
    );
    
    describe "phase 2" (fun _ -> 
      test "x is suddenly 4" (fun _ -> if !x == 4 then pass else fail "")
    );
  );
  
  describe "afterEach" (fun _ -> 
    let x = ref 0 in
    
    afterEach (fun _ -> x := !x + 4);
    test "x is 0" (fun _ -> if !x == 0 then pass else fail "");
    test "x is suddenly 4" (fun _ -> if !x == 4 then pass else fail "");
  );
  
  describe "Only" (fun _ ->
   (* See globals_only_test.ml *)
   ()
  );

  describe "Skip" (fun _ ->
    Skip.test "Skip.test" (fun _ -> pass);

    Skip.testAsync "Skip.testAsync" (fun finish ->
      finish pass);

    Skip.testPromise "Skip.testPromise" (fun _ ->
      Js.Promise.resolve pass);

    Skip.testAll "testAll" ["foo"; "bar"; "baz"] (fun input ->
      if Js.String.length input == 3 then pass else fail "");
    Skip.testAll "testAll - tuples" [("foo", 3); ("barbaz", 6); ("bananas!", 8)] (fun (input, output) ->
      if Js.String.length input == output then pass else fail "");

    Skip.describe "Skip.describe" (fun _ ->
      test "some aspect" (fun _ -> pass);
    );
  );
  