'use strict';

var Jest                    = require("../src/jest.js");
var Curry                   = require("bs-platform/lib/js/curry.js");
var Pervasives              = require("bs-platform/lib/js/pervasives.js");
var Caml_builtin_exceptions = require("bs-platform/lib/js/caml_builtin_exceptions.js");

describe("Expect", (function () {
        Jest.test("toBe", (function () {
                return Jest.Expect[/* toBe */2](3)(Jest.Expect[/* expect */0](3));
              }));
        Jest.test("toBeCloseTo", (function () {
                return Jest.Expect[/* toBeCloseTo */3](3)(Jest.Expect[/* expect */0](1 + 2));
              }));
        Jest.test("toBeSoCloseTo", (function () {
                return Jest.Expect[/* toBeSoCloseTo */4](3, 9)(Jest.Expect[/* expect */0](1 + 2));
              }));
        Jest.test("toBeGreaterThan", (function () {
                return Jest.Expect[/* toBeGreaterThan */5](3)(Jest.Expect[/* expect */0](4));
              }));
        Jest.test("toBeGreaterThanOrEqual", (function () {
                return Jest.Expect[/* toBeGreaterThanOrEqual */6](4)(Jest.Expect[/* expect */0](4));
              }));
        Jest.test("toBeLessThan", (function () {
                return Jest.Expect[/* toBeLessThan */7](5)(Jest.Expect[/* expect */0](4));
              }));
        Jest.test("toBeLessThanOrEqual", (function () {
                return Jest.Expect[/* toBeLessThanOrEqual */8](4)(Jest.Expect[/* expect */0](4));
              }));
        Jest.test("toBeSuperSetOf", (function () {
                return Jest.Expect[/* toBeSupersetOf */9](/* array */[
                              "a",
                              "c"
                            ])(Jest.Expect[/* expect */0](/* array */[
                                "a",
                                "b",
                                "c"
                              ]));
              }));
        Jest.test("toContain", (function () {
                return Jest.Expect[/* toContain */10]("b")(Jest.Expect[/* expect */0](/* array */[
                                "a",
                                "b",
                                "c"
                              ]));
              }));
        Jest.test("toContainString", (function () {
                return Jest.Expect[/* toContainString */11]("nana")(Jest.Expect[/* expect */0]("banana"));
              }));
        Jest.test("toHaveLength", (function () {
                return Jest.Expect[/* toHaveLength */13](3)(Jest.Expect[/* expect */0](/* array */[
                                "a",
                                "b",
                                "c"
                              ]));
              }));
        Jest.test("toEqual", (function () {
                return Jest.Expect[/* toEqual */12](3)(Jest.Expect[/* expect */0](3));
              }));
        Jest.test("toMatch", (function () {
                return Jest.Expect[/* toMatch */14]("nana")(Jest.Expect[/* expect */0]("banana"));
              }));
        Jest.test("toMatchRe", (function () {
                return Jest.Expect[/* toMatchRe */15]((/ana/))(Jest.Expect[/* expect */0]("banana"));
              }));
        Jest.test("toThrow", (function () {
                return Jest.Expect[/* toThrow */18](Jest.Expect[/* expect */0]((function () {
                                  throw [
                                        Caml_builtin_exceptions.assert_failure,
                                        [
                                          "expect_test.ml",
                                          37,
                                          22
                                        ]
                                      ];
                                })));
              }));
        test.skip("toThrow - no throw - should compile, but fail test", (function () {
                return Jest.Expect[/* toThrow */18](Jest.Expect[/* expect */0]((function () {
                                  return 2;
                                })));
              }));
        Jest.test("toThrowMessage", (function () {
                return Jest.Expect[/* toThrowMessage */20]("Invalid_argument,-3,foo", Jest.Expect[/* expect */0]((function () {
                                  throw [
                                        Caml_builtin_exceptions.invalid_argument,
                                        "foo"
                                      ];
                                })));
              }));
        Jest.test("toThrowMessageRe", (function () {
                return Jest.Expect[/* toThrowMessageRe */21]((/Assert_failure/), Jest.Expect[/* expect */0]((function () {
                                  throw [
                                        Caml_builtin_exceptions.assert_failure,
                                        [
                                          "expect_test.ml",
                                          45,
                                          22
                                        ]
                                      ];
                                })));
              }));
        Jest.test("not_ |> toBe", (function () {
                return Jest.Expect[/* toBe */2](4)(Jest.Expect[/* not_ */22](Jest.Expect[/* expect */0](3)));
              }));
        return Jest.test("expectFn", (function () {
                      return Jest.Expect[/* toThrowMessage */20]("Invalid_argument,-3,foo", Jest.Expect[/* expectFn */1]((function (prim) {
                                        throw prim;
                                      }), [
                                      Caml_builtin_exceptions.invalid_argument,
                                      "foo"
                                    ]));
                    }));
      }));

