'use strict';

var Jest                    = require("../src/jest.js");
var Curry                   = require("bs-platform/lib/js/curry.js");
var Caml_builtin_exceptions = require("bs-platform/lib/js/caml_builtin_exceptions.js");

Jest.test("pass", (function () {
        return Jest.pass;
      }));

it.skip("fail", (function () {
        return Jest.fail("");
      }));

Jest.test("test", (function () {
        return Jest.pass;
      }));

it.skip("test - expect fail", (function () {
        return Jest.fail("");
      }));

Jest.testAsync("testAsync", (function (finish) {
        return Curry._1(finish, Jest.pass);
      }));

it.skip("testAsync - no done", (function () {
        return /* () */0;
      }));

it.skip("testAsync - expect fail", (function (finish) {
        return Curry._1(finish, Jest.fail(""));
      }));

Jest.testPromise("testPromise", (function () {
        return Promise.resolve(Jest.pass);
      }));

it.skip("testPromise - reject", (function () {
        return Promise.reject([
                    Caml_builtin_exceptions.failure,
                    ""
                  ]);
      }));

it.skip("testPromise - expect fail", (function () {
        return Promise.resolve(Jest.fail(""));
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
        if (input.length === 3) {
          return Jest.pass;
        } else {
          return Jest.fail("");
        }
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
        if (param[0].length === param[1]) {
          return Jest.pass;
        } else {
          return Jest.fail("");
        }
      }));

describe("describe", (function () {
        return Jest.test("some aspect", (function () {
                      return Jest.pass;
                    }));
      }));

describe("beforeAll", (function () {
        var x = [0];
        beforeAll((function () {
                x[0] = x[0] + 4 | 0;
                return /* () */0;
              }));
        Jest.test("x is 4", (function () {
                if (x[0] === 4) {
                  return Jest.pass;
                } else {
                  return Jest.fail("");
                }
              }));
        return Jest.test("x is still 4", (function () {
                      if (x[0] === 4) {
                        return Jest.pass;
                      } else {
                        return Jest.fail("");
                      }
                    }));
      }));

describe("beforeAllAsync", (function () {
        describe("without timeout", (function () {
                var x = [0];
                Jest.beforeAllAsync(/* None */0, (function (finish) {
                        x[0] = x[0] + 4 | 0;
                        return Curry._1(finish, /* () */0);
                      }));
                Jest.test("x is 4", (function () {
                        if (x[0] === 4) {
                          return Jest.pass;
                        } else {
                          return Jest.fail("");
                        }
                      }));
                return Jest.test("x is still 4", (function () {
                              if (x[0] === 4) {
                                return Jest.pass;
                              } else {
                                return Jest.fail("");
                              }
                            }));
              }));
        describe("with 100ms timeout", (function () {
                var x = [0];
                Jest.beforeAllAsync(/* Some */[100], (function (finish) {
                        x[0] = x[0] + 4 | 0;
                        return Curry._1(finish, /* () */0);
                      }));
                Jest.test("x is 4", (function () {
                        if (x[0] === 4) {
                          return Jest.pass;
                        } else {
                          return Jest.fail("");
                        }
                      }));
                return Jest.test("x is still 4", (function () {
                              if (x[0] === 4) {
                                return Jest.pass;
                              } else {
                                return Jest.fail("");
                              }
                            }));
              }));
        describe.skip("timeout should fail suite", (function () {
                return Jest.test("", (function () {
                              return Jest.pass;
                            }));
              }));
        return /* () */0;
      }));

describe("beforeAllPromise", (function () {
        describe("without timeout", (function () {
                var x = [0];
                Jest.beforeAllPromise(/* None */0, (function () {
                        x[0] = x[0] + 4 | 0;
                        return Promise.resolve(/* () */0);
                      }));
                Jest.test("x is 4", (function () {
                        if (x[0] === 4) {
                          return Jest.pass;
                        } else {
                          return Jest.fail("");
                        }
                      }));
                return Jest.test("x is still 4", (function () {
                              if (x[0] === 4) {
                                return Jest.pass;
                              } else {
                                return Jest.fail("");
                              }
                            }));
              }));
        describe("with 100ms timeout", (function () {
                var x = [0];
                Jest.beforeAllPromise(/* Some */[100], (function () {
                        x[0] = x[0] + 4 | 0;
                        return Promise.resolve(/* () */0);
                      }));
                Jest.test("x is 4", (function () {
                        if (x[0] === 4) {
                          return Jest.pass;
                        } else {
                          return Jest.fail("");
                        }
                      }));
                return Jest.test("x is still 4", (function () {
                              if (x[0] === 4) {
                                return Jest.pass;
                              } else {
                                return Jest.fail("");
                              }
                            }));
              }));
        describe.skip("timeout should fail suite", (function () {
                return Jest.test("", (function () {
                              return Jest.pass;
                            }));
              }));
        return /* () */0;
      }));

