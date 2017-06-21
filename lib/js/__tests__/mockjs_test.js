'use strict';

var Jest       = require("../src/jest.js");
var Curry      = require("bs-platform/lib/js/curry.js");
var Caml_int32 = require("bs-platform/lib/js/caml_int32.js");
var Pervasives = require("bs-platform/lib/js/pervasives.js");

function call(self, arg) {
  return self.call(/* () */0, arg);
}

describe("inferred_fn", (function () {
        Jest.test("returns undefined", (function () {
                var mockFn = jest.fn();
                return Curry._1(Jest.ExpectJs[/* toBeUndefined */28], Curry._1(Jest.ExpectJs[/* expect */0], mockFn.call(/* () */0, /* () */0)));
              }));
        Jest.test("black hole for argument type object", (function () {
                var mockFn = jest.fn();
                return Curry._1(Jest.ExpectJs[/* toBeUndefined */28], Curry._1(Jest.ExpectJs[/* expect */0], mockFn.call(/* () */0, {
                                    property: 42
                                  })));
              }));
        Jest.test("black hole for argument type string", (function () {
                var mockFn = jest.fn();
                return Curry._1(Jest.ExpectJs[/* toBeUndefined */28], Curry._1(Jest.ExpectJs[/* expect */0], mockFn.call(/* () */0, "some string")));
              }));
        Jest.test("calls - records call arguments", (function () {
                var mockFn = jest.fn();
                mockFn.call(/* () */0, "first");
                mockFn.call(/* () */0, "second");
                var calls = Curry._1(Jest.MockJs[/* calls */0], mockFn);
                return Curry._2(Jest.ExpectJs[/* toEqual */12], /* array */[
                            "first",
                            "second"
                          ], Curry._1(Jest.ExpectJs[/* expect */0], calls));
              }));
        Jest.test("mockClear - resets calls", (function () {
                var mockFn = jest.fn();
                var before = Curry._1(Jest.MockJs[/* calls */0], mockFn);
                /* tuple */[
                  mockFn.call(/* () */0, 1),
                  mockFn.call(/* () */0, 2)
                ];
                var inbetween = Curry._1(Jest.MockJs[/* calls */0], mockFn);
                mockFn.mockClear();
                var after = Curry._1(Jest.MockJs[/* calls */0], mockFn);
                return Curry._2(Jest.ExpectJs[/* toEqual */12], /* tuple */[
                            /* int array */[],
                            /* int array */[
                              1,
                              2
                            ],
                            /* int array */[]
                          ], Curry._1(Jest.ExpectJs[/* expect */0], /* tuple */[
                                before,
                                inbetween,
                                after
                              ]));
              }));
        Jest.test("mockReset - resets calls", (function () {
                var mockFn = jest.fn();
                var before = Curry._1(Jest.MockJs[/* calls */0], mockFn);
                /* tuple */[
                  mockFn.call(/* () */0, 1),
                  mockFn.call(/* () */0, 2)
                ];
                var inbetween = Curry._1(Jest.MockJs[/* calls */0], mockFn);
                mockFn.mockReset();
                var after = Curry._1(Jest.MockJs[/* calls */0], mockFn);
                return Curry._2(Jest.ExpectJs[/* toEqual */12], /* tuple */[
                            /* int array */[],
                            /* int array */[
                              1,
                              2
                            ],
                            /* int array */[]
                          ], Curry._1(Jest.ExpectJs[/* expect */0], /* tuple */[
                                before,
                                inbetween,
                                after
                              ]));
              }));
        Jest.test("mockReset - resets implementations", (function () {
                var mockFn = jest.fn();
                mockFn.mockReturnValue(128);
                var before = mockFn.call(/* () */0, /* () */0);
                mockFn.mockReset();
                var after = mockFn.call(/* () */0, /* () */0);
                return Curry._2(Jest.ExpectJs[/* toEqual */12], /* tuple */[
                            128,
                            undefined
                          ], Curry._1(Jest.ExpectJs[/* expect */0], /* tuple */[
                                before,
                                after
                              ]));
              }));
        Jest.test("mockImplementation - sets implementation to use for subsequent invocations", (function () {
                var mockFn = jest.fn();
                var before = mockFn.call(/* () */0, 10);
                mockFn.mockImplementation(Pervasives.string_of_int);
                return Curry._2(Jest.ExpectJs[/* toEqual */12], /* tuple */[
                            undefined,
                            "18",
                            "24"
                          ], Curry._1(Jest.ExpectJs[/* expect */0], /* tuple */[
                                before,
                                mockFn.call(/* () */0, 18),
                                mockFn.call(/* () */0, 24)
                              ]));
              }));
        Jest.test("mockImplementationOnce - queues implementation for one subsequent invocation", (function () {
                var mockFn = jest.fn();
                var before = mockFn.call(/* () */0, 10);
                mockFn.mockImplementationOnce(Pervasives.string_of_int);
                mockFn.mockImplementationOnce((function (a) {
                        return Pervasives.string_of_int((a << 1));
                      }));
                return Curry._2(Jest.ExpectJs[/* toEqual */12], /* tuple */[
                            undefined,
                            "18",
                            "48",
                            undefined
                          ], Curry._1(Jest.ExpectJs[/* expect */0], /* tuple */[
                                before,
                                mockFn.call(/* () */0, 18),
                                mockFn.call(/* () */0, 24),
                                mockFn.call(/* () */0, 12)
                              ]));
              }));
        Jest.test("mockReturnThis - returns `this` on subsequent invocations", (function () {
                var mockFn = jest.fn();
                var $$this = "this";
                var fn = mockFn.bind($$this);
                var before = fn.call(/* () */0, /* () */0);
                mockFn.mockReturnThis();
                return Curry._2(Jest.ExpectJs[/* toEqual */12], /* tuple */[
                            undefined,
                            $$this,
                            $$this
                          ], Curry._1(Jest.ExpectJs[/* expect */0], /* tuple */[
                                before,
                                fn.call(/* () */0, /* () */0),
                                fn.call(/* () */0, /* () */0)
                              ]));
              }));
        Jest.test("mockReturnValue - returns given value on subsequent invocations", (function () {
                var mockFn = jest.fn();
                var before = mockFn.call(/* () */0, 10);
                mockFn.mockReturnValue(146);
                return Curry._2(Jest.ExpectJs[/* toEqual */12], /* tuple */[
                            undefined,
                            146,
                            146
                          ], Curry._1(Jest.ExpectJs[/* expect */0], /* tuple */[
                                before,
                                mockFn.call(/* () */0, 18),
                                mockFn.call(/* () */0, 24)
                              ]));
              }));
        return Jest.test("mockReturnValueOnce - queues implementation for one subsequent invocation", (function () {
                      var mockFn = jest.fn();
                      var before = mockFn.call(/* () */0, 10);
                      mockFn.mockReturnValueOnce(29);
                      mockFn.mockReturnValueOnce(41);
                      return Curry._2(Jest.ExpectJs[/* toEqual */12], /* tuple */[
                                  undefined,
                                  29,
                                  41,
                                  undefined
                                ], Curry._1(Jest.ExpectJs[/* expect */0], /* tuple */[
                                      before,
                                      mockFn.call(/* () */0, 18),
                                      mockFn.call(/* () */0, 24),
                                      mockFn.call(/* () */0, 12)
                                    ]));
                    }));
      }));

