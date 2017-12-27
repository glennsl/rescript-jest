'use strict';

var List                    = require("bs-platform/lib/js/list.js");
var $$Array                 = require("bs-platform/lib/js/array.js");
var Block                   = require("bs-platform/lib/js/block.js");
var Curry                   = require("bs-platform/lib/js/curry.js");
var Js_undefined            = require("bs-platform/lib/js/js_undefined.js");
var Caml_builtin_exceptions = require("bs-platform/lib/js/caml_builtin_exceptions.js");

function mapMod(f, param) {
  if (param.tag) {
    return /* Not */Block.__(1, [Curry._1(f, param[0])]);
  } else {
    return /* Just */Block.__(0, [Curry._1(f, param[0])]);
  }
}

var objectContaining = (
    function (properties) {
      var spec = {};
      properties.forEach(function (property) {
        spec[property] = expect.anything();
      });
      return spec;
    }
  );

function assert_(param) {
  if (param.tag) {
    var match = param[0];
    var exit = 0;
    if (typeof match === "number") {
      fail("not ok");
      return /* () */0;
    } else {
      switch (match.tag | 0) {
        case 0 : 
            return /* () */0;
        case 1 : 
            return expect(match[0]).not.toContain(match[1]);
        case 2 : 
            return expect(match[0]).not.toHaveLength(match[1]);
        case 3 : 
            return expect(match[0]).not.toEqual(expect.arrayContaining(match[1]));
        case 4 : 
            return expect(match[0]).not.toBe(match[1]);
        case 5 : 
            return expect(match[0]).not.toBeDefined();
        case 6 : 
            return expect(match[0]).not.toEqual(match[1]);
        case 7 : 
            return expect(match[0]).not.toBeFalsy();
        case 8 : 
            return expect(match[0]).not.toBeCloseTo(match[1], Js_undefined.from_opt(match[2]));
        case 9 : 
            return expect(match[0]).not.toBeGreaterThan(match[1]);
        case 10 : 
            return expect(match[0]).not.toBeGreaterThanOrEqual(match[1]);
        case 11 : 
            return expect(match[0]).not.toBeLessThan(match[1]);
        case 12 : 
            return expect(match[0]).not.toBeLessrThanOrEqual(match[1]);
        case 13 : 
            return expect(match[0]).not.toMatchSnapshot();
        case 14 : 
            return expect(match[0]).not.toMatchSnapshot(match[1]);
        case 15 : 
            return expect(match[0]).not.toBeNull();
        case 16 : 
            return expect(match[0]).not.toEqual(Curry._1(objectContaining, match[1]));
        case 17 : 
            return expect(match[0]).not.toMatchObject(match[1]);
        case 18 : 
            return expect(match[0]).not.toEqual(expect.stringContaining(match[1]));
        case 19 : 
            return expect(match[0]).not.toMatch(match[1]);
        case 20 : 
            return expect(match[0]).not.toThrow();
        case 21 : 
            return expect(match[0]).not.toThrowErrorMatchingSnapshot();
        case 22 : 
        case 23 : 
            exit = 1;
            break;
        case 24 : 
            return expect(match[0]).not.toBeTruthy();
        case 25 : 
            return expect(match[0]).not.toBeUndefined();
        
      }
    }
    if (exit === 1) {
      return expect(match[0]).not.toThrow(match[1]);
    }
    
  } else {
    var match$1 = param[0];
    var exit$1 = 0;
    if (typeof match$1 === "number") {
      return /* () */0;
    } else {
      switch (match$1.tag | 0) {
        case 0 : 
            fail(match$1[0]);
            return /* () */0;
        case 1 : 
            return expect(match$1[0]).toContain(match$1[1]);
        case 2 : 
            return expect(match$1[0]).toHaveLength(match$1[1]);
        case 3 : 
            return expect(match$1[0]).toEqual(expect.arrayContaining(match$1[1]));
        case 4 : 
            return expect(match$1[0]).toBe(match$1[1]);
        case 5 : 
            return expect(match$1[0]).toBeDefined();
        case 6 : 
            return expect(match$1[0]).toEqual(match$1[1]);
        case 7 : 
            return expect(match$1[0]).toBeFalsy();
        case 8 : 
            return expect(match$1[0]).toBeCloseTo(match$1[1], Js_undefined.from_opt(match$1[2]));
        case 9 : 
            return expect(match$1[0]).toBeGreaterThan(match$1[1]);
        case 10 : 
            return expect(match$1[0]).toBeGreaterThanOrEqual(match$1[1]);
        case 11 : 
            return expect(match$1[0]).toBeLessThan(match$1[1]);
        case 12 : 
            return expect(match$1[0]).toBeLessThanOrEqual(match$1[1]);
        case 13 : 
            return expect(match$1[0]).toMatchSnapshot();
        case 14 : 
            return expect(match$1[0]).toMatchSnapshot(match$1[1]);
        case 15 : 
            return expect(match$1[0]).toBeNull();
        case 16 : 
            return expect(match$1[0]).toEqual(Curry._1(objectContaining, match$1[1]));
        case 17 : 
            return expect(match$1[0]).toMatchObject(match$1[1]);
        case 18 : 
            return expect(match$1[0]).toEqual(expect.stringContaining(match$1[1]));
        case 19 : 
            return expect(match$1[0]).toMatch(match$1[1]);
        case 20 : 
            return expect(match$1[0]).toThrow();
        case 21 : 
            return expect(match$1[0]).toThrowErrorMatchingSnapshot();
        case 22 : 
        case 23 : 
            exit$1 = 1;
            break;
        case 24 : 
            return expect(match$1[0]).toBeTruthy();
        case 25 : 
            return expect(match$1[0]).toBeUndefined();
        
      }
    }
    if (exit$1 === 1) {
      return expect(match$1[0]).toThrow(match$1[1]);
    }
    
  }
}

