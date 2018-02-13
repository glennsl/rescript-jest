'use strict';

var Jest = require("../src/jest.js");
var Curry = require("bs-platform/lib/js/curry.js");
var Js_exn = require("bs-platform/lib/js/js_exn.js");
var Pervasives = require("bs-platform/lib/js/pervasives.js");
var Caml_builtin_exceptions = require("bs-platform/lib/js/caml_builtin_exceptions.js");

describe("Expect", (function () {
        Jest.test("toBe", (function () {
                return Jest.Expect[/* toBe */2](3, Jest.Expect[/* expect */0](3));
              }));
        Jest.test("toBeCloseTo", (function () {
                return Jest.Expect[/* toBeCloseTo */3](3, Jest.Expect[/* expect */0](1 + 2));
              }));
        Jest.test("toBeSoCloseTo", (function () {
                return Jest.Expect[/* toBeSoCloseTo */4](3.123, 3, Jest.Expect[/* expect */0](1 + 2.123));
              }));
        Jest.test("toBeGreaterThan", (function () {
                return Jest.Expect[/* toBeGreaterThan */5](3, Jest.Expect[/* expect */0](4));
              }));
        Jest.test("toBeGreaterThanOrEqual", (function () {
                return Jest.Expect[/* toBeGreaterThanOrEqual */6](4, Jest.Expect[/* expect */0](4));
              }));
        Jest.test("toBeLessThan", (function () {
                return Jest.Expect[/* toBeLessThan */7](5, Jest.Expect[/* expect */0](4));
              }));
        Jest.test("toBeLessThanOrEqual", (function () {
                return Jest.Expect[/* toBeLessThanOrEqual */8](4, Jest.Expect[/* expect */0](4));
              }));
        Jest.test("toBeSuperSetOf", (function () {
                return Jest.Expect[/* toBeSupersetOf */9](/* array */[
                            "a",
                            "c"
                          ], Jest.Expect[/* expect */0](/* array */[
                                "a",
                                "b",
                                "c"
                              ]));
              }));
        Jest.test("toContain", (function () {
                return Jest.Expect[/* toContain */10]("b", Jest.Expect[/* expect */0](/* array */[
                                "a",
                                "b",
                                "c"
                              ]));
              }));
        Jest.test("toContainString", (function () {
                return Jest.Expect[/* toContainString */11]("nana", Jest.Expect[/* expect */0]("banana"));
              }));
        Jest.test("toHaveLength", (function () {
                return Jest.Expect[/* toHaveLength */13](3, Jest.Expect[/* expect */0](/* array */[
                                "a",
                                "b",
                                "c"
                              ]));
              }));
        Jest.test("toEqual", (function () {
                return Jest.Expect[/* toEqual */12](3, Jest.Expect[/* expect */0](3));
              }));
        Jest.test("toMatch", (function () {
                return Jest.Expect[/* toMatch */14]("nana", Jest.Expect[/* expect */0]("banana"));
              }));
        Jest.test("toMatchRe", (function () {
                return Jest.Expect[/* toMatchRe */15]((/ana/), Jest.Expect[/* expect */0]("banana"));
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
        Jest.test("toThrowException", (function () {
                return Jest.Expect[/* toThrowException */20]([
                            Caml_builtin_exceptions.invalid_argument,
                            "foo"
                          ], Jest.Expect[/* expect */0]((function () {
                                  throw [
                                        Caml_builtin_exceptions.invalid_argument,
                                        "foo"
                                      ];
                                })));
              }));
        Jest.test("toThrowMessage", (function () {
                return Jest.Expect[/* toThrowMessage */21]("Invalid_argument,-3,foo", Jest.Expect[/* expect */0]((function () {
                                  throw [
                                        Caml_builtin_exceptions.invalid_argument,
                                        "foo"
                                      ];
                                })));
              }));
        Jest.test("toThrowMessageRe", (function () {
                return Jest.Expect[/* toThrowMessageRe */22]((/Assert_failure/), Jest.Expect[/* expect */0]((function () {
                                  throw [
                                        Caml_builtin_exceptions.assert_failure,
                                        [
                                          "expect_test.ml",
                                          43,
                                          22
                                        ]
                                      ];
                                })));
              }));
        Jest.test("toMatchSnapshot", (function () {
                return Jest.Expect[/* toMatchSnapshot */16](Jest.Expect[/* expect */0]("foo"));
              }));
        Jest.test("toMatchSnapshotWithName", (function () {
                return Jest.Expect[/* toMatchSnapshotWithName */17]("bar", Jest.Expect[/* expect */0]("foo"));
              }));
        Jest.test("toThrowErrorMatchingSnapshot", (function () {
                return Jest.Expect[/* toThrowErrorMatchingSnapshot */19](Jest.Expect[/* expect */0]((function () {
                                  return Js_exn.raiseError("foo error");
                                })));
              }));
        Jest.test("not toBe", (function () {
                return Jest.Expect[/* toBe */2](4, Jest.Expect[/* not_ */23](Jest.Expect[/* expect */0](3)));
              }));
        Jest.test("not toBeCloseTo", (function () {
                return Jest.Expect[/* toBeCloseTo */3](4, Jest.Expect[/* not_ */23](Jest.Expect[/* expect */0](1 + 2)));
              }));
        Jest.test("not toBeSoCloseTo", (function () {
                return Jest.Expect[/* toBeSoCloseTo */4](3.12, 3, Jest.Expect[/* not_ */23](Jest.Expect[/* expect */0](1 + 2.123)));
              }));
        Jest.test("not toBeGreaterThan", (function () {
                return Jest.Expect[/* toBeGreaterThan */5](4, Jest.Expect[/* not_ */23](Jest.Expect[/* expect */0](4)));
              }));
        Jest.test("not toBeGreaterThanOrEqual", (function () {
                return Jest.Expect[/* toBeGreaterThanOrEqual */6](5, Jest.Expect[/* not_ */23](Jest.Expect[/* expect */0](4)));
              }));
        Jest.test("not toBeLessThan", (function () {
                return Jest.Expect[/* toBeLessThan */7](4, Jest.Expect[/* not_ */23](Jest.Expect[/* expect */0](4)));
              }));
        Jest.test("not toBeLessThanOrEqual", (function () {
                return Jest.Expect[/* toBeLessThanOrEqual */8](3, Jest.Expect[/* not_ */23](Jest.Expect[/* expect */0](4)));
              }));
        Jest.test("not toBeSuperSetOf", (function () {
                return Jest.Expect[/* toBeSupersetOf */9](/* array */[
                            "a",
                            "d"
                          ], Jest.Expect[/* not_ */23](Jest.Expect[/* expect */0](/* array */[
                                    "a",
                                    "b",
                                    "c"
                                  ])));
              }));
        Jest.test("not toContain", (function () {
                return Jest.Expect[/* toContain */10]("d", Jest.Expect[/* not_ */23](Jest.Expect[/* expect */0](/* array */[
                                    "a",
                                    "b",
                                    "c"
                                  ])));
              }));
        Jest.test("not toContainString", (function () {
                return Jest.Expect[/* toContainString */11]("nanan", Jest.Expect[/* not_ */23](Jest.Expect[/* expect */0]("banana")));
              }));
        Jest.test("not toHaveLength", (function () {
                return Jest.Expect[/* toHaveLength */13](2, Jest.Expect[/* not_ */23](Jest.Expect[/* expect */0](/* array */[
                                    "a",
                                    "b",
                                    "c"
                                  ])));
              }));
        Jest.test("not toEqual", (function () {
                return Jest.Expect[/* toEqual */12](4, Jest.Expect[/* not_ */23](Jest.Expect[/* expect */0](3)));
              }));
        Jest.test("not toMatch", (function () {
                return Jest.Expect[/* toMatch */14]("nanan", Jest.Expect[/* not_ */23](Jest.Expect[/* expect */0]("banana")));
              }));
        Jest.test("not toMatchRe", (function () {
                return Jest.Expect[/* toMatchRe */15]((/anas/), Jest.Expect[/* not_ */23](Jest.Expect[/* expect */0]("banana")));
              }));
        Jest.test("not toThrow", (function () {
                return Jest.Expect[/* toThrow */18](Jest.Expect[/* not_ */23](Jest.Expect[/* expect */0]((function () {
                                      return 2;
                                    }))));
              }));
        Jest.test("not toThrowException", (function () {
                return Jest.Expect[/* toThrowException */20]([
                            Caml_builtin_exceptions.invalid_argument,
                            "bar"
                          ], Jest.Expect[/* not_ */23](Jest.Expect[/* expect */0]((function () {
                                      throw [
                                            Caml_builtin_exceptions.invalid_argument,
                                            "foo"
                                          ];
                                    }))));
              }));
        Jest.test("not toThrowMessage", (function () {
                return Jest.Expect[/* toThrowMessage */21]("Invalid_argument,-3,foo", Jest.Expect[/* not_ */23](Jest.Expect[/* expect */0]((function () {
                                      throw [
                                            Caml_builtin_exceptions.invalid_argument,
                                            "bar"
                                          ];
                                    }))));
              }));
        Jest.test("not toThrowMessageRe", (function () {
                return Jest.Expect[/* toThrowMessageRe */22]((/Assert_failure!/), Jest.Expect[/* not_ */23](Jest.Expect[/* expect */0]((function () {
                                      throw [
                                            Caml_builtin_exceptions.assert_failure,
                                            [
                                              "expect_test.ml",
                                              87,
                                              22
                                            ]
                                          ];
                                    }))));
              }));
        return Jest.test("expectFn", (function () {
                      return Jest.Expect[/* toThrowException */20]([
                                  Caml_builtin_exceptions.invalid_argument,
                                  "foo"
                                ], Jest.Expect[/* expectFn */1]((function (prim) {
                                        throw prim;
                                      }), [
                                      Caml_builtin_exceptions.invalid_argument,
                                      "foo"
                                    ]));
                    }));
      }));

describe("Expect.Operators", (function () {
        Jest.test("==", (function () {
                return Curry._2(Jest.Expect[/* Operators */24][/* == */0], Jest.Expect[/* expect */0](3), 3);
              }));
        Jest.test(">", (function () {
                return Curry._2(Jest.Expect[/* Operators */24][/* > */1], Jest.Expect[/* expect */0](4), 3);
              }));
        Jest.test(">=", (function () {
                return Curry._2(Jest.Expect[/* Operators */24][/* >= */2], Jest.Expect[/* expect */0](4), 4);
              }));
        Jest.test("<", (function () {
                return Curry._2(Jest.Expect[/* Operators */24][/* < */3], Jest.Expect[/* expect */0](4), 5);
              }));
        Jest.test("<=", (function () {
                return Curry._2(Jest.Expect[/* Operators */24][/* <= */4], Jest.Expect[/* expect */0](4), 4);
              }));
        Jest.test("=", (function () {
                return Curry._2(Jest.Expect[/* Operators */24][/* = */5], Jest.Expect[/* expect */0](3), 3);
              }));
        Jest.test("<>", (function () {
                return Curry._2(Jest.Expect[/* Operators */24][/* <> */6], Jest.Expect[/* expect */0](3), 4);
              }));
        return Jest.test("!=", (function () {
                      return Curry._2(Jest.Expect[/* Operators */24][/* != */7], Jest.Expect[/* expect */0](3), 4);
                    }));
      }));

describe("ExpectJs", (function () {
        Jest.test("toBeDefined", (function () {
                return Jest.ExpectJs[/* toBeDefined */25](Jest.ExpectJs[/* expect */0](3));
              }));
        Jest.test("toBeFalsy", (function () {
                return Jest.ExpectJs[/* toBeFalsy */26](Jest.ExpectJs[/* expect */0](Pervasives.nan));
              }));
        Jest.test("toBeNull", (function () {
                return Jest.ExpectJs[/* toBeNull */27](Jest.ExpectJs[/* expect */0](null));
              }));
        Jest.test("toBeTruthy", (function () {
                return Jest.ExpectJs[/* toBeTruthy */28](Jest.ExpectJs[/* expect */0](/* array */[]));
              }));
        Jest.test("toBeUndefined", (function () {
                return Jest.ExpectJs[/* toBeUndefined */29](Jest.ExpectJs[/* expect */0](undefined));
              }));
        Jest.test("toContainProperties", (function () {
                return Jest.ExpectJs[/* toContainProperties */30](/* array */[
                            "foo",
                            "bar"
                          ], Jest.ExpectJs[/* expect */0]({
                                foo: 0,
                                bar: /* true */1
                              }));
              }));
        Jest.test("toMatchObject", (function () {
                return Jest.ExpectJs[/* toMatchObject */31]({
                            a: 1,
                            b: 2
                          }, Jest.ExpectJs[/* expect */0]({
                                a: 1,
                                b: 2,
                                c: 3
                              }));
              }));
        Jest.test("not toBeDefined", (function () {
                return Jest.ExpectJs[/* toBeDefined */25](Jest.ExpectJs[/* not_ */23](Jest.ExpectJs[/* expect */0](undefined)));
              }));
        Jest.test("not toBeFalsy", (function () {
                return Jest.ExpectJs[/* toBeFalsy */26](Jest.ExpectJs[/* not_ */23](Jest.ExpectJs[/* expect */0](/* array */[])));
              }));
        Jest.test("not toBeNull", (function () {
                return Jest.ExpectJs[/* toBeNull */27](Jest.ExpectJs[/* not_ */23](Jest.ExpectJs[/* expect */0](4)));
              }));
        Jest.test("not toBeTruthy", (function () {
                return Jest.ExpectJs[/* toBeTruthy */28](Jest.ExpectJs[/* not_ */23](Jest.ExpectJs[/* expect */0](Pervasives.nan)));
              }));
        Jest.test("not toBeUndefined", (function () {
                return Jest.ExpectJs[/* toBeUndefined */29](Jest.ExpectJs[/* not_ */23](Jest.ExpectJs[/* expect */0](4)));
              }));
        Jest.test("not toContainProperties", (function () {
                return Jest.ExpectJs[/* toContainProperties */30](/* array */[
                            "foo",
                            "zoo"
                          ], Jest.ExpectJs[/* not_ */23](Jest.ExpectJs[/* expect */0]({
                                    foo: 0,
                                    bar: /* true */1
                                  })));
              }));
        return Jest.test("not toMatchObject", (function () {
                      return Jest.ExpectJs[/* toMatchObject */31]({
                                  a: 1,
                                  c: 2
                                }, Jest.ExpectJs[/* not_ */23](Jest.ExpectJs[/* expect */0]({
                                          a: 1,
                                          b: 2,
                                          c: 3
                                        })));
                    }));
      }));

/*  Not a pure module */