describe("fn", (function () {
        Jest.test("calls implementation", (function () {
                var mockFn = jest.fn(Pervasives.string_of_int);
                return Curry._2(Jest.ExpectJs[/* toBe */2], "18", Curry._1(Jest.ExpectJs[/* expect */0], Curry._1(mockFn, 18)));
              }));
        Jest.test("calls - records call arguments", (function () {
                var mockFn = jest.fn(Pervasives.string_of_int);
                Curry._1(mockFn, 74);
                Curry._1(mockFn, 89435);
                var calls = Curry._1(Jest.MockJs[/* calls */0], mockFn);
                return Curry._2(Jest.ExpectJs[/* toEqual */12], /* int array */[
                            74,
                            89435
                          ], Curry._1(Jest.ExpectJs[/* expect */0], calls));
              }));
        test.skip("mockClear - resets calls", (function () {
                var mockFn = jest.fn(Pervasives.string_of_int);
                var before = Curry._1(Jest.MockJs[/* calls */0], mockFn);
                /* tuple */[
                  Curry._1(mockFn, 1),
                  Curry._1(mockFn, 2)
                ];
                var inbetween = Curry._1(Jest.MockJs[/* calls */0], mockFn);
                mockFn.mockClear();
                var after = Curry._1(Jest.MockJs[/* calls */0], mockFn);
                return Curry._2(Jest.ExpectJs[/* toEqual */12], /* tuple */[
                            /* int array */[],
                            /* int array */[
                              1,
                              2
                            ],
                            /* int array */[]
                          ], Curry._1(Jest.ExpectJs[/* expect */0], /* tuple */[
                                before,
                                inbetween,
                                after
                              ]));
              }));
        Jest.test("mockReset - resets calls", (function () {
                var mockFn = jest.fn(Pervasives.string_of_int);
                var before = Curry._1(Jest.MockJs[/* calls */0], mockFn);
                /* tuple */[
                  Curry._1(mockFn, 1),
                  Curry._1(mockFn, 2)
                ];
                var inbetween = Curry._1(Jest.MockJs[/* calls */0], mockFn);
                mockFn.mockReset();
                var after = Curry._1(Jest.MockJs[/* calls */0], mockFn);
                return Curry._2(Jest.ExpectJs[/* toEqual */12], /* tuple */[
                            /* int array */[],
                            /* int array */[
                              1,
                              2
                            ],
                            /* int array */[]
                          ], Curry._1(Jest.ExpectJs[/* expect */0], /* tuple */[
                                before,
                                inbetween,
                                after
                              ]));
              }));
        test.skip("mockReset - resets implementations", (function () {
                var mockFn = jest.fn(Pervasives.string_of_int);
                mockFn.mockReturnValue("128");
                var before = Curry._1(mockFn, 0);
                mockFn.mockReset();
                var after = Curry._1(mockFn, 1);
                return Curry._2(Jest.ExpectJs[/* toEqual */12], /* tuple */[
                            "128",
                            "1"
                          ], Curry._1(Jest.ExpectJs[/* expect */0], /* tuple */[
                                before,
                                after
                              ]));
              }));
        Jest.test("mockImplementation - sets implementation to use for subsequent invocations", (function () {
                var mockFn = jest.fn(Pervasives.string_of_int);
                var before = Curry._1(mockFn, 10);
                mockFn.mockImplementation((function (a) {
                        return Pervasives.string_of_int((a << 1));
                      }));
                return Curry._2(Jest.ExpectJs[/* toEqual */12], /* tuple */[
                            "10",
                            "36",
                            "48"
                          ], Curry._1(Jest.ExpectJs[/* expect */0], /* tuple */[
                                before,
                                Curry._1(mockFn, 18),
                                Curry._1(mockFn, 24)
                              ]));
              }));
        Jest.test("mockImplementationOnce - queues implementation for one subsequent invocation", (function () {
                var mockFn = jest.fn(Pervasives.string_of_int);
                var before = Curry._1(mockFn, 10);
                mockFn.mockImplementationOnce((function (a) {
                        return Pervasives.string_of_int(Caml_int32.imul(a, 3));
                      }));
                mockFn.mockImplementationOnce((function (a) {
                        return Pervasives.string_of_int((a << 1));
                      }));
                return Curry._2(Jest.ExpectJs[/* toEqual */12], /* tuple */[
                            "10",
                            "54",
                            "48",
                            "12"
                          ], Curry._1(Jest.ExpectJs[/* expect */0], /* tuple */[
                                before,
                                Curry._1(mockFn, 18),
                                Curry._1(mockFn, 24),
                                Curry._1(mockFn, 12)
                              ]));
              }));
        Jest.test("mockReturnValue - returns given value on subsequent invocations", (function () {
                var mockFn = jest.fn(Pervasives.string_of_int);
                var before = Curry._1(mockFn, 10);
                mockFn.mockReturnValue("146");
                return Curry._2(Jest.ExpectJs[/* toEqual */12], /* tuple */[
                            "10",
                            "146",
                            "146"
                          ], Curry._1(Jest.ExpectJs[/* expect */0], /* tuple */[
                                before,
                                Curry._1(mockFn, 18),
                                Curry._1(mockFn, 24)
                              ]));
              }));
        return Jest.test("mockReturnValueOnce - queues implementation for one subsequent invocation", (function () {
                      var mockFn = jest.fn(Pervasives.string_of_int);
                      var before = Curry._1(mockFn, 10);
                      mockFn.mockReturnValueOnce("29");
                      mockFn.mockReturnValueOnce("41");
                      return Curry._2(Jest.ExpectJs[/* toEqual */12], /* tuple */[
                                  "10",
                                  "29",
                                  "41",
                                  "12"
                                ], Curry._1(Jest.ExpectJs[/* expect */0], /* tuple */[
                                      before,
                                      Curry._1(mockFn, 18),
                                      Curry._1(mockFn, 24),
                                      Curry._1(mockFn, 12)
                                    ]));
                    }));
      }));

describe("fn2", (function () {
        return Jest.test("calls implementation", (function () {
                      var mockFn = jest.fn((function (a, b) {
                              return Pervasives.string_of_int(a + b | 0);
                            }));
                      return Curry._2(Jest.ExpectJs[/* toBe */2], "42", Curry._1(Jest.ExpectJs[/* expect */0], mockFn.call(0, 18, 24)));
                    }));
      }));

exports.call = call;
/*  Not a pure module */
