'use strict';

var Jest  = require("../src/jest.js");
var Curry = require("bs-platform/lib/js/curry.js");

Jest.test("test", (function () {
        return Jest.Expect[/* toBe */2](3)(Jest.Expect[/* expect */0](3));
      }));

Jest.testAsync("testAsync", (function (done_) {
        return Curry._1(done_, Jest.Expect[/* toBe */2](3)(Jest.Expect[/* expect */0](3)));
      }));

Jest.testPromise("testPromise", (function () {
        return Promise.resolve(Jest.Expect[/* toBe */2](3)(Jest.Expect[/* expect */0](3)));
      }));

Jest.testAll("testAll", /* :: */[
      "foo",
      /* :: */[
        "bar",
        /* :: */[
          "baz",
          /* [] */0
        ]
      ]
    ], (function (input) {
        return Jest.Expect[/* toEqual */12](3)(Jest.Expect[/* expect */0](input.length));
      }));

Jest.testAll("testAll - tuples", /* :: */[
      /* tuple */[
        "foo",
        3
      ],
      /* :: */[
        /* tuple */[
          "barbaz",
          6
        ],
        /* :: */[
          /* tuple */[
            "bananas!",
            8
          ],
          /* [] */0
        ]
      ]
    ], (function (param) {
        return Jest.Expect[/* toEqual */12](param[1])(Jest.Expect[/* expect */0](param[0].length));
      }));

describe("describe", (function () {
        return Jest.test("some aspect", (function () {
                      return Jest.Expect[/* toBe */2](3)(Jest.Expect[/* expect */0](3));
                    }));
      }));

describe("beforeAll", (function () {
        var x = [0];
        beforeAll((function () {
                x[0] = x[0] + 4 | 0;
                return /* () */0;
              }));
        Jest.test("x is 4", (function () {
                return Jest.Expect[/* toBe */2](4)(Jest.Expect[/* expect */0](x[0]));
              }));
        return Jest.test("x is still 4", (function () {
                      return Jest.Expect[/* toBe */2](4)(Jest.Expect[/* expect */0](x[0]));
                    }));
      }));

describe("beforeEach", (function () {
        var x = [0];
        beforeEach((function () {
                x[0] = x[0] + 4 | 0;
                return /* () */0;
              }));
        Jest.test("x is 4", (function () {
                return Jest.Expect[/* toBe */2](4)(Jest.Expect[/* expect */0](x[0]));
              }));
        return Jest.test("x is suddenly 8", (function () {
                      return Jest.Expect[/* toBe */2](8)(Jest.Expect[/* expect */0](x[0]));
                    }));
      }));

describe("afterAll", (function () {
        var x = [0];
        describe("phase 1", (function () {
                afterAll((function () {
                        x[0] = x[0] + 4 | 0;
                        return /* () */0;
                      }));
                return Jest.test("x is 0", (function () {
                              return Jest.Expect[/* toBe */2](0)(Jest.Expect[/* expect */0](x[0]));
                            }));
              }));
        describe("phase 2", (function () {
                return Jest.test("x is suddenly 4", (function () {
                              return Jest.Expect[/* toBe */2](4)(Jest.Expect[/* expect */0](x[0]));
                            }));
              }));
        return /* () */0;
      }));

describe("afterEach", (function () {
        var x = [0];
        afterEach((function () {
                x[0] = x[0] + 4 | 0;
                return /* () */0;
              }));
        Jest.test("x is 0", (function () {
                return Jest.Expect[/* toBe */2](0)(Jest.Expect[/* expect */0](x[0]));
              }));
        return Jest.test("x is suddenly 4", (function () {
                      return Jest.Expect[/* toBe */2](4)(Jest.Expect[/* expect */0](x[0]));
                    }));
      }));

describe("Only", (function () {
        return /* () */0;
      }));

describe("Skip", (function () {
        test.skip("Skip.test", (function () {
                return Jest.Expect[/* toBe */2](3)(Jest.Expect[/* expect */0](3));
              }));
        test.skip("Skip.testAsync", (function (done_) {
                return Curry._1(done_, Jest.Expect[/* toBe */2](3)(Jest.Expect[/* expect */0](3)));
              }));
        test.skip("Skip.testPromise", (function () {
                return Promise.resolve(Jest.Expect[/* toBe */2](3)(Jest.Expect[/* expect */0](3)));
              }));
        test.skip("testAll", /* :: */[
              "foo",
              /* :: */[
                "bar",
                /* :: */[
                  "baz",
                  /* [] */0
                ]
              ]
            ], (function (input) {
                return Jest.Expect[/* toEqual */12](3)(Jest.Expect[/* expect */0](input.length));
              }));
        test.skip("testAll - tuples", /* :: */[
              /* tuple */[
                "foo",
                3
              ],
              /* :: */[
                /* tuple */[
                  "barbaz",
                  6
                ],
                /* :: */[
                  /* tuple */[
                    "bananas!",
                    8
                  ],
                  /* [] */0
                ]
              ]
            ], (function (param) {
                return Jest.Expect[/* toEqual */12](param[1])(Jest.Expect[/* expect */0](param[0].length));
              }));
        describe.skip("Skip.describe", (function () {
                return Jest.test("some aspect", (function () {
                              return Jest.Expect[/* toBe */2](3)(Jest.Expect[/* expect */0](3));
                            }));
              }));
        return /* () */0;
      }));

/*  Not a pure module */