function test$1(name, callback) {
  test(name, (function () {
          assert_(Curry._1(callback, /* () */0));
          return undefined;
        }));
  return /* () */0;
}

function testAsync(name, callback) {
  test(name, (function (done_) {
          Curry._1(callback, (function ($$case) {
                  assert_($$case);
                  return Curry._1(done_, /* () */0);
                }));
          return undefined;
        }));
  return /* () */0;
}

function testPromise(name, callback) {
  test(name, (function () {
          return Curry._1(callback, /* () */0).then((function (a) {
                        return Promise.resolve(assert_(a));
                      }));
        }));
  return /* () */0;
}

function testAll(name, inputs, callback) {
  return List.iter((function (input) {
                var name$1 = "" + (String(name) + (" - " + (String(input) + "")));
                test(name$1, (function () {
                        assert_(Curry._1(callback, input));
                        return undefined;
                      }));
                return /* () */0;
              }), inputs);
}

function test$2(name, callback) {
  test.only(name, (function () {
          assert_(Curry._1(callback, /* () */0));
          return undefined;
        }));
  return /* () */0;
}

function testAsync$1(name, callback) {
  test.only(name, (function (done_) {
          Curry._1(callback, (function (assertion) {
                  assert_(assertion);
                  return Curry._1(done_, /* () */0);
                }));
          return undefined;
        }));
  return /* () */0;
}

function testPromise$1(name, callback) {
  test.only(name, (function () {
          return Curry._1(callback, /* () */0).then((function (a) {
                        return Promise.resolve(assert_(a));
                      }));
        }));
  return /* () */0;
}

function testAll$1(name, inputs, callback) {
  return List.iter((function (input) {
                var name$1 = "" + (String(name) + (" - " + (String(input) + "")));
                test.only(name$1, (function () {
                        assert_(Curry._1(callback, input));
                        return undefined;
                      }));
                return /* () */0;
              }), inputs);
}

var Only = /* module */[
  /* test */test$2,
  /* testAsync */testAsync$1,
  /* testPromise */testPromise$1,
  /* testAll */testAll$1
];

var Skip = /* module */[];

function fail$1(message) {
  return /* Just */Block.__(0, [/* Fail */Block.__(0, [message])]);
}

function expect$1(a) {
  return /* Just */Block.__(0, [a]);
}

function expectFn(f, a) {
  return /* Just */Block.__(0, [(function () {
                return Curry._1(f, a);
              })]);
}

function toBe(b) {
  return (function (param) {
      return mapMod((function (a) {
                    return /* Be */Block.__(4, [
                              a,
                              b
                            ]);
                  }), param);
    });
}

function toBeCloseTo(b) {
  return (function (param) {
      return mapMod((function (a) {
                    return /* FloatCloseTo */Block.__(8, [
                              a,
                              b,
                              /* None */0
                            ]);
                  }), param);
    });
}

