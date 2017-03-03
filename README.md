# bs-jest - [BuckleScript](https://github.com/bloomberg/bucklescript) bindings for [Jest](https://github.com/facebook/jest) [![Build Status](https://travis-ci.org/BuckleTypes/bs-jest.svg?branch=master)](https://travis-ci.org/BuckleTypes/bs-jest)

Very very very **experimental** and **WIP**

## Status

* [Global](https://facebook.github.io/jest/docs/api.html#content): Fully implemented and tested, apart from `require.*`
* [Expect](https://facebook.github.io/jest/docs/expect.html#content): Parts of it implemented in many different ways. Testing out different API designs, see [#3](https://github.com/BuckleTypes/bs-jest/issues/3). "Static" `expect` functions will mostly need to be implemented as matcher overloads. `expect.extend` will probably be dropped in favor of some less dynamic solution.
* [Mock Functions](https://facebook.github.io/jest/docs/mock-function-api.html#content): Experimental and unsafe implementation, very much in flux.
* [The Jest Object](https://facebook.github.io/jest/docs/jest-object.html#content): Fake timers are fully implemented and tested. Mock functions are mostly implemented, but experimental and largely untested.

## Usage

See [the tests](https://github.com/BuckleTypes/bs-jest/tree/master/__tests__) for examples. Put tests in a `__tests__` directory and use the suffix `*test.ml`/`*test.re`. When compiled they will be put in a `__tests__` directory under `lib`, with a `*test.js` suffix, ready to be picked up when you run `jest`. If you're not already familiar with [Jest](https://github.com/facebook/jest), see [the Jest documentation](https://facebook.github.io/jest/).

## Contribute
```sh
git clone https://github.com/BuckleTypes/bs-jest.git
cs bs-jest
npm install
```

Then build and run tests with `npm test`, start watchers for `bsb`and `jest` with `npm run watch:bsb` and `npm run watch:jest` respectively. Install `screen` to be able to use `npm run watch:screen` to run both watchers in a single terminal window.