describe("Expect.Operators", (function () {
        Jest.test("==", (function () {
                return Curry._2(Jest.Expect[/* Operators */23][/* == */0], Jest.Expect[/* expect */0](3), 3);
              }));
        Jest.test(">", (function () {
                return Curry._2(Jest.Expect[/* Operators */23][/* > */1], Jest.Expect[/* expect */0](4), 3);
              }));
        Jest.test(">=", (function () {
                return Curry._2(Jest.Expect[/* Operators */23][/* >= */2], Jest.Expect[/* expect */0](4), 4);
              }));
        Jest.test("<", (function () {
                return Curry._2(Jest.Expect[/* Operators */23][/* < */3], Jest.Expect[/* expect */0](4), 5);
              }));
        Jest.test("<=", (function () {
                return Curry._2(Jest.Expect[/* Operators */23][/* <= */4], Jest.Expect[/* expect */0](4), 4);
              }));
        Jest.test("=", (function () {
                return Curry._2(Jest.Expect[/* Operators */23][/* = */5], Jest.Expect[/* expect */0](3), 3);
              }));
        Jest.test("<>", (function () {
                return Curry._2(Jest.Expect[/* Operators */23][/* <> */6], Jest.Expect[/* expect */0](3), 4);
              }));
        return Jest.test("!=", (function () {
                      return Curry._2(Jest.Expect[/* Operators */23][/* != */7], Jest.Expect[/* expect */0](3), 4);
                    }));
      }));

