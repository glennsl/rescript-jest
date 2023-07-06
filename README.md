# Rescript-jest

[ReScript](https://github.com/rescript-lang) bindings for [Jest](https://github.com/facebook/jest)

[![npm](https://img.shields.io/npm/v/@awebyte/rescript-jest.svg)](https://npmjs.org/@awebyte/rescript-jest)
[![CI](https://github.com/LoganGrier/rescript-jest/actions/workflows/test-ci.yml/badge.svg)](https://github.com/LoganGrier/rescript-jest/actions/workflows/test-ci.yml)
[![Issues](https://img.shields.io/github/issues/LoganGrier/rescript-jest.svg)](https://github.com/LoganGrier/rescript-jest/issues)
[![Last Commit](https://img.shields.io/github/last-commit/LoganGrier/rescript-jest.svg)](https://github.com/LoganGrier/rescript-jest/commits/master)

## @awebyte/rescript-jest vs @glennsl/rescript-jest

This library is a fork of [@glennsl/rescript-jest](https://github.com/glennsl/rescript-jest). The only difference between this library and @glennsl/rescript-jest is that this library exposes the _affirm_ function while @glennsl/rescript-jest does not.

To reduce maintenance costs, this library aims to be as similar as possible to @glennsl/rescript-jest while still exposing affirm.

### What is affirm?

All rescript-jest tests take a parameter _() => assertion_ or _() => Promise.t\<assertion>_, run the parameter, and call affirm on the result. Since @glennsl/rescript-jest does not publicly expose affirm, it ensures that all tests have **exactly one** assertion. By exposing affirm, @awebyte/rescript-jest relaxes this constraint so that all tests have **at least one** assertion.

### Motivation

This fork was motivated by the desire to use property-based testing frameworks like [fast-check](https://github.com/TheSpyder/rescript-fast-check) where a single test needs to runs an assertion for each of a large number of inputs. This change was proposed and rejected in [@glennsl/rescript-jest issue #109](https://github.com/glennsl/rescript-jest/issues/109).

### Don't Overuse Affirm

While exposing affirm gives you more flexibility, it also makes it easier to write tests that are hard to understand, debug, and refactor. Before using affirm, see if you can avoid it by using one of these techniques:

- Compare multiple values by wrapping them in a tuple: `expect((this, that)) -> toBe((3, 4))`.
- Use the `testAll` function to generate tests based on a list of data.
- Use `describe` and/or `beforeAll` to do setup for a group of tests.
- Write a helper function if you find yourself repeating code. You can even write a helper function to generate tests.

## Migrating from @glennsl/rescript-jest

This library uses the same version numbers as @glennsl/rescript-jest. Since this library only adds _affirm_, any code which works with version X of @glennsl/rescript-jest will also work with version X of @awebyte/rescript-jest.

To migrate, simply replace _@glennsl/rescript-jest_ with _@awebyte/rescript-jest_ in your bsconfig.json and package.json files, and reinstall your dependencies.

## Status

- bs-jest is rebranded as rescript-jest
- rescript-jest depends on Rescript 9.1.4, Jest 27.3.1 and @ryyppy/rescript-promise 2.1.0.
- Starting from Jest 27.0.0 jest-jasmine was replaced by jest-circus changing the semantics for before and after hooks.  `afterAllAsync` and `afterAllPromise` hooks now time-out consistent with the behavior of `beforeAllAsync` and `beforeAllPromise` in version 0.7.0 of bs-jest.  `beforeAllAsync` and `beforeAllPromise` also now behave consistently with '`afterAllAsync` and `afterAllPromise` when included in skipped test suites.
- rescript-jest API now uses data-first semantics throughout and uses `rescript-promise` in place of `Js.Promise`.
- usefakeTimers() binding updated to address changes in the Jest fake timer API (useFakeTimer(~implementation=[#legacy|#modern], ()))
- Deprecated BuckleScript `@bs.send.pipe` bindings were converted to rescript `@send` bindings.
- All tests have been updated to reflect semantic and behavioral changes.
- Babel modules have been added as dev dependencies to make generated bs-jest bindings available in ES6 module format.
- Babel and Jest config files are included illustrating how to transform ES6 modules for Jest.

To generate ES6 bindings for your project, update bsconfig.json

```js
  "suffix": ".mjs",
  "package-specs": {
    "module": "ES6",
    "in-source": true
  },
```

Then add `@babel/core`, `@babel/preset-env` and `babel-jest` packages to your project.  Also, add babel.config.js

```js
module.exports = {
    presets: [
        ['@babel/preset-env', 
            {targets: {node: 'current'}}
        ]
    ],
    "plugins": []
}
```

Finally, add minimal jest.config.js

```js
module.exports = {
  moduleFileExtensions: [
    "js",
    "mjs",
  ],
testMatch: [
    "**/__tests__/**/*_test.mjs",
    "**/__tests__/**/*_test.bs.js",
  ],
    transform: {
    "^.+\.m?js$": "babel-jest"
  },
    transformIgnorePatterns: [
    "node_modules/(?!(rescript)/)"
  ],    
```

Update testMatch, transform and transformIgnorePatterns settings depending on where your tests are stored, and other dependencies of your project that may need to be transformed to ES6 format.

Most of what's commonly used is very stable. But the more js-y parts should be considered experimental, such as mocking and some of the expects that don't transfer well, or just don't make sense for testing idiomatic Reason/OCaml code but could be useful for testing js interop.

- [Global](https://facebook.github.io/jest/docs/en/api.html): Fully implemented and tested, apart from `require.*`
- [Expect](https://facebook.github.io/jest/docs/en/expect.html): Mostly implemented. Functionality that makes sense only for JS interop have been moved to `ExpectJs`. Some functionality does not make sense in a typed language, or is not possible to implement sensibly in Rescript.
- [Mock Functions](https://facebook.github.io/jest/docs/en/mock-function-api.html): Experimental and unsafe implementation, very much in flux. The Jest bindings will most likely be relegated to the `MockJs` module as it's very quirky to use with native code. A separate native from-scratch implementation might suddenly appear as `Mock`.
- [The Jest Object](https://facebook.github.io/jest/docs/en/jest-object.html): Fake timers are fully implemented and tested. Mock functionality has been moved to `JestJs`. It's mostly implemented, but experimental and largely untested.
- **Snapshotting**: Expect functions exist and work, but there's currently no way to implement custom snapshot serializers.

## Example

```rescript
open Jest;

describe("Expect", () => {
  open Expect;

  test("toBe", () =>
    expect(1 + 2) -> toBe(3))
});

describe("Expect.Operators", () => {
    open Expect;
    open! Expect.Operators;

    test("==", () =>
      expect(1 + 2) === 3)
  }
);

```

See [the tests](https://github.com/LoganGrier/rescript-jest/tree/master/__tests__) for more examples.

## Installation

```sh
npm install --save-dev @awebyte/rescript-jest
```

or

```sh
yarn install --save-dev @awebyte/rescript-jest
```

Then add `@awebyte/rescript-jest` to `bs-dev-dependencies` in your `bsconfig.json`:

```js
{
  ...
  "bs-dev-dependencies": ["@awebyte/rescript-jest"]
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

Put tests in a `__tests__` directory and use the suffix `*test.res`/ (Make sure to use valid module names. e.g. `<name>_test.res` is valid while `<name>.test.res` is not). When compiled they will be put in a `__tests__` directory under `lib`, with a `*test.bs.js` suffix, ready to be picked up when you run `jest`. If you're not already familiar with [Jest](https://github.com/facebook/jest), see [the Jest documentation](https://facebook.github.io/jest/).

## Documentation

For the moment, please refer to [Jest.resi](https://github.com/LoganGrier/rescript-jest/blob/master/src/jest.resi).

## Extensions

- [bs-jest-dom](https://redex.github.io/package/bs-jest-dom/) - Custom matchers to test the state of the DOM

## Troubleshooting

If you encounter the error `SyntaxError: Cannot use import statement outside a module`, it may be that you are mixing `es6` and `commonjs` modules in your project. For example, this can happen when you are building a React project since React builds are always in ES6. To fix this, please do the following:

- Make sure your `bsconfig.json` compiles `"es6"` or `"es6-global"`:

  ```json
    "package-specs": {
      "module": "es6",
    }
  ```

- Install [esbuild-jest](https://github.com/aelbore/esbuild-jest) through `yarn` or `npm` as a `devDependency`.
- Build your Rescript project with deps: `rescript build -with-deps`.
- Add this to your Jest config (or `jest` of your `package.json`):

  ```json
  {
    "transform": {
      "^.+\\.jsx?$": "esbuild-jest"
    },
    "transformIgnorePatterns": ["<rootDir>/node_modules/(?!(rescript|@awebyte/rescript-jest)/)"]
  }
  ```

- The property `"transformIgnorePatterns"` is an array of strings. Either you do some regex or organize them in an array. **Please make sure all folders in `node_modules` involving compiled .res/.ml/.re files and the like such as `rescript` or `@awebyte/rescript-jest` are mentioned in the aforementioned array.**

This problem is also addressed in [glennsl Issue #63](https://github.com/glennsl/rescript-jest/issues/63).

## Contribute

### Minimizing the differences between this project and @glennsl/rescript-jest

All contributors must first submit a PR to **@glennsl**/rescript-jest, and then, once this PR is merged, submit a PR to @awebyte/rescript-jest that merges in the master branch of @glennsl/rescript-jest.

#### PRs rejected by @glennsl/rescript-jest

If a PR is rejected by @glennsl/rescript-jest, you may submit it to @awebyte/rescript-jest. All such PRs must include a link to the original @glennsl/rescript-jest PR. All PRs rejected by @glennsl/rescript-jest that don't contain a functional change, or which change the formatting of code that isn't functionally changed will be rejected by @awebyte/rescript-jest.

If a @glennsl/rescript-jest PR is open, all feedback provided by @glennsl/rescript-jest maintainers has been addressed, and its been at least 60 days since the last response to this feedback, the PR is deemed to be rejected.

#### Rationale

Most rescript-jest users use @glennsl/rescript-jest instead of this library. Because of this, @glennsl/rescript-jest is expected to receive most of the development, and most of @awebyte/rescript-jest's PRs are expected to merge features developed by @glennsl/rescript-jest users.

This policy minimizes the diff between @glennsl/rescript-jest and this project. This minimizes the labour required to merge @glennsl/rescript-jest into this project.

### Clone, install, and test

```sh
git clone https://github.com/glennsl/rescript-jest.git
cd rescript-jest
npm install
```

Then build and run tests with `npm test`, start watchers for `rescript` and `jest` with `npm run watch:rescript` and `npm run watch:jest` respectively. Install `screen` to be able to use `npm run watch:screen` to run both watchers in a single terminal window.

## Changes

### 0.10
- [BREAKING] Bump required rescript to 10.1.x
- Remove unnecessary dependency on `@ryyppy/rescript-promise`

### 0.9.2
- Added `testAllPromise`.

### 0.9.1

- Added `Jest.setSystemTime`.

### 0.9

- [BREAKING] Removed the unnecessarily verbose generated namespace.

### 0.8
- Moved repository from `glennsl/bs-jest` to `glennsl/rescript-jest`
- Renamed published package to `@glennsl/rescript-jest`
- [BREAKING] Converted source code to ReScript, hence will no longer work with versions of BuckleScript that lack ReScript support.
- [BREAKING] As of Jest 27.0.0, Jest-Circus replaces Jest-Jasmine by default leading to change in behavior of async and Promise before and after hooks. 
- [BREAKING] As the `|>` operator is deprecated in ReScript 9.x, all APIs now use data-first (`->`) semantics.

### 0.7

- [BREAKING] Actually removed `toThrowException`, `toThrowMessage` and `toThrowMessageRe` as they relied on assumptions about BuckleScript internals that no longer hold.

### 0.6

- Added `Expect.toContainEqual`
- Updated to Jest 26.5.2
- Upgraded bs-platform to 8.3.1

### 0.5.1

- Added `Expect.toMatchInlineSnapshot`

### 0.5.0

- Updated to Jest 25.1.0

### 0.4.9

- Added `Todo.test`

### 0.4.8

- Updated jest to 24.3.1
- Fixed jest warnings not to return anything from `describe` callbacks by explicitly returning `undefined` (otherwise BuckleScript will return something else like `()`, which is represented as `0`)
- Fixed several newly uncovered uncurrying issues caused by surprise breaking changes in BuckleScript (Thanks again, Bob!)
- Added `Jest.advanceTimersByTime`, which is basically just an alias of `Jest.runTimersToTime`

### 0.4.7

- Added `Expect.not__` for transitional compatibility with Reason syntax change of "unkeywording" `not` by mangling it into `not_`, and `not_` into `not__` and so on.

### 0.4.6

- Made uncurrying explicit for `afterAllPromise` too.

### 0.4.5

- Made uncurrying explicit to fix a breaking change in implicit uncurrying from `bs-platform` 4.0.7 (Thanks Bob!)

### 0.4.3

- Removed some optimizations on skipped tests that Jest 23 suddenly started objecting to (#30)

### 0.4.0

- Added `MockJs.new0`, `new1` and `new2`
- Added `timeout` argument to `testAsync` and `testPromise` functions
- Added `beforeEachAsync`, `beforeEachPromise`, `afterEachAsync` and `afterEachPromise`
- Added `beforeAllAsync`, `beforeAllPromise`, `afterAllAsync` and `afterAllPromise`

### 0.3.1

- Moved repository from `reasonml-community/bs-jest` to `glennsl/bs-jest`
- Renamed NPM package from `bs-jest` to `@glennsl/bs-jest`

### 0.3.0

- Added `toThrowException`
- Fixed an issue with custom Runner implementation shadowing the global `test` function from jest
- Fixed a typo in the js boundary of `not_ |> toBeLessThanEqual`

### 0.2.0

- Removed deprecations
- Added `testAll`, `Only.testAll`, `Skip.testAll` that generates tests from a list of inputs
- Fixed type signature of `fail`
- Added `expectFn`
