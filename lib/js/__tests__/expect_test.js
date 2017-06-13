'use strict';

var Jest                    = require("../src/jest.js");
var Curry                   = require("bs-platform/lib/js/curry.js");
var Pervasives              = require("bs-platform/lib/js/pervasives.js");
var Caml_builtin_exceptions = require("bs-platform/lib/js/caml_builtin_exceptions.js");

describe("Expect", (function () {
        Jest.test("toBe", (function () {
                return Curry._2(Jest.Expect[/* toBe */2], 3, Curry._1(Jest.Expect[/* expect */0], 3));
              }));
        Jest.test("toBeCloseTo", (function () {
                return Curry._2(Jest.Expect[/* toBeCloseTo */3], 3, Curry._1(Jest.Expect[/* expect */0], 1 + 2));
              }));
        Jest.test("toBeSoCloseTo", (function () {
                return Curry._3(Jest.Expect[/* toBeSoCloseTo */4], 3, 9, Curry._1(Jest.Expect[/* expect */0], 1 + 2));
              }));
        Jest.test("toBeGreaterThan", (function () {
                return Curry._2(Jest.Expect[/* toBeGreaterThan */5], 3, Curry._1(Jest.Expect[/* expect */0], 4));
              }));
        Jest.test("toBeGreaterThanOrEqual", (function () {
                return Curry._2(Jest.Expect[/* toBeGreaterThanOrEqual */6], 4, Curry._1(Jest.Expect[/* expect */0], 4));
              }));
        Jest.test("toBeLessThan", (function () {
                return Curry._2(Jest.Expect[/* toBeLessThan */7], 5, Curry._1(Jest.Expect[/* expect */0], 4));
              }));
        Jest.test("toBeLessThanOrEqual", (function () {
                return Curry._2(Jest.Expect[/* toBeLessThanOrEqual */8], 4, Curry._1(Jest.Expect[/* expect */0], 4));
              }));
        Jest.test("toBeSuperSetOf", (function () {
                return Curry._2(Jest.Expect[/* toBeSupersetOf */9], /* array */[
                            "a",
                            "c"
                          ], Curry._1(Jest.Expect[/* expect */0], /* array */[
                                "a",
                                "b",
                                "c"
                              ]));
              }));
        Jest.test("toContain", (function () {
                return Curry._2(Jest.Expect[/* toContain */10], "b", Curry._1(Jest.Expect[/* expect */0], /* array */[
                                "a",
                                "b",
                                "c"
                              ]));
              }));
        Jest.test("toContainString", (function () {
                return Curry._2(Jest.Expect[/* toContainString */11], "nana", Curry._1(Jest.Expect[/* expect */0], "banana"));
              }));
        Jest.test("toHaveLength", (function () {
                return Curry._2(Jest.Expect[/* toHaveLength */13], 3, Curry._1(Jest.Expect[/* expect */0], /* array */[
                                "a",
                                "b",
                                "c"
                              ]));
              }));
        Jest.test("toEqual", (function () {
                return Curry._2(Jest.Expect[/* toEqual */12], 3, Curry._1(Jest.Expect[/* expect */0], 3));
              }));
        Jest.test("toMatch", (function () {
                return Curry._2(Jest.Expect[/* toMatch */14], "nana", Curry._1(Jest.Expect[/* expect */0], "banana"));
              }));
        Jest.test("toMatchRe", (function () {
                return Curry._2(Jest.Expect[/* toMatchRe */15], (/ana/), Curry._1(Jest.Expect[/* expect */0], "banana"));
              }));
        Jest.test("toThrow", (function () {
                return Curry._1(Jest.Expect[/* toThrow */18], Curry._1(Jest.Expect[/* expect */0], (function () {
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
                return Curry._1(Jest.Expect[/* toThrow */18], Curry._1(Jest.Expect[/* expect */0], (function () {
                                  return 2;
                                })));
              }));
        Jest.test("toThrowMessage", (function () {
                return Curry._2(Jest.Expect[/* toThrowMessage */20], "Invalid_argument,-3,foo", Curry._1(Jest.Expect[/* expect */0], (function () {
                                  throw [
                                        Caml_builtin_exceptions.invalid_argument,
                                        "foo"
                                      ];
                                })));
              }));
        Jest.test("toThrowMessageRe", (function () {
                return Curry._2(Jest.Expect[/* toThrowMessageRe */21], (/Assert_failure/), Curry._1(Jest.Expect[/* expect */0], (function () {
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
                return Curry._2(Jest.Expect[/* toBe */2], 4, Curry._1(Jest.Expect[/* not_ */22], Curry._1(Jest.Expect[/* expect */0], 3)));
              }));
        return Jest.test("expectFn", (function () {
                      return Curry._2(Jest.Expect[/* toThrowMessage */20], "Invalid_argument,-3,foo", Curry._2(Jest.Expect[/* expectFn */1], (function (prim) {
                                        throw prim;
                                      }), [
                                      Caml_builtin_exceptions.invalid_argument,
                                      "foo"
                                    ]));
                    }));
      }));

describe("Expect.Operators", (function () {
        Jest.test("==", (function () {
                return Curry._2(Jest.Expect[/* Operators */23][/* == */0], Curry._1(Jest.Expect[/* expect */0], 3), 3);
              }));
        Jest.test(">", (function () {
                return Curry._2(Jest.Expect[/* Operators */23][/* > */1], Curry._1(Jest.Expect[/* expect */0], 4), 3);
              }));
        Jest.test(">=", (function () {
                return Curry._2(Jest.Expect[/* Operators */23][/* >= */2], Curry._1(Jest.Expect[/* expect */0], 4), 4);
              }));
        Jest.test("<", (function () {
                return Curry._2(Jest.Expect[/* Operators */23][/* < */3], Curry._1(Jest.Expect[/* expect */0], 4), 5);
              }));
        Jest.test("<=", (function () {
                return Curry._2(Jest.Expect[/* Operators */23][/* <= */4], Curry._1(Jest.Expect[/* expect */0], 4), 4);
              }));
        Jest.test("=", (function () {
                return Curry._2(Jest.Expect[/* Operators */23][/* = */5], Curry._1(Jest.Expect[/* expect */0], 3), 3);
              }));
        Jest.test("<>", (function () {
                return Curry._2(Jest.Expect[/* Operators */23][/* <> */6], Curry._1(Jest.Expect[/* expect */0], 3), 4);
              }));
        return Jest.test("!=", (function () {
                      return Curry._2(Jest.Expect[/* Operators */23][/* != */7], Curry._1(Jest.Expect[/* expect */0], 3), 4);
                    }));
      }));

describe("ExpectJs", (function () {
        Jest.test("toBe", (function () {
                return Curry._2(Jest.ExpectJs[/* toBe */2], 3, Curry._1(Jest.ExpectJs[/* expect */0], 3));
              }));
        Jest.test("toBeCloseTo", (function () {
                return Curry._2(Jest.ExpectJs[/* toBeCloseTo */3], 3, Curry._1(Jest.ExpectJs[/* expect */0], 1 + 2));
              }));
        Jest.test("toBeSoCloseTo", (function () {
                return Curry._3(Jest.ExpectJs[/* toBeSoCloseTo */4], 3, 9, Curry._1(Jest.ExpectJs[/* expect */0], 1 + 2));
              }));
        Jest.test("toBeDefined", (function () {
                return Curry._1(Jest.ExpectJs[/* toBeDefined */24], Curry._1(Jest.ExpectJs[/* expect */0], 3));
              }));
        Jest.test("toBeFalsy", (function () {
                return Curry._1(Jest.ExpectJs[/* toBeFalsy */25], Curry._1(Jest.ExpectJs[/* expect */0], Pervasives.nan));
              }));
        Jest.test("toBeGreaterThan", (function () {
                return Curry._2(Jest.ExpectJs[/* toBeGreaterThan */5], 3, Curry._1(Jest.ExpectJs[/* expect */0], 4));
              }));
        Jest.test("toBeGreaterThanOrEqual", (function () {
                return Curry._2(Jest.ExpectJs[/* toBeGreaterThanOrEqual */6], 4, Curry._1(Jest.ExpectJs[/* expect */0], 4));
              }));
        Jest.test("toBeLessThan", (function () {
                return Curry._2(Jest.ExpectJs[/* toBeLessThan */7], 5, Curry._1(Jest.ExpectJs[/* expect */0], 4));
              }));
        Jest.test("toBeLessThanOrEqual", (function () {
                return Curry._2(Jest.ExpectJs[/* toBeLessThanOrEqual */8], 4, Curry._1(Jest.ExpectJs[/* expect */0], 4));
              }));
        Jest.test("toBeNull", (function () {
                return Curry._1(Jest.ExpectJs[/* toBeFalsy */25], Curry._1(Jest.ExpectJs[/* expect */0], Pervasives.nan));
              }));
        Jest.test("toBeSuperSetOf", (function () {
                return Curry._2(Jest.ExpectJs[/* toBeSupersetOf */9], /* array */[
                            "a",
                            "c"
                          ], Curry._1(Jest.ExpectJs[/* expect */0], /* array */[
                                "a",
                                "b",
                                "c"
                              ]));
              }));
        Jest.test("toBeTruthy", (function () {
                return Curry._1(Jest.ExpectJs[/* toBeTruthy */27], Curry._1(Jest.ExpectJs[/* expect */0], /* array */[]));
              }));
        Jest.test("toBeUndefined", (function () {
                return Curry._1(Jest.ExpectJs[/* toBeUndefined */28], Curry._1(Jest.ExpectJs[/* expect */0], undefined));
              }));
        Jest.test("toContain", (function () {
                return Curry._2(Jest.ExpectJs[/* toContain */10], "b", Curry._1(Jest.ExpectJs[/* expect */0], /* array */[
                                "a",
                                "b",
                                "c"
                              ]));
              }));
        Jest.test("toContainString", (function () {
                return Curry._2(Jest.ExpectJs[/* toContainString */11], "nana", Curry._1(Jest.ExpectJs[/* expect */0], "banana"));
              }));
        Jest.test("toContainProperties", (function () {
                return Curry._2(Jest.ExpectJs[/* toContainProperties */29], /* array */[
                            "foo",
                            "bar"
                          ], Curry._1(Jest.ExpectJs[/* expect */0], {
                                foo: 0,
                                bar: /* true */1
                              }));
              }));
        Jest.test("toHaveLength", (function () {
                return Curry._2(Jest.ExpectJs[/* toHaveLength */13], 3, Curry._1(Jest.ExpectJs[/* expect */0], /* array */[
                                "a",
                                "b",
                                "c"
                              ]));
              }));
        Jest.test("toEqual", (function () {
                return Curry._2(Jest.ExpectJs[/* toEqual */12], 3, Curry._1(Jest.ExpectJs[/* expect */0], 3));
              }));
        Jest.test("toMatch", (function () {
                return Curry._2(Jest.ExpectJs[/* toMatch */14], "nana", Curry._1(Jest.ExpectJs[/* expect */0], "banana"));
              }));
        Jest.test("toMatchRe", (function () {
                return Curry._2(Jest.ExpectJs[/* toMatchRe */15], (/ana/), Curry._1(Jest.ExpectJs[/* expect */0], "banana"));
              }));
        Jest.test("toMatchObject", (function () {
                return Curry._2(Jest.ExpectJs[/* toMatchObject */30], {
                            a: 1,
                            b: 2
                          }, Curry._1(Jest.ExpectJs[/* expect */0], {
                                a: 1,
                                b: 2,
                                c: 3
                              }));
              }));
        Jest.test("toThrow", (function () {
                return Curry._1(Jest.ExpectJs[/* toThrow */18], Curry._1(Jest.ExpectJs[/* expect */0], (function () {
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
                return Curry._2(Jest.ExpectJs[/* toThrowMessage */20], "Invalid_argument,-3,foo", Curry._1(Jest.ExpectJs[/* expect */0], (function () {
                                  throw [
                                        Caml_builtin_exceptions.invalid_argument,
                                        "foo"
                                      ];
                                })));
              }));
        Jest.test("toThrowMessageRe", (function () {
                return Curry._2(Jest.ExpectJs[/* toThrowMessageRe */21], (/Assert_failure/), Curry._1(Jest.ExpectJs[/* expect */0], (function () {
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
                      return Curry._2(Jest.ExpectJs[/* toBe */2], 4, Curry._1(Jest.ExpectJs[/* not_ */22], Curry._1(Jest.ExpectJs[/* expect */0], 3)));
                    }));
      }));

/*  Not a pure module */
