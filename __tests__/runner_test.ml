include Jest.Runner(struct
  type _ t = bool
  let affirm ok = assert ok
end)


let () =
  test "test" (fun () ->
    true);

  Skip.test "test - expect fail" (fun () ->
    false);
  
  testAsync "testAsync" (fun finish ->
    finish true);

  Skip.testAsync "testAsync - no done" (fun _ -> ());

  Skip.testAsync "testAsync - expect fail" (fun finish ->
    finish false);

  testPromise "testPromise" (fun () ->
    Js.Promise.resolve true);

  Skip.testPromise "testPromise - reject" (fun () ->
    Js.Promise.reject (Failure ""));

  Skip.testPromise "testPromise - expect fail" (fun () ->
    Js.Promise.resolve false);

  testAll "testAll" ["foo"; "bar"; "baz"] (fun input ->
    Js.String.length input == 3);
  testAll "testAll - tuples" [("foo", 3); ("barbaz", 6); ("bananas!", 8)] (fun (input, output) ->
    Js.String.length input == output);
  
  describe "describe" (fun () ->
    test "some aspect" (fun () ->
      true)
  );
  
  describe "beforeAll" (fun () -> 
    let x = ref 0 in
    
    beforeAll (fun () -> x := !x + 4);
    test "x is 4" (fun () -> !x == 4);
    test "x is still 4" (fun () -> !x == 4);
  );
  
  describe "beforeEach" (fun () -> 
    let x = ref 0 in
    
    beforeEach (fun () -> x := !x + 4);
    test "x is 4" (fun () -> !x == 4);
    test "x is suddenly 8" (fun () -> !x == 8);
  );
  
  describe "afterAll" (fun () -> 
    let x = ref 0 in
    
    describe "phase 1" (fun () ->
      afterAll (fun () -> x := !x + 4);
      test "x is 0" (fun () -> !x == 0)
    );
    
    describe "phase 2" (fun () -> 
      test "x is suddenly 4" (fun () -> !x == 4)
    );
  );
  
  describe "afterEach" (fun () -> 
    let x = ref 0 in
    
    afterEach (fun () -> x := !x + 4);
    test "x is 0" (fun () -> !x == 0);
    test "x is suddenly 4" (fun () -> !x == 4);
  );
  
  describe "Only" (fun () ->
   (* See runner_only_test.ml *)
   ()
  );

  describe "Skip" (fun () ->
    Skip.test "Skip.test" (fun () -> 1 + 2 == 3);

    Skip.testAsync "Skip.testAsync" (fun finish ->
      finish (1 + 2 == 3));

    Skip.testPromise "Skip.testPromise" (fun () ->
      Js.Promise.resolve (1 + 2 == 3));

    Skip.testAll "testAll" ["foo"; "bar"; "baz"] (fun input ->
      Js.String.length input == 3);
    Skip.testAll "testAll - tuples" [("foo", 3); ("barbaz", 6); ("bananas!", 8)] (fun (input, output) ->
      Js.String.length input == output);

    Skip.describe "Skip.describe" (fun () ->
      test "some aspect" (fun () -> 1 + 2 == 3)
    );
  );
  