function toBeSoCloseTo(b, digits) {
  return (function (param) {
      return mapMod((function (a) {
                    return /* FloatCloseTo */Block.__(8, [
                              a,
                              b,
                              /* Some */[digits]
                            ]);
                  }), param);
    });
}

function toBeGreaterThan(b) {
  return (function (param) {
      return mapMod((function (a) {
                    return /* GreaterThan */Block.__(9, [
                              a,
                              b
                            ]);
                  }), param);
    });
}

function toBeGreaterThanOrEqual(b) {
  return (function (param) {
      return mapMod((function (a) {
                    return /* GreaterThanOrEqual */Block.__(10, [
                              a,
                              b
                            ]);
                  }), param);
    });
}

function toBeLessThan(b) {
  return (function (param) {
      return mapMod((function (a) {
                    return /* LessThan */Block.__(11, [
                              a,
                              b
                            ]);
                  }), param);
    });
}

function toBeLessThanOrEqual(b) {
  return (function (param) {
      return mapMod((function (a) {
                    return /* LessThanOrEqual */Block.__(12, [
                              a,
                              b
                            ]);
                  }), param);
    });
}

function toBeSupersetOf(b) {
  return (function (param) {
      return mapMod((function (a) {
                    return /* ArraySuperset */Block.__(3, [
                              a,
                              b
                            ]);
                  }), param);
    });
}

function toContain(b) {
  return (function (param) {
      return mapMod((function (a) {
                    return /* ArrayContains */Block.__(1, [
                              a,
                              b
                            ]);
                  }), param);
    });
}

function toContainString(b) {
  return (function (param) {
      return mapMod((function (a) {
                    return /* StringContains */Block.__(18, [
                              a,
                              b
                            ]);
                  }), param);
    });
}

function toEqual(b) {
  return (function (param) {
      return mapMod((function (a) {
                    return /* Equal */Block.__(6, [
                              a,
                              b
                            ]);
                  }), param);
    });
}

function toHaveLength(l) {
  return (function (param) {
      return mapMod((function (a) {
                    return /* ArrayLength */Block.__(2, [
                              a,
                              l
                            ]);
                  }), param);
    });
}

function toMatch(s) {
  return (function (param) {
      return mapMod((function (a) {
                    return /* StringMatch */Block.__(19, [
                              a,
                              new RegExp(s)
                            ]);
                  }), param);
    });
}

function toMatchRe(re) {
  return (function (param) {
      return mapMod((function (a) {
                    return /* StringMatch */Block.__(19, [
                              a,
                              re
                            ]);
                  }), param);
    });
}

function toMatchSnapshot(a) {
  return mapMod((function (a) {
                return /* MatchSnapshot */Block.__(13, [a]);
              }), a);
}

function toMatchSnapshotWithName(name) {
  return (function (param) {
      return mapMod((function (a) {
                    return /* MatchSnapshotName */Block.__(14, [
                              a,
                              name
                            ]);
                  }), param);
    });
}

function toThrow(param) {
  if (param.tag) {
    return /* Not */Block.__(1, [/* Throws */Block.__(20, [param[0]])]);
  } else {
    return /* Just */Block.__(0, [/* Throws */Block.__(20, [param[0]])]);
  }
}

function toThrowErrorMatchingSnapshot(param) {
  if (param.tag) {
    return /* Not */Block.__(1, [/* ThrowsMatchSnapshot */Block.__(21, [param[0]])]);
  } else {
    return /* Just */Block.__(0, [/* ThrowsMatchSnapshot */Block.__(21, [param[0]])]);
  }
}

function toThrowMessage(message, param) {
  if (param.tag) {
    return /* Not */Block.__(1, [/* ThrowsMessage */Block.__(22, [
                  param[0],
                  message
                ])]);
  } else {
    return /* Just */Block.__(0, [/* ThrowsMessage */Block.__(22, [
                  param[0],
                  message
                ])]);
  }
}

function toThrowMessageRe(re, param) {
  if (param.tag) {
    return /* Not */Block.__(1, [/* ThrowsMessageRe */Block.__(23, [
                  param[0],
                  re
                ])]);
  } else {
    return /* Just */Block.__(0, [/* ThrowsMessageRe */Block.__(23, [
                  param[0],
                  re
                ])]);
  }
}