describe("beforeEach", (function () {
        var x = [0];
        beforeEach((function () {
                x[0] = x[0] + 4 | 0;
                return /* () */0;
              }));
        Jest.test("x is 4", (function () {
                if (x[0] === 4) {
                  return Jest.pass;
                } else {
                  return Jest.fail("");
                }
              }));
        return Jest.test("x is suddenly 8", (function () {
                      if (x[0] === 8) {
                        return Jest.pass;
                      } else {
                        return Jest.fail("");
                      }
                    }));
      }));

describe("beforeEachAsync", (function () {
        describe("without timeout", (function () {
                var x = [0];
                Jest.beforeEachAsync(/* None */0, (function (finish) {
                        x[0] = x[0] + 4 | 0;
                        return Curry._1(finish, /* () */0);
                      }));
                Jest.test("x is 4", (function () {
                        if (x[0] === 4) {
                          return Jest.pass;
                        } else {
                          return Jest.fail("");
                        }
                      }));
                return Jest.test("x is suddenly 8", (function () {
                              if (x[0] === 8) {
                                return Jest.pass;
                              } else {
                                return Jest.fail("");
                              }
                            }));
              }));
        describe("with 100ms timeout", (function () {
                var x = [0];
                Jest.beforeEachAsync(/* Some */[100], (function (finish) {
                        x[0] = x[0] + 4 | 0;
                        return Curry._1(finish, /* () */0);
                      }));
                Jest.test("x is 4", (function () {
                        if (x[0] === 4) {
                          return Jest.pass;
                        } else {
                          return Jest.fail("");
                        }
                      }));
                return Jest.test("x is suddenly 8", (function () {
                              if (x[0] === 8) {
                                return Jest.pass;
                              } else {
                                return Jest.fail("");
                              }
                            }));
              }));
        describe.skip("timeout should fail suite", (function () {
                Jest.beforeEachAsync(/* Some */[1], (function () {
                        return /* () */0;
                      }));
                return Jest.test("", (function () {
                              return Jest.pass;
                            }));
              }));
        return /* () */0;
      }));

describe("beforeEachPromise", (function () {
        describe("without timeout", (function () {
                var x = [0];
                Jest.beforeEachPromise(/* None */0, (function () {
                        x[0] = x[0] + 4 | 0;
                        return Promise.resolve(/* true */1);
                      }));
                Jest.test("x is 4", (function () {
                        if (x[0] === 4) {
                          return Jest.pass;
                        } else {
                          return Jest.fail("");
                        }
                      }));
                return Jest.test("x is suddenly 8", (function () {
                              if (x[0] === 8) {
                                return Jest.pass;
                              } else {
                                return Jest.fail("");
                              }
                            }));
              }));
        describe("with 100ms timeout", (function () {
                var x = [0];
                Jest.beforeEachPromise(/* Some */[100], (function () {
                        x[0] = x[0] + 4 | 0;
                        return Promise.resolve(/* true */1);
                      }));
                Jest.test("x is 4", (function () {
                        if (x[0] === 4) {
                          return Jest.pass;
                        } else {
                          return Jest.fail("");
                        }
                      }));
                return Jest.test("x is suddenly 8", (function () {
                              if (x[0] === 8) {
                                return Jest.pass;
                              } else {
                                return Jest.fail("");
                              }
                            }));
              }));
        describe.skip("timeout should fail suite", (function () {
                Jest.beforeEachPromise(/* Some */[1], (function () {
                        return new Promise((function (_, _$1) {
                                      return /* () */0;
                                    }));
                      }));
                return Jest.test("", (function () {
                              return Jest.pass;
                            }));
              }));
        return /* () */0;
      }));

