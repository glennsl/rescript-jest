# bs-jest - [BuckleScript](https://github.com/bloomberg/bucklescript) bindings for [Jest](https://github.com/facebook/jest) [![Build Status](https://travis-ci.org/BuckleTypes/bs-jest.svg?branch=master)](https://travis-ci.org/BuckleTypes/bs-jest)

Very very **experimental** (yep, that's one less "very" than before! Progress!) and **WIP**

## Status

* [Global](https://facebook.github.io/jest/docs/api.html#content): Fully implemented and tested, apart from `require.*`
* [Expect](https://facebook.github.io/jest/docs/expect.html#content): Mostly implemented. Functionality that makes sense only for JS interop have been moved to `ExpectJS`. Some functionality does not make sense in a typed language, or is not possible to implement sensibly in ML.
* [Mock Functions](https://facebook.github.io/jest/docs/mock-function-api.html#content): Experimental and unsafe implementation, very much in flux. The Jest bindings will most likely be relegated to the `MockJs` module as it's very quirky to use with native code. A separate native from-scratch implementation might suddenly appear as `Mock`.
* [The Jest Object](https://facebook.github.io/jest/docs/jest-object.html#content): Fake timers are fully implemented and tested. Mock functionality has been moved to `JestJs`. It's mostly implemented, but experimental and largely untested.
* [Snapshotting] Completely untested. Expect functions exist, but there's currently no way to implement custom snapshot serializers.

## Example

```ml
(* OCaml *)
open Jest

let _ =

describe "Expect" (fun () -> 
  let open Expect in

  test "toBe" (fun () ->
    expect (1 + 2) |> toBe 3);
);

describe "Expect.Operators" (fun () -> 
  let open Expect in
  let open! Expect.Operators in

  test "==" (fun () ->
    expect (1 + 2) == 3);
);
```

```reason
/* Reason */
open Jest;

let _ =

describe "Expect" (fun () => {
  open Expect;
	
  test "toBe" (fun () =>
    expect (1 + 2) |> toBe 3)
});
    
describe "Expect.Operators" (fun () => {
  open Expect;
  open! Expect.Operators;
  
  test "==" (fun () =>
    expect (1 + 2) === 3)
});
```

See [the tests](https://github.com/BuckleTypes/bs-jest/tree/master/__tests__) for more examples.

## Installation

```sh
npm install --save-dev bs-jest
```

Then add `bs-jest` to `bs-dev-dependencies` in your `bsconfig.json`:
```js
{
  ...
  "bs-dev-dependencies": ["bs-jest"]
}
```

## Usage

Put tests in a `__tests__` directory and use the suffix `*test.ml`/`*test.re`. When compiled they will be put in a `__tests__` directory under `lib`, with a `*test.js` suffix, ready to be picked up when you run `jest`. If you're not already familiar with [Jest](https://github.com/facebook/jest), see [the Jest documentation](https://facebook.github.io/jest/).

## Contribute
```sh
git clone https://github.com/BuckleTypes/bs-jest.git
cd bs-jest
npm install
```

Then build and run tests with `npm test`, start watcher with `npm run watch:jest` respectively. It uses [bs-loader]() as a transform, which will compile the code on-the-fly as you make changes.
