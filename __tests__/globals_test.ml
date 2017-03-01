open Jest

let _ =
  test "test" (fun _ -> Expect6.((expect (1 + 2)) # toBe 3));
  (*
  test "test - expect fail" (fun _ -> Option4.(expect (1 + 2) |> be 4));
  *)
  (* These could also be modeled as `Only.test` and `Only.skip`, might work better with the async and promise variants *)
  (*
  testOnly "testOnly" (fun _ -> Option6.((expect (1 + 2)) # toBe 3));
  *)
  testSkip "testSkip" (fun _ -> Expect6.((expect (1 + 2)) # toBe 3));
  
  testAsync "testAsync" (fun done_ -> done_ Expect4.(expect (1 + 2) |> be 3));
  (*
  testAsync "testAsync - no done" (fun _ -> ());
  *)
  (*
  testAsync "testAsync - expect fail" (fun done_ -> done_ Option4.(expect (1 + 2) |> be 4));
  *)
  (*
  testAsyncOnly "testAsyncOnly" (fun done_ -> done_ Option4.(expect (1 + 2) |> be 3));
  *)
  testAsyncSkip "testAsyncSkip" (fun done_ -> done_ Expect4.(expect (1 + 2) |> be 3));
  
  testPromise "testPromise" (fun _ -> Promise.resolve Expect4.(expect (1 + 2) |> be 3));
  (*
  testPromise "testPromise - reject" (fun _ -> Promise.reject ());
  *)
  (*
  testPromise "testPromise - expect fail" (fun _ -> Promise.resolve Option4.(expect (1 + 2) |> be 4));
  *)
  (*
  testPromiseOnly "testPromiseOnly" (fun _ -> Promise.resolve Option4.(expect (1 + 2) |> be 3));
  *)
  testPromiseSkip "testPromiseSkip" (fun _ -> Promise.resolve Expect4.(expect (1 + 2) |> be 3));
  
  describe "describe" (fun _ ->
    let open Expect6 in
    
    test "some aspect" (fun _ -> (expect (1 + 2)) # toBe 3)
  );
  
  (*
  describeOnly "describeOnly" (fun _ ->
    let open Option6 in
    test "some aspect" (fun _ -> (expect (1 + 2)) # toBe 3)
  );
  *)
  describeSkip "describeSkip" (fun _ ->
    let open Expect6 in
    
    test "some aspect" (fun _ -> (expect (1 + 2)) # toBe 3)
  );
  
  describe "beforeAll" (fun _ -> 
    let open Expect4 in
    let x = ref 0 in
    
    beforeAll (fun _ -> x := !x + 4);
    test "x is 4" (fun _ -> expect !x |> be 4);
    test "x is still 4" (fun _ -> expect !x |> be 4);
  );
  
  describe "beforeEach" (fun _ -> 
    let open Expect4 in
    let x = ref 0 in
    
    beforeEach (fun _ -> x := !x + 4);
    test "x is 4" (fun _ -> expect !x |> be 4);
    test "x is suddenly 8" (fun _ -> expect !x |> be 8);
  );
  
  describe "afterAll" (fun _ -> 
    let open Expect4 in
    let x = ref 0 in
    
    describe "phase 1" (fun _ ->
      afterAll (fun _ -> x := !x + 4);
      test "x is 0" (fun _ -> expect !x |> be 0)
    );
    
    describe "phase 2" (fun _ -> 
      test "x is suddenly 4" (fun _ -> expect !x |> be 4)
    );
  );
  
  describe "afterEach" (fun _ -> 
    let open Expect4 in
    let x = ref 0 in
    
    afterEach (fun _ -> x := !x + 4);
    test "x is 0" (fun _ -> expect !x |> be 0);
    test "x is suddenly 4" (fun _ -> expect !x |> be 4);
  );
  
  
