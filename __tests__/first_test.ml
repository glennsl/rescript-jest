open Jest

let _ = test "my first test" (fun () -> expect (1 + 2) |> toBe 3)
