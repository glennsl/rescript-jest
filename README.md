# bs-jest - [BuckleScript](https://github.com/bloomberg/bucklescript) bindings for the [Jest](https://github.com/facebook/jest) test framework [![Build Status](https://travis-ci.org/BuckleTypes/bs-jest.svg?branch=master)](https://travis-ci.org/BuckleTypes/bs-jest)

Very very very **experimental** and **WIP**

## Status

* [Global](https://facebook.github.io/jest/docs/api.html#content): Fully implemented and tested, apart from `require.*`
* [Expect](https://facebook.github.io/jest/docs/expect.html#content): Parts of it implemented in many different ways. Testing out different API designs.
* [Mock Functions](https://facebook.github.io/jest/docs/mock-function-api.html#content): Experimental unsafe implementation, and very much in flux.
* [The Jest Object](https://facebook.github.io/jest/docs/jest-object.html#content): Fake timers are fully implemented and tested. Mock functions are mostly implemented, but experimental and largely untested.

## Contribute
```sh
git clone https://github.com/BuckleTypes/bs-jest.git
cs bs-jest
npm install
```

Then build and run tests with `npm test`, start watchers for `bsb`and `jest` with `npm run watch:bsb` and `npm run watch:jest` respectively. Install `screen` to be able to use `npm run watch:screen` to run both watchers in a single terminal window.
