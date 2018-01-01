# bs-jest

[BuckleScript](https://github.com/bucklescript/bucklescript) bindings for [Jest](https://github.com/facebook/jest) - Very very **experimental** (yep, that's one less "very" than before! Progress!) and **WIP**

[![npm](https://img.shields.io/npm/v/@glennsl/bs-jest.svg)](https://npmjs.org/@glennsl/bs-jest)
[![Travis](https://img.shields.io/travis/glennsl/bs-jest/master.svg)](https://travis-ci.org/glennsl/bs-jest)
[![Coveralls](https://img.shields.io/coveralls/glennsl/bs-jest/master.svg)](https://coveralls.io/github/glennsl/bs-jest?branch=master)
[![Dependencies](https://img.shields.io/david/glennsl/bs-jest.svg)](https://github.com/glennsl/bs-jest/blob/master/package.json)
[![Issues](https://img.shields.io/github/issues/glennsl/bs-jest.svg)](https://github.com/glennsl/bs-jest/issues)
[![Last Commit](https://img.shields.io/github/last-commit/glennsl/bs-jest.svg)](https://github.com/glennsl/bs-jest/commits/master)

**NOTE:** _NPM package has moved to `@glennsl/bs-jest`. Remember to update both `package.json` AND `bsconfig.json`._

## Status

* [Global](https://facebook.github.io/jest/docs/en/api.html): Fully implemented and tested, apart from `require.*`
* [Expect](https://facebook.github.io/jest/docs/en/expect.html): Mostly implemented. Functionality that makes sense only for JS interop have been moved to `ExpectJs`. Some functionality does not make sense in a typed language, or is not possible to implement sensibly in ML.
* [Mock Functions](https://facebook.github.io/jest/docs/en/mock-function-api.html): Experimental and unsafe implementation, very much in flux. The Jest bindings will most likely be relegated to the `MockJs` module as it's very quirky to use with native code. A separate native from-scratch implementation might suddenly appear as `Mock`.
* [The Jest Object](https://facebook.github.io/jest/docs/en/jest-object.html): Fake timers are fully implemented and tested. Mock functionality has been moved to `JestJs`. It's mostly implemented, but experimental and largely untested.
* __Snapshotting__: Expect functions exist and work, but there's currently no way to implement custom snapshot serializers.

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

See [the tests](https://github.com/glennsl/bs-jest/tree/master/__tests__) for more examples.

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

## Documentation

For the moment, please refer to [Jest.mli](https://github.com/glennsl/bs-jest/blob/master/src/jest.mli).

## Contribute
```sh
git clone https://github.com/glennsl/bs-jest.git
cd bs-jest
npm install
```

Then build and run tests with `npm test`, start watchers for `bsb`and `jest` with `npm run watch:bsb` and `npm run watch:jest` respectively. Install `screen` to be able to use `npm run watch:screen` to run both watchers in a single terminal window.

## Changes

### 0.3.1
* Moved repository from `reasonml-community/bs-jest` to `glennsl/bs-jest`
* Renamed NPM package from `bs-jest` to `@glennsl/bs-jest`

### 0.3.0
* Added `toThrowException`
* Fixed an issue with custom Runner implementation shadowing the global `test` function from jest
* Fixed a typo in the js boundary of `not_ |> toBeLessThanEqual`

### 0.2.0
* Removed deprecations
* Added `testAll`, `Only.testAll`, `Skip.testAll` that generates tests from a list of inputs
* Fixed type signature of `fail`
* Added `expectFn`