function not_(param) {
  if (param.tag) {
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "I suck at GADTs"
        ];
  } else {
    return /* Not */Block.__(1, [param[0]]);
  }
}

function $eq$eq(a, b) {
  return mapMod((function (a) {
                return /* Be */Block.__(4, [
                          a,
                          b
                        ]);
              }), a);
}

function $great(a, b) {
  return mapMod((function (a) {
                return /* GreaterThan */Block.__(9, [
                          a,
                          b
                        ]);
              }), a);
}

function $great$eq(a, b) {
  return mapMod((function (a) {
                return /* GreaterThanOrEqual */Block.__(10, [
                          a,
                          b
                        ]);
              }), a);
}

function $less(a, b) {
  return mapMod((function (a) {
                return /* LessThan */Block.__(11, [
                          a,
                          b
                        ]);
              }), a);
}

function $less$eq(a, b) {
  return mapMod((function (a) {
                return /* LessThanOrEqual */Block.__(12, [
                          a,
                          b
                        ]);
              }), a);
}

function $eq(a, b) {
  return mapMod((function (a) {
                return /* Equal */Block.__(6, [
                          a,
                          b
                        ]);
              }), a);
}

function $less$great(a, b) {
  var param = not_(a);
  return mapMod((function (a) {
                return /* Equal */Block.__(6, [
                          a,
                          b
                        ]);
              }), param);
}

function $bang$eq(a, b) {
  var param = not_(a);
  return mapMod((function (a) {
                return /* Be */Block.__(4, [
                          a,
                          b
                        ]);
              }), param);
}

var Operators = /* module */[
  /* == */$eq$eq,
  /* > */$great,
  /* >= */$great$eq,
  /* < */$less,
  /* <= */$less$eq,
  /* = */$eq,
  /* <> */$less$great,
  /* != */$bang$eq
];

var Expect = /* module */[
  /* expect */expect$1,
  /* expectFn */expectFn,
  /* toBe */toBe,
  /* toBeCloseTo */toBeCloseTo,
  /* toBeSoCloseTo */toBeSoCloseTo,
  /* toBeGreaterThan */toBeGreaterThan,
  /* toBeGreaterThanOrEqual */toBeGreaterThanOrEqual,
  /* toBeLessThan */toBeLessThan,
  /* toBeLessThanOrEqual */toBeLessThanOrEqual,
  /* toBeSupersetOf */toBeSupersetOf,
  /* toContain */toContain,
  /* toContainString */toContainString,
  /* toEqual */toEqual,
  /* toHaveLength */toHaveLength,
  /* toMatch */toMatch,
  /* toMatchRe */toMatchRe,
  /* toMatchSnapshot */toMatchSnapshot,
  /* toMatchSnapshotWithName */toMatchSnapshotWithName,
  /* toThrow */toThrow,
  /* toThrowErrorMatchingSnapshot */toThrowErrorMatchingSnapshot,
  /* toThrowMessage */toThrowMessage,
  /* toThrowMessageRe */toThrowMessageRe,
  /* not_ */not_,
  /* Operators */Operators
];

function toBeDefined(a) {
  return mapMod((function (a) {
                return /* Defined */Block.__(5, [a]);
              }), a);
}

function toBeFalsy(a) {
  return mapMod((function (a) {
                return /* Falsy */Block.__(7, [a]);
              }), a);
}

function toBeNull(a) {
  return mapMod((function (a) {
                return /* Null */Block.__(15, [a]);
              }), a);
}

function toBeTruthy(a) {
  return mapMod((function (a) {
                return /* Truthy */Block.__(24, [a]);
              }), a);
}

function toBeUndefined(a) {
  return mapMod((function (a) {
                return /* Undefined */Block.__(25, [a]);
              }), a);
}

function toContainProperties(props) {
  return (function (param) {
      return mapMod((function (a) {
                    return /* ObjectContains */Block.__(16, [
                              a,
                              props
                            ]);
                  }), param);
    });
}

function toMatchObject(b) {
  return (function (param) {
      return mapMod((function (a) {
                    return /* ObjectMatch */Block.__(17, [
                              a,
                              b
                            ]);
                  }), param);
    });
}

function calls(self) {
  return $$Array.map((
    function (args) { return args.length === 1 ? args[0] : args }
  ), self.mock.calls.slice());
}

