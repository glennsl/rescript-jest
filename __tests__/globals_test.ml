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

  testAsync "testAsync - timeout ok" ~timeout:1 (fun finish ->
    finish pass);
    
  Skip.testAsync "testAsync - timeout fail" ~timeout:1 (fun _ -> ());

  
  testPromise "testPromise" (fun () ->
    Js.Promise.resolve pass);

  Skip.testPromise "testPromise - reject" (fun () ->
    Js.Promise.reject (Failure ""));

  Skip.testPromise "testPromise - expect fail" (fun () ->
    Js.Promise.resolve (fail ""));

  testPromise "testPromise - timeout ok" ~timeout:1 (fun () ->
    Js.Promise.resolve pass);
    
  Skip.testPromise "testPromise - timeout fail" ~timeout:1 (fun () ->
    Js.Promise.make (fun ~resolve:_ ~reject:_ -> ()));


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
  
  describe "beforeAllAsync" (fun () ->
    describe "without timeout" (fun () ->
      let x = ref 0 in

      beforeAllAsync (fun (finish) -> x := !x + 4; finish ());

      test "x is 4" (fun () -> if !x == 4 then pass else fail "");
      test "x is still 4" (fun () -> if !x == 4 then pass else fail "");
    );

    describe "with 100ms timeout" (fun () ->
      let x = ref 0 in

      beforeAllAsync ~timeout:100 (fun (finish) -> x := !x + 4; finish ());

      test "x is 4" (fun () -> if !x == 4 then pass else fail "");
      test "x is still 4" (fun () -> if !x == 4 then pass else fail "");
    );

    Skip.describe "timeout should fail suite" (fun () ->
      (* This apparently runs even if the suite is skipped *)
      (*beforeAllAsync ~timeout:1 (fun _ ->());*)

      test "" (fun () -> pass); (* runner will crash if there's no tests *)
    );
  );

  describe "beforeAllPromise" (fun () ->
    describe "without timeout" (fun () ->
      let x = ref 0 in

      beforeAllPromise (fun () -> x := !x + 4; Js.Promise.resolve ());

      test "x is 4" (fun () -> if !x == 4 then pass else fail "");
      test "x is still 4" (fun () -> if !x == 4 then pass else fail "");
    );

    describe "with 100ms timeout" (fun () ->
      let x = ref 0 in

      beforeAllPromise ~timeout:100 (fun () -> x := !x + 4; Js.Promise.resolve ());

      test "x is 4" (fun () -> if !x == 4 then pass else fail "");
      test "x is still 4" (fun () -> if !x == 4 then pass else fail "");
    );

    Skip.describe "timeout should fail suite" (fun () ->
      (* This apparently runs even if the suite is skipped *)
      (*beforeAllPromise ~timeout:1 (fun () -> Js.Promise.make (fun ~resolve:_ ~reject:_ -> ()));*)

      test "" (fun () -> pass); (* runner will crash if there's no tests *)
    );
  );


  describe "beforeEach" (fun () -> 
    let x = ref 0 in
    
    beforeEach (fun () -> x := !x + 4);

    test "x is 4" (fun () -> if !x == 4 then pass else fail "");
    test "x is suddenly 8" (fun () -> if !x == 8 then pass else fail "");
  );
 
  describe "beforeEachAsync" (fun () ->
    describe "without timeout" (fun () ->
      let x = ref 0 in

      beforeEachAsync (fun (finish) -> x := !x + 4; finish ());

      test "x is 4" (fun () -> if !x == 4 then pass else fail "");
      test "x is suddenly 8" (fun () -> if !x == 8 then pass else fail "");
    );

    describe "with 100ms timeout" (fun () ->
      let x = ref 0 in

      beforeEachAsync ~timeout:100 (fun (finish) -> x := !x + 4; finish ());

      test "x is 4" (fun () -> if !x == 4 then pass else fail "");
      test "x is suddenly 8" (fun () -> if !x == 8 then pass else fail "");
    );

    Skip.describe "timeout should fail suite" (fun () ->
      beforeEachAsync ~timeout:1 (fun _ -> ());

      test "" (fun () -> pass); (* runner will crash if there's no tests *)
    );
  );

  describe "beforeEachPromise" (fun () ->
    describe "without timeout" (fun () ->
      let x = ref 0 in

      beforeEachPromise (fun () -> x := !x + 4; Js.Promise.resolve true);

      test "x is 4" (fun () -> if !x == 4 then pass else fail "");
      test "x is suddenly 8" (fun () -> if !x == 8 then pass else fail "");
    );

    describe "with 100ms timeout" (fun () ->
      let x = ref 0 in

      beforeEachPromise ~timeout:100 (fun () -> x := !x + 4; Js.Promise.resolve true);

      test "x is 4" (fun () -> if !x == 4 then pass else fail "");
      test "x is suddenly 8" (fun () -> if !x == 8 then pass else fail "");
    );

    Skip.describe "timeout should fail suite" (fun () ->
      beforeEachPromise ~timeout:1 (fun () -> Js.Promise.make (fun ~resolve:_ ~reject:_ -> ()));

      test "" (fun () -> pass); (* runner will crash if there's no tests *)
    );
  ); 


  describe "afterAll" (fun () -> 
    let x = ref 0 in
    
    describe "phase 1" (fun () ->
      afterAll (fun () -> x := !x + 4);

      test "x is 0" (fun () -> if !x == 0 then pass else fail "");
      test "x is still 0" (fun () -> if !x == 0 then pass else fail "");
    );
    
    describe "phase 2" (fun () -> 
      test "x is suddenly 4" (fun () -> if !x == 4 then pass else fail "");
    );
  );
  
  describe "afterAllAsync" (fun () ->
    describe "without timeout" (fun () ->
      let x = ref 0 in

      describe "phase 1" (fun () ->
        afterAllAsync (fun (finish) -> x := !x + 4; finish ());

        test "x is 0" (fun () -> if !x == 0 then pass else fail "");
        test "x is still 0" (fun () -> if !x == 0 then pass else fail "");
      );

      describe "phase 2" (fun () ->
        test "x is suddenly 4" (fun () -> if !x == 4 then pass else fail "");
      );
    );

    describe "with 100ms timeout" (fun () ->
      let x = ref 0 in

      describe "phase 1" (fun () ->
        afterAllAsync ~timeout:100 (fun (finish) -> x := !x + 4; finish ());

        test "x is 0" (fun () -> if !x == 0 then pass else fail "");
        test "x is still 0" (fun () -> if !x == 0 then pass else fail "");
      );

      describe "phase 2" (fun () ->
        test "x is suddenly 4" (fun () -> if !x == 4 then pass else fail "");
      );
    );

    describe "timeout should not fail suite" (fun () ->
      afterAllAsync ~timeout:1 (fun _ ->());

      test "" (fun () -> pass); (* runner will crash if there's no tests *)
    );
  );

  describe "afterAllPromise" (fun () ->
    describe "without timeout" (fun () ->
      let x = ref 0 in

      describe "phase 1" (fun () ->
        afterAllPromise (fun () -> x := !x + 4; Js.Promise.resolve true);

        test "x is 0" (fun () -> if !x == 0 then pass else fail "");
        test "x is still 0" (fun () -> if !x == 0 then pass else fail "");
      );

      describe "phase 2" (fun () ->
        test "x is suddenly 4" (fun () -> if !x == 4 then pass else fail "");
      );
    );

    describe "with 100ms timeout" (fun () ->
      let x = ref 0 in

      describe "phase 1" (fun () ->
        afterAllPromise ~timeout:100 (fun () -> x := !x + 4; Js.Promise.resolve true);

        test "x is 0" (fun () -> if !x == 0 then pass else fail "");
        test "x is still 0" (fun () -> if !x == 0 then pass else fail "");
      );

      describe "phase 2" (fun () ->
        test "x is suddenly 4" (fun () -> if !x == 4 then pass else fail "");
      );
    );

    describe "timeout should not fail suite" (fun () ->
      afterAllPromise ~timeout:1 (fun () -> Js.Promise.make (fun ~resolve:_ ~reject:_ -> ()));

      test "" (fun () -> pass); (* runner will crash if there's no tests *)
    );
  );


  describe "afterEach" (fun () -> 
    let x = ref 0 in
    
    afterEach (fun () -> x := !x + 4);

    test "x is 0" (fun () -> if !x == 0 then pass else fail "");
    test "x is suddenly 4" (fun () -> if !x == 4 then pass else fail "");
  );
  
  describe "afterEachAsync" (fun () ->
    describe "without timeout" (fun () ->
      let x = ref 0 in

      afterEachAsync (fun (finish) -> x := !x + 4; finish ());

      test "x is 0" (fun () -> if !x == 0 then pass else fail "");
      test "x is suddenly 4" (fun () -> if !x == 4 then pass else fail "");
    );

    describe "with 100ms timeout" (fun () ->
      let x = ref 0 in

      afterEachAsync ~timeout:100 (fun (finish) -> x := !x + 4; finish ());

      test "x is 0" (fun () -> if !x == 0 then pass else fail "");
      test "x is suddenly 4" (fun () -> if !x == 4 then pass else fail "");
    );

    Skip.describe "timeout should fail suite" (fun () ->
      afterEachAsync ~timeout:1 (fun _ -> ());

      test "" (fun () -> pass); (* runner will crash if there's no tests *)
    );
  );

  describe "afterEachPromise" (fun () ->
    describe "without timeout" (fun () ->
      let x = ref 0 in

      afterEachPromise (fun () -> x := !x + 4; Js.Promise.resolve true);

      test "x is 0" (fun () -> if !x == 0 then pass else fail "");
      test "x is suddenly 4" (fun () -> if !x == 4 then pass else fail "");
    );

    describe "with 100ms timeout" (fun () ->
      let x = ref 0 in

      afterEachPromise ~timeout:100 (fun () -> x := !x + 4; Js.Promise.resolve true);

      test "x is 0" (fun () -> if !x == 0 then pass else fail "");
      test "x is suddenly 4" (fun () -> if !x == 4 then pass else fail "");
    );

    Skip.describe "timeout should fail suite" (fun () ->
      afterEachPromise ~timeout:1 (fun () -> Js.Promise.make (fun ~resolve:_ ~reject:_ -> ()));

      test "" (fun () -> pass); (* runner will crash if there's no tests *)
    );
  );


  describe "Only" (fun () ->
   (* See globals_only_test.ml *)
   ()
  );


  describe "Skip" (fun () ->
    Skip.test "Skip.test" (fun () -> pass);

    Skip.testAsync "Skip.testAsync" (fun finish ->
      finish pass);
    Skip.testAsync "Skip.testAsync - timeout" ~timeout:1 (fun _ -> ());

    Skip.testPromise "Skip.testPromise" (fun () ->
      Js.Promise.resolve pass);
    Skip.testPromise "testPromise - timeout" ~timeout:1 (fun () ->
      Js.Promise.make (fun ~resolve:_ ~reject:_ -> ()));

    Skip.testAll "testAll" ["foo"; "bar"; "baz"] (fun input ->
      if Js.String.length input == 3 then pass else fail "");
    Skip.testAll "testAll - tuples" [("foo", 3); ("barbaz", 6); ("bananas!", 8)] (fun (input, output) ->
      if Js.String.length input == output then pass else fail "");

    Skip.describe "Skip.describe" (fun () ->
      test "some aspect" (fun () -> pass);
    );

  );
  
  describe "Todo" (fun () ->
    Todo.test "Todo.test";
  )