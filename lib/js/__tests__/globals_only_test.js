'use strict';

var Jest = require("../src/jest.js");
var Curry = require("bs-platform/lib/js/curry.js");

Jest.Only[/* test */0]("Only.test", (function () {
        return Jest.pass;
      }));

Jest.Only[/* testAsync */1](/* None */0, "Only.testAsync", (function (finish) {
        return Curry._1(finish, Jest.pass);
      }));

Jest.Only[/* testAsync */1](/* Some */[1], "testAsync - timeout ok", (function (finish) {
        return Curry._1(finish, Jest.pass);
      }));

Jest.Only[/* testPromise */2](/* None */0, "Only.testPromise", (function () {
        return Promise.resolve(Jest.pass);
      }));

Jest.Only[/* testPromise */2](/* Some */[1], "testPromise - timeout ok", (function () {
        return Promise.resolve(Jest.pass);
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
        if (input.length === 3) {
          return Jest.pass;
        } else {
          return Jest.fail("");
        }
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
        if (param[0].length === param[1]) {
          return Jest.pass;
        } else {
          return Jest.fail("");
        }
      }));

describe.only("Only.describe", (function () {
        return Jest.test("some aspect", (function () {
                      return Jest.pass;
                    }));
      }));

/*  Not a pure module */