describe("ExpectJs", (function () {
        Jest.test("toBe", (function () {
                return Jest.ExpectJs[/* toBe */2](3)(Jest.ExpectJs[/* expect */0](3));
              }));
        Jest.test("toBeCloseTo", (function () {
                return Jest.ExpectJs[/* toBeCloseTo */3](3)(Jest.ExpectJs[/* expect */0](1 + 2));
              }));
        Jest.test("toBeSoCloseTo", (function () {
                return Jest.ExpectJs[/* toBeSoCloseTo */4](3, 9)(Jest.ExpectJs[/* expect */0](1 + 2));
              }));
        Jest.test("toBeDefined", (function () {
                return Jest.ExpectJs[/* toBeDefined */24](Jest.ExpectJs[/* expect */0](3));
              }));
        Jest.test("toBeFalsy", (function () {
                return Jest.ExpectJs[/* toBeFalsy */25](Jest.ExpectJs[/* expect */0](Pervasives.nan));
              }));
        Jest.test("toBeGreaterThan", (function () {
                return Jest.ExpectJs[/* toBeGreaterThan */5](3)(Jest.ExpectJs[/* expect */0](4));
              }));
        Jest.test("toBeGreaterThanOrEqual", (function () {
                return Jest.ExpectJs[/* toBeGreaterThanOrEqual */6](4)(Jest.ExpectJs[/* expect */0](4));
              }));
        Jest.test("toBeLessThan", (function () {
                return Jest.ExpectJs[/* toBeLessThan */7](5)(Jest.ExpectJs[/* expect */0](4));
              }));
        Jest.test("toBeLessThanOrEqual", (function () {
                return Jest.ExpectJs[/* toBeLessThanOrEqual */8](4)(Jest.ExpectJs[/* expect */0](4));
              }));
        Jest.test("toBeNull", (function () {
                return Jest.ExpectJs[/* toBeFalsy */25](Jest.ExpectJs[/* expect */0](Pervasives.nan));
              }));
        Jest.test("toBeSuperSetOf", (function () {
                return Jest.ExpectJs[/* toBeSupersetOf */9](/* array */[
                              "a",
                              "c"
                            ])(Jest.ExpectJs[/* expect */0](/* array */[
                                "a",
                                "b",
                                "c"
                              ]));
              }));
        Jest.test("toBeTruthy", (function () {
                return Jest.ExpectJs[/* toBeTruthy */27](Jest.ExpectJs[/* expect */0](/* array */[]));
              }));
        Jest.test("toBeUndefined", (function () {
                return Jest.ExpectJs[/* toBeUndefined */28](Jest.ExpectJs[/* expect */0](undefined));
              }));
        Jest.test("toContain", (function () {
                return Jest.ExpectJs[/* toContain */10]("b")(Jest.ExpectJs[/* expect */0](/* array */[
                                "a",
                                "b",
                                "c"
                              ]));
              }));
        Jest.test("toContainString", (function () {
                return Jest.ExpectJs[/* toContainString */11]("nana")(Jest.ExpectJs[/* expect */0]("banana"));
              }));
        Jest.test("toContainProperties", (function () {
                return Jest.ExpectJs[/* toContainProperties */29](/* array */[
                              "foo",
                              "bar"
                            ])(Jest.ExpectJs[/* expect */0]({
                                foo: 0,
                                bar: /* true */1
                              }));
              }));
        Jest.test("toHaveLength", (function () {
                return Jest.ExpectJs[/* toHaveLength */13](3)(Jest.ExpectJs[/* expect */0](/* array */[
                                "a",
                                "b",
                                "c"
                              ]));
              }));
        Jest.test("toEqual", (function () {
                return Jest.ExpectJs[/* toEqual */12](3)(Jest.ExpectJs[/* expect */0](3));
              }));
        Jest.test("toMatch", (function () {
                return Jest.ExpectJs[/* toMatch */14]("nana")(Jest.ExpectJs[/* expect */0]("banana"));
              }));
        Jest.test("toMatchRe", (function () {
                return Jest.ExpectJs[/* toMatchRe */15]((/ana/))(Jest.ExpectJs[/* expect */0]("banana"));
              }));
        Jest.test("toMatchObject", (function () {
                return Jest.ExpectJs[/* toMatchObject */30]({
                              a: 1,
                              b: 2
                            })(Jest.ExpectJs[/* expect */0]({
                                a: 1,
                                b: 2,
                                c: 3
                              }));
              }));
        Jest.test("toThrow", (function () {
                return Jest.ExpectJs[/* toThrow */18](Jest.ExpectJs[/* expect */0]((function () {
                                  throw [
                                        Caml_builtin_exceptions.assert_failure,
                                        [
                                          "expect_test.ml",
                                          121,
                                          22
                                        ]
                                      ];
                                })));
              }));
        Jest.test("toThrowMessage", (function () {
                return Jest.ExpectJs[/* toThrowMessage */20]("Invalid_argument,-3,foo", Jest.ExpectJs[/* expect */0]((function () {
                                  throw [
                                        Caml_builtin_exceptions.invalid_argument,
                                        "foo"
                                      ];
                                })));
              }));
        Jest.test("toThrowMessageRe", (function () {
                return Jest.ExpectJs[/* toThrowMessageRe */21]((/Assert_failure/), Jest.ExpectJs[/* expect */0]((function () {
                                  throw [
                                        Caml_builtin_exceptions.assert_failure,
                                        [
                                          "expect_test.ml",
                                          127,
                                          22
                                        ]
                                      ];
                                })));
              }));
        return Jest.test("not_ |> toBe", (function () {
                      return Jest.ExpectJs[/* toBe */2](4)(Jest.ExpectJs[/* not_ */22](Jest.ExpectJs[/* expect */0](3)));
                    }));
      }));

/*  Not a pure module */