describe("afterAll", (function () {
        var x = [0];
        describe("phase 1", (function () {
                afterAll((function () {
                        x[0] = x[0] + 4 | 0;
                        return /* () */0;
                      }));
                Jest.test("x is 0", (function () {
                        if (x[0]) {
                          return Jest.fail("");
                        } else {
                          return Jest.pass;
                        }
                      }));
                return Jest.test("x is still 0", (function () {
                              if (x[0]) {
                                return Jest.fail("");
                              } else {
                                return Jest.pass;
                              }
                            }));
              }));
        describe("phase 2", (function () {
                return Jest.test("x is suddenly 4", (function () {
                              if (x[0] === 4) {
                                return Jest.pass;
                              } else {
                                return Jest.fail("");
                              }
                            }));
              }));
        return /* () */0;
      }));

describe("afterAllAsync", (function () {
        describe("without timeout", (function () {
                var x = [0];
                describe("phase 1", (function () {
                        Jest.afterAllAsync(/* None */0, (function (finish) {
                                x[0] = x[0] + 4 | 0;
                                return Curry._1(finish, /* () */0);
                              }));
                        Jest.test("x is 0", (function () {
                                if (x[0]) {
                                  return Jest.fail("");
                                } else {
                                  return Jest.pass;
                                }
                              }));
                        return Jest.test("x is still 0", (function () {
                                      if (x[0]) {
                                        return Jest.fail("");
                                      } else {
                                        return Jest.pass;
                                      }
                                    }));
                      }));
                describe("phase 2", (function () {
                        return Jest.test("x is suddenly 4", (function () {
                                      if (x[0] === 4) {
                                        return Jest.pass;
                                      } else {
                                        return Jest.fail("");
                                      }
                                    }));
                      }));
                return /* () */0;
              }));
        describe("with 100ms timeout", (function () {
                var x = [0];
                describe("phase 1", (function () {
                        Jest.afterAllAsync(/* Some */[100], (function (finish) {
                                x[0] = x[0] + 4 | 0;
                                return Curry._1(finish, /* () */0);
                              }));
                        Jest.test("x is 0", (function () {
                                if (x[0]) {
                                  return Jest.fail("");
                                } else {
                                  return Jest.pass;
                                }
                              }));
                        return Jest.test("x is still 0", (function () {
                                      if (x[0]) {
                                        return Jest.fail("");
                                      } else {
                                        return Jest.pass;
                                      }
                                    }));
                      }));
                describe("phase 2", (function () {
                        return Jest.test("x is suddenly 4", (function () {
                                      if (x[0] === 4) {
                                        return Jest.pass;
                                      } else {
                                        return Jest.fail("");
                                      }
                                    }));
                      }));
                return /* () */0;
              }));
        describe("timeout should not fail suite", (function () {
                Jest.afterAllAsync(/* Some */[1], (function () {
                        return /* () */0;
                      }));
                return Jest.test("", (function () {
                              return Jest.pass;
                            }));
              }));
        return /* () */0;
      }));

