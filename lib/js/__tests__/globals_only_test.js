'use strict';

var Jest  = require("../src/jest.js");
var Curry = require("bs-platform/lib/js/curry.js");

Jest.Only[/* test */0]("Only.test", (function () {
        return Jest.Expect[/* toBe */2](3)(Jest.Expect[/* expect */0](3));
      }));

Jest.Only[/* testAsync */1]("Only.testAsync", (function (done_) {
        return Curry._1(done_, Jest.Expect[/* toBe */2](3)(Jest.Expect[/* expect */0](3)));
      }));

Jest.Only[/* testPromise */2]("Only.testPromise", (function () {
        return Promise.resolve(Jest.Expect[/* toBe */2](3)(Jest.Expect[/* expect */0](3)));
      }));

Jest.Only[/* testAll */3]("testAll", /* :: */[
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

Jest.Only[/* testAll */3]("testAll - tuples", /* :: */[
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

describe.only("Only.describe", (function () {
        return Jest.test("some aspect", (function () {
                      return Jest.Expect[/* toBe */2](3)(Jest.Expect[/* expect */0](3));
                    }));
      }));

/*  Not a pure module */
