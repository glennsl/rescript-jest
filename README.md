# bs-jest - [BuckleScript](https://github.com/bloomberg/bucklescript) bindings for [Jest](https://github.com/facebook/jest) [![Build Status](https://travis-ci.org/BuckleTypes/bs-jest.svg?branch=master)](https://travis-ci.org/BuckleTypes/bs-jest)

Very very **experimental** (yep, that's one less "very" than before!) and **WIP**

## Status

* [Global](https://facebook.github.io/jest/docs/api.html#content): Fully implemented and tested, apart from `require.*`
* [Expect](https://facebook.github.io/jest/docs/expect.html#content): Mostly implemented. Functionality that makes sense only for JS interop have been moved to `ExpectJS`. Some functionality does not make sense in a typed language, or is not possible to implement sensibly in ML.
* [Mock Functions](https://facebook.github.io/jest/docs/mock-function-api.html#content): Experimental and unsafe implementation, very much in flux. The Jest bindings will most likely be relegated to the `MockJs` module as it's very quirky to use with native code. A separate native from-scratch implementation might suddenly appear as `Mock`.
* [The Jest Object](https://facebook.github.io/jest/docs/jest-object.html#content): Fake timers are fully implemented and tested. Mock functionality has been moved to `JestJs`. It's mostly implemented, but experimental and largely untested.
* [Snapshotting] Completely untested. Expect functions exist, but there's currently no way to implement custom snapshot serializers.

## Usage

See [the tests](https://github.com/BuckleTypes/bs-jest/tree/master/__tests__) for examples. Put tests in a `__tests__` directory and use the suffix `*test.ml`/`*test.re`. When compiled they will be put in a `__tests__` directory under `lib`, with a `*test.js` suffix, ready to be picked up when you run `jest`. If you're not already familiar with [Jest](https://github.com/facebook/jest), see [the Jest documentation](https://facebook.github.io/jest/).

## Contribute
```sh
git clone https://github.com/BuckleTypes/bs-jest.git
cs bs-jest
npm install
```

Then build and run tests with `npm test`, start watchers for `bsb`and `jest` with `npm run watch:bsb` and `npm run watch:jest` respectively. Install `screen` to be able to use `npm run watch:screen` to run both watchers in a single terminal window.
