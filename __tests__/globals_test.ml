open Jest

let () =
  test "pass" (fun () ->
    pass);

  Skip.test "fail" (fun () ->
    fail "");

  test "test" (fun () ->
    pass);
    
  Skip.test "test - expect fail" (fun () ->
    fail "");
  
  testAsync "testAsync" (fun finish ->
    finish pass);
    
  Skip.testAsync "testAsync - no done" (fun _ -> ());

  Skip.testAsync "testAsync - expect fail" (fun finish ->
    finish (fail ""));
  
  testPromise "testPromise" (fun () ->
    Js.Promise.resolve pass);

  Skip.testPromise "testPromise - reject" (fun () ->
    Js.Promise.reject (Failure ""));

  Skip.testPromise "testPromise - expect fail" (fun () ->
    Js.Promise.resolve (fail ""));

  testAll "testAll" ["foo"; "bar"; "baz"] (fun input ->
    if Js.String.length input == 3 then pass else fail "");
  testAll "testAll - tuples" [("foo", 3); ("barbaz", 6); ("bananas!", 8)] (fun (input, output) ->
    if Js.String.length input == output then pass else fail "");
  
  describe "describe" (fun () ->
    test "some aspect" (fun () -> pass)
  );
  
  describe "beforeAll" (fun () -> 
    let x = ref 0 in
    
    beforeAll (fun () -> x := !x + 4);
    test "x is 4" (fun () -> if !x == 4 then pass else fail "");
    test "x is still 4" (fun () -> if !x == 4 then pass else fail "");
  );
  
  describe "beforeEach" (fun () -> 
    let x = ref 0 in
    
    beforeEach (fun () -> x := !x + 4);
    test "x is 4" (fun () -> if !x == 4 then pass else fail "");
    test "x is suddenly 8" (fun () -> if !x == 8 then pass else fail "");
  );
  
  describe "afterAll" (fun () -> 
    let x = ref 0 in
    
    describe "phase 1" (fun () ->
      afterAll (fun () -> x := !x + 4);
      test "x is 0" (fun () -> if !x == 0 then pass else fail "")
    );
    
    describe "phase 2" (fun () -> 
      test "x is suddenly 4" (fun () -> if !x == 4 then pass else fail "")
    );
  );
  
  describe "afterEach" (fun () -> 
    let x = ref 0 in
    
    afterEach (fun () -> x := !x + 4);
    test "x is 0" (fun () -> if !x == 0 then pass else fail "");
    test "x is suddenly 4" (fun () -> if !x == 4 then pass else fail "");
  );
  
  describe "Only" (fun () ->
   (* See globals_only_test.ml *)
   ()
  );

  describe "Skip" (fun () ->
    Skip.test "Skip.test" (fun () -> pass);

    Skip.testAsync "Skip.testAsync" (fun finish ->
      finish pass);

    Skip.testPromise "Skip.testPromise" (fun () ->
      Js.Promise.resolve pass);

    Skip.testAll "testAll" ["foo"; "bar"; "baz"] (fun input ->
      if Js.String.length input == 3 then pass else fail "");
    Skip.testAll "testAll - tuples" [("foo", 3); ("barbaz", 6); ("bananas!", 8)] (fun (input, output) ->
      if Js.String.length input == output then pass else fail "");

    Skip.describe "Skip.describe" (fun () ->
      test "some aspect" (fun () -> pass);
    );
  );
  