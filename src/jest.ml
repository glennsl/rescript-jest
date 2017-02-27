type 'a case =
| StrictEqual of 'a * 'a
| Equal of 'a * 'a

type 'a expectation =
| Value of 'a

module LLExpect = struct
  type 'a ll_expectation
  external expect : 'a -> 'a ll_expectation = "" [@@bs.val]
  external toBe : 'a -> unit = "" [@@bs.send.pipe: 'a ll_expectation]
  external toEqual : 'a -> unit = "" [@@bs.send.pipe: 'a ll_expectation]

  let exec = function
  | StrictEqual (a, b) -> expect a |> toBe b
  | Equal (a, b) -> expect a |> toEqual b
end

let expect : 'a -> 'a expectation = fun value -> Value value
let toBe : 'a -> 'a expectation -> 'a case =
  function b ->
  function Value a -> StrictEqual (a, b)
let toEqual : 'a -> 'a expectation -> 'a case =
  function b ->
  function Value a -> Equal (a, b)

external test : string -> (unit -> unit) -> unit = "" [@@bs.val]
let test : string -> (unit -> 'a case) -> unit = fun name callback ->
  test name
    (fun () ->
      let case = callback () in
      LLExpect.exec case
    )

(*
let testAsync : string -> ((unit -> case) -> unit) -> unit = fun name callback ->
*)

(* describe *)
(* only *)
(* mock *)
(* fn *)
(* useFakeTimers *)
(* runAllTimers *)
(* runOnlyPendngTimers *)
(* runTimersToTIme *)
(* clearAllTimers *)
