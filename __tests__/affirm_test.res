open Jest
open Expect

describe("affirm", () => {
  test("Affirming a passing assertion doesn't throw an exception", () => {
    expect(() => pass->affirm)->not_->toThrow
  })
  test("Affirming a failing assertion throws an exception", () => {
    expect(() => fail("Error!")->affirm)->toThrow
  })
})