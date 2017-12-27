# bs-jest

[BuckleScript](https://github.com/bucklescript/bucklescript) bindings for [Jest](https://github.com/facebook/jest) - Very very **experimental** (yep, that's one less "very" than before! Progress!) and **WIP**

[![npm](https://img.shields.io/npm/v/bs-jest.svg)](https://npmjs.org/bs-jest)
[![Travis](https://img.shields.io/travis/reasonml-community/bs-jest/master.svg)](https://travis-ci.org/reasonml-community/bs-jest)
[![Coveralls](https://img.shields.io/coveralls/reasonml-community/bs-jest/master.svg)](https://coveralls.io/github/reasonml-community/bs-jest?branch=master)
[![Dependencies](https://img.shields.io/david/reasonml-community/bs-jest.svg)]()
[![Issues](https://img.shields.io/github/issues/reasonml-community/bs-jest.svg)]()
[![Last Commit](https://img.shields.io/github/last-commit/reasonml-community/bs-jest.svg)]()

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

describe("Expect", () => {
  open Expect;

  test("toBe", () =>
    expect(1 + 2) |> toBe(3))
});

describe("Expect.Operators", () => {
    open Expect;
    open! Expect.Operators;

    test("==", () =>
      expect(1 + 2) === 3)
  }
);

```

See [the tests](https://github.com/reasonml-community/bs-jest/tree/master/__tests__) for more examples.

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
Then add `__tests__` to `sources` in your `bsconfig.json`:
```js
"sources": [
  {
    "dir": "src"
  },
  {
    "dir": "__tests__",
    "type": "dev"
  }
]
```

## Usage

Put tests in a `__tests__` directory and use the suffix `*test.ml`/`*test.re` (Make sure to use valid module names. e.g. `<name>_test.re` is valid while `<name>.test.re` is not). When compiled they will be put in a `__tests__` directory under `lib`, with a `*test.js` suffix, ready to be picked up when you run `jest`. If you're not already familiar with [Jest](https://github.com/facebook/jest), see [the Jest documentation](https://facebook.github.io/jest/).

## Contribute
```sh
git clone https://github.com/reasonml-community/bs-jest.git
cd bs-jest
npm install
```

Then build and run tests with `npm test`, start watchers for `bsb`and `jest` with `npm run watch:bsb` and `npm run watch:jest` respectively. Install `screen` to be able to use `npm run watch:screen` to run both watchers in a single terminal window.

## Changes

### 0.2.0
* Removed deprecations
* Added `testAll`, `Only.testAll`, `Skip.testAll` that generates tests from a list of inputs
* Fixed type signature of `fail`
* Added `expectFn`
