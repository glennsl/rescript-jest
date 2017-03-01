open Jest

let _ =
  Expect1.(
    (* pro: no extra parens
     * pro: can easily be chained
     * pro: easily supports different types for `a`/`b`
     * con: noisy symbol
     *)
    test "the first" (fun _ -> expect (1 + 2) |> toBe 3);
    test "not the first" (fun _ -> expect (1 + 2) |> not_ |> toBe 4);
    test "close to the first" (fun _ -> expect (1. +. 2.) |> toBeSoCloseTo 3. ~digits:9);
    test "contains the first" (fun _ -> expect [| "a"; "b"; "c" |] |> toContain "b")
  );
  
  Expect2.(
    (* pro: separate words
     * pro: simpler implementation of modifiers like `not`
     * con: oddly placed extra parens
     * con: several noisy symbols
     * con: can only support `to*` functions
     * con: chaining using the same convention will get very messy very fast
     * con: different `a`/`b` types requires overloads and lots of code duplicatio
     *)
    test "the second" (fun _ -> expect (1 + 2) ~to_:(be 3));
    test "not the second" (fun _ -> expect (1 + 2) ~to_:(not_ (be 4)));
    test "close to the second" (fun _ -> expect (1. +. 2.) ~to_:(beSoCloseTo 3. ~digits:9));
    (* test "contains the second" (fun _ -> expect [| "a"; "b"; "c" |] ~to_:(contain "b")) *) (* unsupported *)
  );

  Expect3.(
    (* pro: no weird symbols
     * pro: simpler implementation of modifiers like `not`
     * con: extra parens
     * con: chaining requires nested parens
     * con: doesn't support narrowing of types
     * con: different `a`/`b` types requires overloads and lots of code duplicatio
     *)
    test "the third" (fun _ -> expect (1 + 2) (toBe 3));
    test "not the third" (fun _ -> expect (1 + 2) (not_ (toBe 4)));
    test "close to the third" (fun _ -> expect (1. +. 2.) (toBeSoCloseTo 3. ~digits:9));
    (* test "contains second" (fun _ -> expect [| "a"; "b"; "c" |] (toContain "b")) *) (* unsupported *)
  );

  Expect4.(
    (* pro: no extra parens
     * pro: can easily be chained
     * pro: easily supports different types for `a`/`b`
     * meh: `|>` can be read as "to", maybe? no? (why is to a keyword instead of an operator?!)
     * con: noisy symbol
     *)
    test "the fourth" (fun _ -> expect (1 + 2) |> be 3);
    test "not the fourth" (fun _ -> expect (1 + 2) |> not_ |> be 4);
    test "close to the fourth" (fun _ -> expect (1. +. 2.) |> beSoCloseTo 3. ~digits:9);
    test "contains the fourth" (fun _ -> expect [| "a"; "b"; "c" |] |> contain "b")
  );

  Expect5.(
    (* pro: `,` is a less intruding symbol
     * pro: non-intruding parens
     * con: `,` is a somewhat strange symbol to use
     * con: can't chain freely, requires overloads of `expect`
     * con: different `a`/`b` types requires overloads and lots of code duplicatio
     *)
    test "the fifth" (fun _ -> expect (1 + 2, toBe 3));
    test "not the fifth" (fun _ -> expectNot (1 + 2, toBe 4));
    test "the fifth" (fun _ -> expect (1. +. 2., toBeSoCloseTo 3. ~digits:9));
    (* test "contains the fifth" (fun _ -> expect ([| "a"; "b"; "c" |], toContain "b")) *) (* unsupported *)
  );

  Expect6.(
    (* pro: `#` is a slightly less intruding symbol
     * pro: simple and natural to implement (but not very DRY)
     * con: `#` is a somewhat strange symbol to use
     * con: extra parens, with odd placement
     * con: complicated type errors
     * con: narrowing of types require overloads of expect
     *)
    test "the minor fall, the major lift" (fun _ -> (expect (1 + 2)) # toBe 3);
    testSkip "not the minor fall, but definitely the major lift" (fun _ -> (expect (1 + 2)) # not # toBe 4); (* TODO: fails due to bug in bs - https://github.com/bloomberg/bucklescript/issues/1285 *)
    test "close to blah blah blah" (fun _ -> (expectFloat (1. +. 2.)) # toBeSoCloseTo 3. ~digits:9);
    test "one can only really take a pun so far" (fun _ -> (expectArray [| "a"; "b"; "c" |]) # toContain "b")
  );
  
  Assert1.(
    (* pro: simple
     * pro: no extra parens
     * meh: no chaining, just lots and lots of overloads
     * con: too easy to mix up actual and exepected
     * con: less "fluently" readable
     * con: inconsistent with cli form (`expect(array).toContain(value)``)
     *)
    test "the assert" (fun _ -> assertBe (1 + 2) 3);
    test "not the assert" (fun _ -> assertNotBe (1 + 2) 4);
    test "close to the asert" (fun _ -> assertSoCloseTo (1. +. 2.) 3. ~digits:9);
    test "contains the assert" (fun _ -> assertContain [| "a"; "b"; "c" |] "b")
  );
  
  Assert2.(
    (* pro: simple
     * pro: no extra parens
     * pro: easy to "scan"
     * meh: no chaining, just lots and lots of overloads
     * con: a bit verbose
     * con: less "fluently" readable
     * con: inconsistent with cli form (`expect(array).toContain(value)``)
     *)
    test "the assert" (fun _ ->
      Assert.be
        ~actual:(1 + 2)
        ~expected:3
    );
    test "not the assert" (fun _ ->
      Assert.notBe
        ~actual:(1 + 2)
        ~expected:4
    );
    test "close to the asert" (fun _ ->
      Assert.soCloseTo
        ~actual:(1. +. 2.)
        ~expected:3.
        ~digits:9
    );
    test "contains the assert" (fun _ ->
      Assert.contain
        ~actual:[| "a"; "b"; "c" |]
        ~element:"b"
    )
  );
  
  Assert3.(
    (* pro: simple
     * pro: no extra parens
     * pro?: sort of fluently readable? If you ignore the first part?
     * meh: no chaining, just lots and lots of overloads
     * con: a bit verbose
     * con: awkward
     * con: inconsistent with cli form (`expect(array).toContain(value)``)
     *)
    test "the assert" (fun _ ->
      Assert.be (1 + 2) ~toBe:3
    );
    test "not the assert" (fun _ ->
      Assert.notBe (1 + 2) ~toNotBe:4
    );
    test "close to the asert" (fun _ ->
      Assert.soCloseTo (1. +. 2.) ~toBeSoCloseTo:3. ~digits:9
    );
    test "contains the assert" (fun _ ->
      Assert.contain [| "a"; "b"; "c" |] ~toContain:"b"
    )
  );
  
  (* Variant1.( *)
    (* pro: simple
     * pro: no extra parens (if variants are modeled more nicely)
     * meh: no chaining, just lots and lots of variants
     * con: too easy to mix up actual and exepected
     * con: less "fluently" readable
     * con: inconsistent with cli form (`expect(array).toContain(value)``)
     *)
    test "the assert" (fun _ -> Just (Be (1 + 2, 3)));
    test "not the assert" (fun _ -> Not (Be (1 + 2, 4)));
    test "close to the asert" (fun _ -> Just (CloseTo (1. +. 2., 3., Some 9)));
    test "contains the assert" (fun _ -> Just (ArrayContains ([| "a"; "b"; "c" |], "b")));
  (* ); *)
  