describe("afterAllPromise", (function () {
        describe("without timeout", (function () {
                var x = [0];
                describe("phase 1", (function () {
                        Jest.afterAllPromise(/* None */0, (function () {
                                x[0] = x[0] + 4 | 0;
                                return Promise.resolve(/* true */1);
                              }));
                        Jest.test("x is 0", (function () {
                                if (x[0]) {
                                  return Jest.fail("");
                                } else {
                                  return Jest.pass;
                                }
                              }));
                        return Jest.test("x is still 0", (function () {
                                      if (x[0]) {
                                        return Jest.fail("");
                                      } else {
                                        return Jest.pass;
                                      }
                                    }));
                      }));
                describe("phase 2", (function () {
                        return Jest.test("x is suddenly 4", (function () {
                                      if (x[0] === 4) {
                                        return Jest.pass;
                                      } else {
                                        return Jest.fail("");
                                      }
                                    }));
                      }));
                return /* () */0;
              }));
        describe("with 100ms timeout", (function () {
                var x = [0];
                describe("phase 1", (function () {
                        Jest.afterAllPromise(/* Some */[100], (function () {
                                x[0] = x[0] + 4 | 0;
                                return Promise.resolve(/* true */1);
                              }));
                        Jest.test("x is 0", (function () {
                                if (x[0]) {
                                  return Jest.fail("");
                                } else {
                                  return Jest.pass;
                                }
                              }));
                        return Jest.test("x is still 0", (function () {
                                      if (x[0]) {
                                        return Jest.fail("");
                                      } else {
                                        return Jest.pass;
                                      }
                                    }));
                      }));
                describe("phase 2", (function () {
                        return Jest.test("x is suddenly 4", (function () {
                                      if (x[0] === 4) {
                                        return Jest.pass;
                                      } else {
                                        return Jest.fail("");
                                      }
                                    }));
                      }));
                return /* () */0;
              }));
        describe("timeout should not fail suite", (function () {
                Jest.afterAllPromise(/* Some */[1], (function () {
                        return new Promise((function (_, _$1) {
                                      return /* () */0;
                                    }));
                      }));
                return Jest.test("", (function () {
                              return Jest.pass;
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
                if (x[0]) {
                  return Jest.fail("");
                } else {
                  return Jest.pass;
                }
              }));
        return Jest.test("x is suddenly 4", (function () {
                      if (x[0] === 4) {
                        return Jest.pass;
                      } else {
                        return Jest.fail("");
                      }
                    }));
      }));

describe("afterEachAsync", (function () {
        describe("without timeout", (function () {
                var x = [0];
                Jest.afterEachAsync(/* None */0, (function (finish) {
                        x[0] = x[0] + 4 | 0;
                        return Curry._1(finish, /* () */0);
                      }));
                Jest.test("x is 0", (function () {
                        if (x[0]) {
                          return Jest.fail("");
                        } else {
                          return Jest.pass;
                        }
                      }));
                return Jest.test("x is suddenly 4", (function () {
                              if (x[0] === 4) {
                                return Jest.pass;
                              } else {
                                return Jest.fail("");
                              }
                            }));
              }));
        describe("with 100ms timeout", (function () {
                var x = [0];
                Jest.afterEachAsync(/* Some */[100], (function (finish) {
                        x[0] = x[0] + 4 | 0;
                        return Curry._1(finish, /* () */0);
                      }));
                Jest.test("x is 0", (function () {
                        if (x[0]) {
                          return Jest.fail("");
                        } else {
                          return Jest.pass;
                        }
                      }));
                return Jest.test("x is suddenly 4", (function () {
                              if (x[0] === 4) {
                                return Jest.pass;
                              } else {
                                return Jest.fail("");
                              }
                            }));
              }));
        describe.skip("timeout should fail suite", (function () {
                Jest.afterEachAsync(/* Some */[1], (function () {
                        return /* () */0;
                      }));
                return Jest.test("", (function () {
                              return Jest.pass;
                            }));
              }));
        return /* () */0;
      }));

describe("afterEachPromise", (function () {
        describe("without timeout", (function () {
                var x = [0];
                Jest.afterEachPromise(/* None */0, (function () {
                        x[0] = x[0] + 4 | 0;
                        return Promise.resolve(/* true */1);
                      }));
                Jest.test("x is 0", (function () {
                        if (x[0]) {
                          return Jest.fail("");
                        } else {
                          return Jest.pass;
                        }
                      }));
                return Jest.test("x is suddenly 4", (function () {
                              if (x[0] === 4) {
                                return Jest.pass;
                              } else {
                                return Jest.fail("");
                              }
                            }));
              }));
        describe("with 100ms timeout", (function () {
                var x = [0];
                Jest.afterEachPromise(/* Some */[100], (function () {
                        x[0] = x[0] + 4 | 0;
                        return Promise.resolve(/* true */1);
                      }));
                Jest.test("x is 0", (function () {
                        if (x[0]) {
                          return Jest.fail("");
                        } else {
                          return Jest.pass;
                        }
                      }));
                return Jest.test("x is suddenly 4", (function () {
                              if (x[0] === 4) {
                                return Jest.pass;
                              } else {
                                return Jest.fail("");
                              }
                            }));
              }));
        describe.skip("timeout should fail suite", (function () {
                Jest.afterEachPromise(/* Some */[1], (function () {
                        return new Promise((function (_, _$1) {
                                      return /* () */0;
                                    }));
                      }));
                return Jest.test("", (function () {
                              return Jest.pass;
                            }));
              }));
        return /* () */0;
      }));

describe("Only", (function () {
        return /* () */0;
      }));

describe("Skip", (function () {
        it.skip("Skip.test", (function () {
                return Jest.pass;
              }));
        it.skip("Skip.testAsync", (function (finish) {
                return Curry._1(finish, Jest.pass);
              }));
        it.skip("Skip.testPromise", (function () {
                return Promise.resolve(Jest.pass);
              }));
        it.skip("testAll", /* :: */[
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
        it.skip("testAll - tuples", /* :: */[
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
        describe.skip("Skip.describe", (function () {
                return Jest.test("some aspect", (function () {
                              return Jest.pass;
                            }));
              }));
        return /* () */0;
      }));

/*  Not a pure module */
