# bs-jest

[BuckleScript](https://github.com/bucklescript/bucklescript) bindings for [Jest](https://github.com/facebook/jest)

[![npm](https://img.shields.io/npm/v/@glennsl/bs-jest.svg)](https://npmjs.org/@glennsl/bs-jest)
[![Travis](https://img.shields.io/travis/glennsl/bs-jest/master.svg)](https://travis-ci.org/glennsl/bs-jest)
[![Coveralls](https://img.shields.io/coveralls/glennsl/bs-jest/master.svg)](https://coveralls.io/github/glennsl/bs-jest?branch=master)
[![Dependencies](https://img.shields.io/david/glennsl/bs-jest.svg)](https://github.com/glennsl/bs-jest/blob/master/package.json)
[![Issues](https://img.shields.io/github/issues/glennsl/bs-jest.svg)](https://github.com/glennsl/bs-jest/issues)
[![Last Commit](https://img.shields.io/github/last-commit/glennsl/bs-jest.svg)](https://github.com/glennsl/bs-jest/commits/master)

**NOTE:** _NPM package has moved to `@glennsl/bs-jest`. Remember to update both `package.json` AND `bsconfig.json`._

## Status

Most of what's commonly used is very stable. But the more js-y parts should be considered experimental, such as mocking and some of the expects that don't transfer well, or just don't make sense for testing idiomatic Reason/OCaml code but could be useful for testing js interop.

* [Global](https://facebook.github.io/jest/docs/en/api.html): Fully implemented and tested, apart from `require.*`
* [Expect](https://facebook.github.io/jest/docs/en/expect.html): Mostly implemented. Functionality that makes sense only for JS interop have been moved to `ExpectJs`. Some functionality does not make sense in a typed language, or is not possible to implement sensibly in ML.
* [Mock Functions](https://facebook.github.io/jest/docs/en/mock-function-api.html): Experimental and unsafe implementation, very much in flux. The Jest bindings will most likely be relegated to the `MockJs` module as it's very quirky to use with native code. A separate native from-scratch implementation might suddenly appear as `Mock`.
* [The Jest Object](https://facebook.github.io/jest/docs/en/jest-object.html): Fake timers are fully implemented and tested. Mock functionality has been moved to `JestJs`. It's mostly implemented, but experimental and largely untested.
* __Snapshotting__: Expect functions exist and work, but there's currently no way to implement custom snapshot serializers.

## Example

```reason
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
npm install --save-dev @glennsl/bs-jest
```

Then add `@glennsl/bs-jest` to `bs-dev-dependencies` in your `bsconfig.json`:
```js
{
  ...
  "bs-dev-dependencies": ["@glennsl/bs-jest"]
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

One very important difference from Jest is that assertions are not imperative. That is, `expect(1 + 2) |> toBe(3)`, for example, will not "execute" the assertion then and there. It will instead return an `assertion` value which must be returned from the test function. Only after the test function has completed will the returned assertion be checked. Any other assertions will be ignored, but unless you explicitly ignore them, it will produce compiler warnings about unused values. **This means there can be at most one assertion per test**. But it also means there must be at least one assertion per test. You can't forget an assertion in a branch, and think the test passes when in fact it doesn't even test anything. It will also force you to write simple tests that are easy to understand and refactor, and will give you more information about what's wrong when something does go wrong.

At first sight this may still seem very limiting, and if you write very imperative code it really is, but I'd argue the real problem then is the imperative code. There are however some workarounds that can alleviate this:

* Compare multiple values by wrapping them in a tuple: `expect((this, that)) |> toBe((3, 4))`
* Use the `testAll` function to generate tests based on a list of data
* Use `describe` and/or `beforeAll` to do setup for a group of tests. Code written in OCaml/Reason is immutable by default. Take advantage of it.
* Write a helper function if you find yourself repeating code. That's what functions are for, after all. You can even write a helper function to generate tests.
* If you're still struggling, make an issue on GitHub or bring it up in Discord. We'll either figure out a good way to do it with what we already have, or realize that something actually is missing and add it.

## Documentation

For the moment, please refer to [Jest.mli](https://github.com/glennsl/bs-jest/blob/master/src/jest.mli).

## Extensions

* [bs-jest-dom](https://redex.github.io/package/bs-jest-dom/) - Custom matchers to test the state of the DOM

## Contribute
```sh
git clone https://github.com/glennsl/bs-jest.git
cd bs-jest
npm install
```

Then build and run tests with `npm test`, start watchers for `bsb`and `jest` with `npm run watch:bsb` and `npm run watch:jest` respectively. Install `screen` to be able to use `npm run watch:screen` to run both watchers in a single terminal window.

## Changes

### 0.4.8
* Updated jest to 24.3.1
* Fixed jest warnings not to return anything from `describe` callbacks by explicitly returning `undefined` (otherwise BuckleScript will return something else like `()`, which is represented as `0`)
* Fixed several newly uncovered uncurrying issues caused by surprise breaking changes in BuckleScript (Thanks again, Bob!)
* Added `Jest.advanceTimersByTime`, which is basically just an alias of `Jest.runTimersToTime`

### 0.4.7
* Added `Expect.not__` for transitional compatibility with Reason syntax change of "unkeywording" `not` by mangling it into `not_`, and `not_` into `not__` and so on.

### 0.4.6
* Made uncurrying explicit for `afterAllPromise` too.

### 0.4.5
* Made uncurrying explicit to fix a breaking change in implicit uncurrying from `bs-platform` 4.0.7 (Thanks Bob!)

### 0.4.3
* Removed some optimizations on skipped tests that Jest 23 suddenly started objecting to (#30)

### 0.4.0
* Added `MockJs.new0`, `new1` and `new2`
* Added `timeout` argument to `testAsync` and `testPromise` functions
* Added `beforeEachAsync`, `beforeEachPromise`, `afterEachAsync` and `afterEachPromise`
* Added `beforeAllAsync`, `beforeAllPromise`, `afterAllAsync` and `afterAllPromise`

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