function instances(self) {
  return self.mock.instances.slice();
}

var MockJs = /* module */[
  /* calls */calls,
  /* instances */instances
];

var Jest = /* module */[];

var JestJs = /* module */[];

function Runner(funarg) {
  var test$3 = function (name, callback) {
    test(name, (function () {
            Curry._1(funarg[/* assert_ */0], Curry._1(callback, /* () */0));
            return undefined;
          }));
    return /* () */0;
  };
  var testAsync = function (name, callback) {
    test(name, (function (done_) {
            Curry._1(callback, (function ($$case) {
                    Curry._1(funarg[/* assert_ */0], $$case);
                    return Curry._1(done_, /* () */0);
                  }));
            return undefined;
          }));
    return /* () */0;
  };
  var testPromise = function (name, callback) {
    test(name, (function () {
            return Curry._1(callback, /* () */0).then((function (a) {
                          return Promise.resolve(Curry._1(funarg[/* assert_ */0], a));
                        }));
          }));
    return /* () */0;
  };
  var testAll = function (name, inputs, callback) {
    return List.iter((function (input) {
                  var name$1 = "" + (String(name) + (" - " + (String(input) + "")));
                  test(name$1, (function () {
                          Curry._1(funarg[/* assert_ */0], Curry._1(callback, input));
                          return undefined;
                        }));
                  return /* () */0;
                }), inputs);
  };
  var test$4 = function (name, callback) {
    test.only(name, (function () {
            Curry._1(funarg[/* assert_ */0], Curry._1(callback, /* () */0));
            return undefined;
          }));
    return /* () */0;
  };
  var testAsync$1 = function (name, callback) {
    test.only(name, (function (done_) {
            Curry._1(callback, (function (assertion) {
                    Curry._1(funarg[/* assert_ */0], assertion);
                    return Curry._1(done_, /* () */0);
                  }));
            return undefined;
          }));
    return /* () */0;
  };
  var testPromise$1 = function (name, callback) {
    test.only(name, (function () {
            return Curry._1(callback, /* () */0).then((function (a) {
                          return Promise.resolve(Curry._1(funarg[/* assert_ */0], a));
                        }));
          }));
    return /* () */0;
  };
  var testAll$1 = function (name, inputs, callback) {
    return List.iter((function (input) {
                  var name$1 = "" + (String(name) + (" - " + (String(input) + "")));
                  test.only(name$1, (function () {
                          Curry._1(funarg[/* assert_ */0], Curry._1(callback, input));
                          return undefined;
                        }));
                  return /* () */0;
                }), inputs);
  };
  var Only = /* module */[
    /* test */test$4,
    /* testAsync */testAsync$1,
    /* testPromise */testPromise$1,
    /* testAll */testAll$1
  ];
  return [
          test$3,
          testAsync,
          testPromise,
          testAll,
          Only,
          [(function (prim, prim$1, prim$2) {
                test.skip(prim, prim$1, prim$2);
                return /* () */0;
              })]
        ];
}

var pass = /* Just */Block.__(0, [/* Ok */0]);

var ExpectJs = [
  expect$1,
  expectFn,
  toBe,
  toBeCloseTo,
  toBeSoCloseTo,
  toBeGreaterThan,
  toBeGreaterThanOrEqual,
  toBeLessThan,
  toBeLessThanOrEqual,
  toBeSupersetOf,
  toContain,
  toContainString,
  toEqual,
  toHaveLength,
  toMatch,
  toMatchRe,
  toMatchSnapshot,
  toMatchSnapshotWithName,
  toThrow,
  toThrowErrorMatchingSnapshot,
  toThrowMessage,
  toThrowMessageRe,
  not_,
  Operators,
  toBeDefined,
  toBeFalsy,
  toBeNull,
  toBeTruthy,
  toBeUndefined,
  toContainProperties,
  toMatchObject
];

exports.Runner      = Runner;
exports.test        = test$1;
exports.testAsync   = testAsync;
exports.testPromise = testPromise;
exports.testAll     = testAll;
exports.Only        = Only;
exports.Skip        = Skip;
exports.pass        = pass;
exports.fail        = fail$1;
exports.Expect      = Expect;
exports.ExpectJs    = ExpectJs;
exports.MockJs      = MockJs;
exports.Jest        = Jest;
exports.JestJs      = JestJs;
/* objectContaining Not a pure module */
