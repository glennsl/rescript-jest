open Jest

let _ =
  Expect1.(
    (* pro: no extra parens
     * pro: can easily be chained
     * con: noisy symbol
     *)
    test "the first" (fun _ -> expect (1 + 2) |> toBe 3);
    test "not the first" (fun _ -> expect (1 + 2) |> not_ |> toBe 4);
    test "close to the first" (fun _ -> expect (1. +. 2.) |> toBeSoCloseTo 3. ~digits:9)
  );
  
  Expect2.(
    (* pro: separate words
     * pro: simpler implementation of modifiers like `not`
     * con: oddly placed extra parens
     * con: several noisy symbols
     * con: can only support `to*` functions
     * con: chaining using the same convention will get very messy very fast
     *)
    test "the second" (fun _ -> expect (1 + 2) ~to_:(be 3));
    test "not the second" (fun _ -> expect (1 + 2) ~to_:(not_ (be 4)));
    test "close to the second" (fun _ -> expect (1 + 2) ~to_:(beSoCloseTo 3 ~digits:9));
  );

  Expect3.(
    (* pro: no weird symbols
     * pro: simpler implementation of modifiers like `not`
     * con: extra parens
     * con: chaining requires nested parens
     *)
    test "the third" (fun _ -> expect (1 + 2) (toBe 3));
    test "not the third" (fun _ -> expect (1 + 2) (not_ (toBe 4)));
    test "close to the third" (fun _ -> expect (1 + 2) (toBeSoCloseTo 3 ~digits:9));
  );

  Expect4.(
    (* pro: no extra parens
     * pro: can easily be chained
     * meh: `|>` can be read as "to", maybe? no? (why is to a keyword instead of an operator?!)
     * con: noisy symbol
     *)
    test "the fourth" (fun _ -> expect (1 + 2) |> be 3);
    test "not the fourth" (fun _ -> expect (1 + 2) |> not_ |> be 4);
    test "close to the fourth" (fun _ -> expect (1 + 2) |> beSoCloseTo 3 ~digits:9);
  );

  Expect5.(
    (* pro: `,` is a less intruding symbol
     * pro: non-intruding parens
     * con: `,` is a somewhat strange symbol to use
     * con: can't chain freely, requires overloads of `expect`
     *)
    test "the fifth" (fun _ -> expect (1 + 2, toBe 3));
    test "not the fifth" (fun _ -> expectNot (1 + 2, toBe 4));
    test "the fifth" (fun _ -> expect (1 + 2, toBeSoCloseTo 3 ~digits:9));
  );

  Expect6.(
    (* pro: `#` is a slightly less intruding symbol
     * pro: simple and natural to implement (but not very DRY)
     * con: `#` is a somewhat strange symbol to use
     * con: extra parens, with odd placement
     *)
    test "the minor fall, the major lift" (fun _ -> (expect (1 + 2)) # toBe 3);
    test "not the minor fall, but definitely the major lift" (fun _ -> (expect (1 + 2)) # not # toBe 4);
    test "one can only take a pun so far" (fun _ -> (expect (1 + 2)) # toBeSoCloseTo 3 ~digits:9);
  );
  
  (*
  test "test expect fail" (fun _ -> Option4.(expect (1 + 2) |> be 4));
  *)
  (* These could also be modeled as `Only.test` and `Only.skip`, might work better with the async and promise variants *)
  (*
  testOnly "only test" (fun _ -> Option6.((expect (1 + 2)) # toBe 3));
  *)
  testSkip "skip test" (fun _ -> Expect6.((expect (1 + 2)) # toBe 3));
  
  (*
  testAsync "async test, should fail (after 5 seconds)" (fun _ -> ());
  *)
  testAsync "async test, should pass" (fun done_ -> done_ Expect4.(expect (1 + 2) |> be 3));
  (*
  testAsync "async test expect fail" (fun done_ -> done_ Option4.(expect (1 + 2) |> be 4));
  *)
  (*
  testAsyncOnly "only async test" (fun done_ -> done_ Option4.(expect (1 + 2) |> be 3));
  *)
  testAsyncSkip "skip async test" (fun done_ -> done_ Expect4.(expect (1 + 2) |> be 3));
  
  (*
  testPromise "promise test, should fail" (fun _ -> Promise.reject ());
  *)
  testPromise "promise test, should pass" (fun _ -> Promise.resolve Expect4.(expect (1 + 2) |> be 3));
  (*
  testPromise "promise test expect fail" (fun _ -> Promise.resolve Option4.(expect (1 + 2) |> be 4));
  *)
  (*
  testPromiseOnly "only promise test" (fun _ -> Promise.resolve Option4.(expect (1 + 2) |> be 3));
  *)
  testPromiseSkip "skip promise test" (fun _ -> Promise.resolve Expect4.(expect (1 + 2) |> be 3));
  
  describe "some thing" (fun _ ->
    let open Expect6 in
    
    test "some aspect" (fun _ -> (expect (1 + 2)) # toBe 3)
  );
  
  (*
  describeOnly "only thing" (fun _ ->
    let open Option6 in
    test "some aspect" (fun _ -> (expect (1 + 2)) # toBe 3)
  );
  *)
  describeSkip "skippable thing" (fun _ ->
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
  
  
