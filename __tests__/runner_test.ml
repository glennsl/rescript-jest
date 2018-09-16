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

  testAsync "testAsync - timeout ok" ~timeout:1 (fun finish ->
    finish true);
    
  Skip.testAsync "testAsync - timeout fail" ~timeout:1 (fun _ -> ());


  testPromise "testPromise" (fun () ->
    Js.Promise.resolve true);

  Skip.testPromise "testPromise - reject" (fun () ->
    Js.Promise.reject (Failure ""));

  Skip.testPromise "testPromise - expect fail" (fun () ->
    Js.Promise.resolve false);

  testPromise "testPromise - timeout ok" ~timeout:1 (fun () ->
    Js.Promise.resolve true);
    
  Skip.testPromise "testPromise - timeout fail" ~timeout:1 (fun () ->
    Js.Promise.make (fun ~resolve:_ ~reject:_ -> ()));


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
  
  describe "beforeAllAsync" (fun () ->
    describe "without timeout" (fun () ->
      let x = ref 0 in

      beforeAllAsync (fun (finish) -> x := !x + 4; finish ());

      test "x is 4" (fun () -> !x == 4);
      test "x is still 4" (fun () -> !x == 4);
    );

    describe "with 100ms timeout" (fun () ->
      let x = ref 0 in

      beforeAllAsync ~timeout:100 (fun (finish) -> x := !x + 4; finish ());

      test "x is 4" (fun () -> !x == 4);
      test "x is still 4" (fun () -> !x == 4);
    );

    Skip.describe "timeout should fail suite" (fun () ->
      (* This apparently runs even if the suite is skipped *)
      (*beforeAllAsync ~timeout:1 (fun _ ->());*)

      test "" (fun () -> true); (* runner will crash if there's no tests *)
    );
  );

  describe "beforeAllPromise" (fun () ->
    describe "without timeout" (fun () ->
      let x = ref 0 in

      beforeAllPromise (fun () -> x := !x + 4; Js.Promise.resolve ());

      test "x is 4" (fun () -> !x == 4);
      test "x is still 4" (fun () -> !x == 4);
    );

    describe "with 100ms timeout" (fun () ->
      let x = ref 0 in

      beforeAllPromise ~timeout:100 (fun () -> x := !x + 4; Js.Promise.resolve ());

      test "x is 4" (fun () -> !x == 4);
      test "x is still 4" (fun () -> !x == 4);
    );

    Skip.describe "timeout should fail suite" (fun () ->
      (* This apparently runs even if the suite is skipped *)
      (*beforeAllPromise ~timeout:1 (fun () -> Js.Promise.make (fun ~resolve:_ ~reject:_ -> ()));*)

      test "" (fun () -> true); (* runner will crash if there's no tests *)
    );
  );

  describe "beforeEach" (fun () -> 
    let x = ref 0 in
    
    beforeEach (fun () -> x := !x + 4);

    test "x is 4" (fun () -> !x == 4);
    test "x is suddenly 8" (fun () -> !x == 8);
  );

  describe "beforeEachAsync" (fun () ->
    describe "without timeout" (fun () ->
      let x = ref 0 in

      beforeEachAsync (fun (finish) -> x := !x + 4; finish ());

      test "x is 4" (fun () -> !x == 4);
      test "x is suddenly 8" (fun () -> !x == 8);
    );

    describe "with 100ms timeout" (fun () ->
      let x = ref 0 in

      beforeEachAsync ~timeout:100 (fun (finish) -> x := !x + 4; finish ());

      test "x is 4" (fun () -> !x == 4);
      test "x is suddenly 8" (fun () -> !x == 8);
    );

    Skip.describe "timeout should fail suite" (fun () ->
      beforeEachAsync ~timeout:1 (fun _ -> ());

      test "" (fun () -> true); (* runner will crash if there's no tests *)
    );
  );

  describe "beforeEachPromise" (fun () ->
    describe "without timeout" (fun () ->
      let x = ref 0 in

      beforeEachPromise (fun () -> x := !x + 4; Js.Promise.resolve true);

      test "x is 4" (fun () -> !x == 4);
      test "x is suddenly 8" (fun () -> !x == 8);
    );

    describe "with 100ms timeout" (fun () ->
      let x = ref 0 in

      beforeEachPromise ~timeout:100 (fun () -> x := !x + 4; Js.Promise.resolve true);

      test "x is 4" (fun () -> !x == 4);
      test "x is suddenly 8" (fun () -> !x == 8);
    );

    Skip.describe "timeout should fail suite" (fun () ->
      beforeEachPromise ~timeout:1 (fun () -> Js.Promise.make (fun ~resolve:_ ~reject:_ -> ()));

      test "" (fun () -> true); (* runner will crash if there's no tests *)
    );
  );
  
  describe "afterAll" (fun () -> 
    let x = ref 0 in
    
    describe "phase 1" (fun () ->
      afterAll (fun () -> x := !x + 4);

      test "x is 0" (fun () -> !x == 0);
      test "x is still 0" (fun () -> !x == 0);
    );
    
    describe "phase 2" (fun () -> 
      test "x is suddenly 4" (fun () -> !x == 4);
    );
  );
  
  describe "afterAllAsync" (fun () ->
    describe "without timeout" (fun () ->
      let x = ref 0 in

      describe "phase 1" (fun () ->
        afterAllAsync (fun (finish) -> x := !x + 4; finish ());

        test "x is 0" (fun () -> !x == 0);
        test "x is still 0" (fun () -> !x == 0);
      );

      describe "phase 2" (fun () ->
        test "x is suddenly 4" (fun () -> !x == 4);
      );
    );

    describe "with 100ms timeout" (fun () ->
      let x = ref 0 in

      describe "phase 1" (fun () ->
        afterAllAsync ~timeout:100 (fun (finish) -> x := !x + 4; finish ());

        test "x is 0" (fun () -> !x == 0);
        test "x is still 0" (fun () -> !x == 0);
      );

      describe "phase 2" (fun () ->
        test "x is suddenly 4" (fun () -> !x == 4);
      );
    );

    describe "timeout should not fail suite" (fun () ->
      afterAllAsync ~timeout:1 (fun _ ->());

      test "" (fun () -> true); (* runner will crash if there's no tests *)
    );
  );

  describe "afterAllPromise" (fun () ->
    describe "without timeout" (fun () ->
      let x = ref 0 in

      describe "phase 1" (fun () ->
        afterAllPromise (fun () -> x := !x + 4; Js.Promise.resolve true);

        test "x is 0" (fun () -> !x == 0);
        test "x is still 0" (fun () -> !x == 0);
      );

      describe "phase 2" (fun () ->
        test "x is suddenly 4" (fun () -> !x == 4);
      );
    );

    describe "with 100ms timeout" (fun () ->
      let x = ref 0 in

      describe "phase 1" (fun () ->
        afterAllPromise ~timeout:100 (fun () -> x := !x + 4; Js.Promise.resolve true);

        test "x is 0" (fun () -> !x == 0);
        test "x is still 0" (fun () -> !x == 0);
      );

      describe "phase 2" (fun () ->
        test "x is suddenly 4" (fun () -> !x == 4);
      );
    );

    describe "timeout should not fail suite" (fun () ->
      afterAllPromise ~timeout:1 (fun () -> Js.Promise.make (fun ~resolve:_ ~reject:_ -> ()));

      test "" (fun () -> true); (* runner will crash if there's no tests *)
    );
  );

  describe "afterEach" (fun () -> 
    let x = ref 0 in
    
    afterEach (fun () -> x := !x + 4);
    
    test "x is 0" (fun () -> !x == 0);
    test "x is suddenly 4" (fun () -> !x == 4);
  );
  
  describe "afterEachAsync" (fun () ->
    describe "without timeout" (fun () ->
      let x = ref 0 in

      afterEachAsync (fun (finish) -> x := !x + 4; finish ());

      test "x is 0" (fun () -> !x == 0);
      test "x is suddenly 4" (fun () -> !x == 4);
    );

    describe "with 100ms timeout" (fun () ->
      let x = ref 0 in

      afterEachAsync ~timeout:100 (fun (finish) -> x := !x + 4; finish ());

      test "x is 0" (fun () -> !x == 0);
      test "x is suddenly 4" (fun () -> !x == 4);
    );

    Skip.describe "timeout should fail suite" (fun () ->
      afterEachAsync ~timeout:1 (fun _ -> ());

      test "" (fun () -> true); (* runner will crash if there's no tests *)
    );
  );

  describe "afterEachPromise" (fun () ->
    describe "without timeout" (fun () ->
      let x = ref 0 in

      afterEachPromise (fun () -> x := !x + 4; Js.Promise.resolve true);

      test "x is 0" (fun () -> !x == 0);
      test "x is suddenly 4" (fun () -> !x == 4);
    );

    describe "with 100ms timeout" (fun () ->
      let x = ref 0 in

      afterEachPromise ~timeout:100 (fun () -> x := !x + 4; Js.Promise.resolve true);

      test "x is 0" (fun () -> !x == 0);
      test "x is suddenly 4" (fun () -> !x == 4);
    );

    Skip.describe "timeout should fail suite" (fun () ->
      afterEachPromise ~timeout:1 (fun () -> Js.Promise.make (fun ~resolve:_ ~reject:_ -> ()));

      test "" (fun () -> true); (* runner will crash if there's no tests *)
    );
  );
  
  describe "Only" (fun () ->
   (* See runner_only_test.ml *)
   ()
  );

  describe "Skip" (fun () ->
    Skip.test "Skip.test" (fun () -> false);

    Skip.testAsync "Skip.testAsync" (fun finish ->
      finish false);
    Skip.testAsync "Skip.testAsync - timeout" ~timeout:1 (fun _ -> ());

    Skip.testPromise "Skip.testPromise" (fun () ->
      Js.Promise.resolve false);
    Skip.testPromise "testPromise - timeout" ~timeout:1 (fun () ->
      Js.Promise.make (fun ~resolve ~reject:_ -> (resolve false)[@bs]));

    Skip.testAll "testAll" ["foo"; "bar"; "baz"] (fun _ ->
      false);
    Skip.testAll "testAll - tuples" [("foo", 3); ("barbaz", 6); ("bananas!", 8)] (fun (_, _) ->
      false);

    Skip.describe "Skip.describe" (fun () ->
      test "some aspect" (fun () -> false)
    );
  );