open Jest
open Expect
open! Expect.Operators

external setTimeout : (unit -> unit) -> int -> unit = "" [@@bs.val]
external setImmediate : (unit -> unit) -> unit = "" [@@bs.val]
external nextTick : (unit -> unit) -> unit = "process.nextTick" [@@bs.val]

let () = 

describe "Fake Timers" (fun () ->
  test "runAllTimers" (fun () ->
    let flag = ref false in
    Jest.useFakeTimers ();
    setTimeout (fun () -> flag := true) 0;
    let before = !flag in
    Jest.runAllTimers ();
    
    expect (before, !flag) = (false, true)
  );
  
  test "runAllTicks" (fun () ->
    let flag = ref false in
    Jest.useFakeTimers ();
    nextTick (fun () -> flag := true);
    let before = !flag in
    Jest.runAllTicks ();
    
    expect (before, !flag) = (false, true)
  );
  
  test "runAllImmediates" (fun () ->
    let flag = ref false in
    Jest.useFakeTimers ();
    setImmediate (fun () -> flag := true);
    let before = !flag in
    Jest.runAllImmediates ();
    
    expect (before, !flag) = (false, true)
  );
  
  test "runTimersToTime" (fun () ->
    let flag = ref false in
    Jest.useFakeTimers ();
    setTimeout (fun () -> flag := true) 1500;
    let before = !flag in
    Jest.runTimersToTime 1000;
    let inbetween = !flag in
    Jest.runTimersToTime 1000;
    
    expect (before, inbetween, !flag) = (false, false, true)
  );
  
  test "runOnlyPendingTimers" (fun () ->
    let count = ref 0 in
    Jest.useFakeTimers ();
    let rec recursiveTimeout () = count := !count + 1; setTimeout recursiveTimeout 1500 in
    recursiveTimeout ();
    let before = !count in
    Jest.runOnlyPendingTimers ();
    let inbetween = !count in
    Jest.runOnlyPendingTimers ();
    
    expect (before, inbetween, !count) = (1, 2, 3)
  );
  
  test "clearAllTimers" (fun () ->
    let flag = ref false in
    Jest.useFakeTimers ();
    setImmediate (fun () -> flag := true);
    let before = !flag in
    Jest.clearAllTimers ();
    Jest.runAllTimers ();
    
    expect (before, !flag) = (false, false)
  );
  
  testAsync "clearAllTimers" (fun finish ->
    Jest.useFakeTimers ();
    Jest.useRealTimers ();
    setImmediate (fun () -> finish pass);
  );
);

describe "beforeAllAsync" (fun () ->
  describe "without timeout" (fun () ->
    let x = ref 0 in
    beforeAllAsync (fun (finish) -> x := !x + 4; finish ());
    test "x is 4" (fun () -> expect !x |> toBe 4);
    test "x is still 4" (fun () -> expect !x |> toBe 4);
  );

  describe "with 100ms timeout" (fun () ->
    let x = ref 0 in
    beforeAllAsync ~timeout:100 (fun (finish) -> x := !x + 4; finish ());
    test "x is 4" (fun () -> expect !x |> toBe 4);
    test "x is still 4" (fun () -> expect !x |> toBe 4);
  );
);

describe "beforeAllPromise" (fun () ->
  let x = ref 0 in
  beforeAllPromise (fun () -> x := !x + 4; Js.Promise.resolve ());
  test "x is 4" (fun () ->  expect !x |> toBe 4);
  test "x is still 4" (fun () -> expect !x |> toBe 4);
);

describe "afterAllAsync" (fun () ->
  describe "without timeout" (fun () ->
    let x = ref 0 in

    describe "phase 1" (fun () ->
      afterAllAsync (fun (finish) -> x := !x + 4; finish ());
      test "x is 0" (fun () -> expect !x |> toBe 0)
    );

    describe "phase 2" (fun () ->
      test "x is suddenly 4" (fun () -> expect !x |> toBe 4)
    );
  );

  describe "with 100ms timeout" (fun () ->
    let x = ref 0 in

    describe "phase 1" (fun () ->
      afterAllAsync ~timeout:100 (fun (finish) -> x := !x + 4; finish ());
      test "x is 0" (fun () -> expect !x |> toBe 0)
    );

    describe "phase 2" (fun () ->
      test "x is suddenly 4" (fun () -> expect !x |> toBe 4)
    );
  );
);

describe "afterAllPromise" (fun () ->
  let x = ref 0 in

  describe "phase 1" (fun () ->
    afterAllPromise (fun () -> x := !x + 4; Js.Promise.resolve true);
    test "x is 0" (fun () -> expect !x |> toBe 0)
  );

  describe "phase 2" (fun () ->
    test "x is suddenly 4" (fun () -> expect !x |> toBe 4)
  );
);
