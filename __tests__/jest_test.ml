open Jest

external setTimeout : (unit -> unit) -> int -> unit = "" [@@bs.val]
external setImmediate : (unit -> unit) -> unit = "" [@@bs.val]
external nextTick : (unit -> unit) -> unit = "process.nextTick" [@@bs.val]

let _ = 

describe "Fake Timers" (fun _ ->
  test "runAllTimers" (fun _ ->
    let flag = ref false in
    Jest.useFakeTimers ();
    setTimeout (fun () -> flag := true) 0;
    let before = !flag in
    Jest.runAllTimers ();
    
    Just (Equal ((before, !flag), (false, true)))
  );
  
  test "runAllTicks" (fun _ ->
    let flag = ref false in
    Jest.useFakeTimers ();
    nextTick (fun () -> flag := true);
    let before = !flag in
    Jest.runAllTicks ();
    
    Just (Equal ((before, !flag), (false, true)))
  );
  
  test "runAllImmediates" (fun _ ->
    let flag = ref false in
    Jest.useFakeTimers ();
    setImmediate (fun () -> flag := true);
    let before = !flag in
    Jest.runAllImmediates ();
    
    Just (Equal ((before, !flag), (false, true)))
  );
  
  test "runTimersToTime" (fun _ ->
    let flag = ref false in
    Jest.useFakeTimers ();
    setTimeout (fun () -> flag := true) 1500;
    let before = !flag in
    Jest.runTimersToTime 1000;
    let inbetween = !flag in
    Jest.runTimersToTime 1000;
    
    Just (Equal ((before, inbetween, !flag), (false, false, true)))
  );
  
  test "runOnlyPendingTimers" (fun _ ->
    let count = ref 0 in
    Jest.useFakeTimers ();
    let rec recursiveTimeout () = count := !count + 1; setTimeout recursiveTimeout 1500 in
    recursiveTimeout ();
    let before = !count in
    Jest.runOnlyPendingTimers ();
    let inbetween = !count in
    Jest.runOnlyPendingTimers ();
    
    Just (Equal ((before, inbetween, !count), (1, 2, 3)))
  );
  
  test "clearAllTimers" (fun _ ->
    let flag = ref false in
    Jest.useFakeTimers ();
    setImmediate (fun () -> flag := true);
    let before = !flag in
    Jest.clearAllTimers ();
    Jest.runAllTimers ();
    
    Just (Equal ((before, !flag), (false, false)))
  );
  
  testAsync "clearAllTimers" (fun done_ ->
    Jest.useFakeTimers ();
    Jest.useRealTimers ();
    setImmediate (fun () -> done_ (Just Ok));
  );
);