'use strict';

var List         = require("bs-platform/lib/js/list.js");
var $$Array      = require("bs-platform/lib/js/array.js");
var Block        = require("bs-platform/lib/js/block.js");
var Curry        = require("bs-platform/lib/js/curry.js");
var Js_undefined = require("bs-platform/lib/js/js_undefined.js");

function mapMod(f, param) {
  if (param[0] >= 826472012) {
    return /* `Just */[
            826472012,
            Curry._1(f, param[1])
          ];
  } else {
    return /* `Not */[
            3903731,
            Curry._1(f, param[1])
          ];
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
  if (typeof param === "number") {
    return /* () */0;
  } else {
    switch (param.tag | 0) {
      case 0 : 
          fail(param[0]);
          return /* () */0;
      case 1 : 
          var match = param[0];
          if (match[0] >= 826472012) {
            var match$1 = match[1];
            return expect(match$1[0]).toContain(match$1[1]);
          } else {
            var match$2 = match[1];
            return expect(match$2[0]).not.toContain(match$2[1]);
          }
          break;
      case 2 : 
          var match$3 = param[0];
          if (match$3[0] >= 826472012) {
            var match$4 = match$3[1];
            return expect(match$4[0]).toHaveLength(match$4[1]);
          } else {
            var match$5 = match$3[1];
            return expect(match$5[0]).not.toHaveLength(match$5[1]);
          }
          break;
      case 3 : 
          var match$6 = param[0];
          if (match$6[0] >= 826472012) {
            var match$7 = match$6[1];
            return expect(match$7[0]).toEqual(expect.arrayContaining(match$7[1]));
          } else {
            var match$8 = match$6[1];
            return expect(match$8[0]).not.toEqual(expect.arrayContaining(match$8[1]));
          }
          break;
      case 4 : 
          var match$9 = param[0];
          if (match$9[0] >= 826472012) {
            var match$10 = match$9[1];
            return expect(match$10[0]).toBe(match$10[1]);
          } else {
            var match$11 = match$9[1];
            return expect(match$11[0]).not.toBe(match$11[1]);
          }
          break;
      case 5 : 
          var match$12 = param[0];
          if (match$12[0] >= 826472012) {
            return expect(match$12[1]).toBeDefined();
          } else {
            return expect(match$12[1]).not.toBeDefined();
          }
      case 6 : 
          var match$13 = param[0];
          if (match$13[0] >= 826472012) {
            var match$14 = match$13[1];
            return expect(match$14[0]).toEqual(match$14[1]);
          } else {
            var match$15 = match$13[1];
            return expect(match$15[0]).not.toEqual(match$15[1]);
          }
          break;
      case 7 : 
          var match$16 = param[0];
          if (match$16[0] >= 826472012) {
            return expect(match$16[1]).toBeFalsy();
          } else {
            return expect(match$16[1]).not.toBeFalsy();
          }
      case 8 : 
          var match$17 = param[0];
          if (match$17[0] >= 826472012) {
            var match$18 = match$17[1];
            return expect(match$18[0]).toBeCloseTo(match$18[1], Js_undefined.from_opt(match$18[2]));
          } else {
            var match$19 = match$17[1];
            return expect(match$19[0]).not.toBeCloseTo(match$19[1], Js_undefined.from_opt(match$19[2]));
          }
          break;
      case 9 : 
          var match$20 = param[0];
          if (match$20[0] >= 826472012) {
            var match$21 = match$20[1];
            return expect(match$21[0]).toBeGreaterThan(match$21[1]);
          } else {
            var match$22 = match$20[1];
            return expect(match$22[0]).not.toBeGreaterThan(match$22[1]);
          }
          break;
      case 10 : 
          var match$23 = param[0];
          if (match$23[0] >= 826472012) {
            var match$24 = match$23[1];
            return expect(match$24[0]).toBeGreaterThanOrEqual(match$24[1]);
          } else {
            var match$25 = match$23[1];
            return expect(match$25[0]).not.toBeGreaterThanOrEqual(match$25[1]);
          }
          break;
      case 11 : 
          var match$26 = param[0];
          if (match$26[0] >= 826472012) {
            var match$27 = match$26[1];
            return expect(match$27[0]).toBeLessThan(match$27[1]);
          } else {
            var match$28 = match$26[1];
            return expect(match$28[0]).not.toBeLessThan(match$28[1]);
          }
          break;
      case 12 : 
          var match$29 = param[0];
          if (match$29[0] >= 826472012) {
            var match$30 = match$29[1];
            return expect(match$30[0]).toBeLessThanOrEqual(match$30[1]);
          } else {
            var match$31 = match$29[1];
            return expect(match$31[0]).not.toBeLessThanOrEqual(match$31[1]);
          }
          break;
      case 13 : 
          return expect(param[0]).toMatchSnapshot();
      case 14 : 
          return expect(param[0]).toMatchSnapshot(param[1]);
      case 15 : 
          var match$32 = param[0];
          if (match$32[0] >= 826472012) {
            return expect(match$32[1]).toBeNull();
          } else {
            return expect(match$32[1]).not.toBeNull();
          }
      case 16 : 
          var match$33 = param[0];
          if (match$33[0] >= 826472012) {
            var match$34 = match$33[1];
            return expect(match$34[0]).toEqual(Curry._1(objectContaining, match$34[1]));
          } else {
            var match$35 = match$33[1];
            return expect(match$35[0]).not.toEqual(Curry._1(objectContaining, match$35[1]));
          }
          break;
      case 17 : 
          var match$36 = param[0];
          if (match$36[0] >= 826472012) {
            var match$37 = match$36[1];
            return expect(match$37[0]).toMatchObject(match$37[1]);
          } else {
            var match$38 = match$36[1];
            return expect(match$38[0]).not.toMatchObject(match$38[1]);
          }
          break;
      case 18 : 
          var match$39 = param[0];
          if (match$39[0] >= 826472012) {
            var match$40 = match$39[1];
            return expect(match$40[0]).toEqual(expect.stringContaining(match$40[1]));
          } else {
            var match$41 = match$39[1];
            return expect(match$41[0]).not.toEqual(expect.stringContaining(match$41[1]));
          }
          break;
      case 19 : 
          var match$42 = param[0];
          if (match$42[0] >= 826472012) {
            var match$43 = match$42[1];
            return expect(match$43[0]).toMatch(match$43[1]);
          } else {
            var match$44 = match$42[1];
            return expect(match$44[0]).not.toMatch(match$44[1]);
          }
          break;
      case 20 : 
          var match$45 = param[0];
          if (match$45[0] >= 826472012) {
            return expect(match$45[1]).toThrow();
          } else {
            return expect(match$45[1]).not.toThrow();
          }
      case 21 : 
          var match$46 = param[0];
          if (match$46[0] >= 826472012) {
            var match$47 = match$46[1];
            return expect(match$47[0]).toThrow(String(match$47[1]));
          } else {
            var match$48 = match$46[1];
            return expect(match$48[0]).not.toThrow(String(match$48[1]));
          }
          break;
      case 22 : 
          return expect(param[0]).toThrowErrorMatchingSnapshot();
      case 23 : 
          var match$49 = param[0];
          if (match$49[0] >= 826472012) {
            var match$50 = match$49[1];
            return expect(match$50[0]).toThrow(match$50[1]);
          } else {
            var match$51 = match$49[1];
            return expect(match$51[0]).not.toThrow(match$51[1]);
          }
          break;
      case 24 : 
          var match$52 = param[0];
          if (match$52[0] >= 826472012) {
            var match$53 = match$52[1];
            return expect(match$53[0]).toThrow(match$53[1]);
          } else {
            var match$54 = match$52[1];
            return expect(match$54[0]).not.toThrow(match$54[1]);
          }
          break;
      case 25 : 
          var match$55 = param[0];
          if (match$55[0] >= 826472012) {
            return expect(match$55[1]).toBeTruthy();
          } else {
            return expect(match$55[1]).not.toBeTruthy();
          }
      case 26 : 
          var match$56 = param[0];
          if (match$56[0] >= 826472012) {
            return expect(match$56[1]).toBeUndefined();
          } else {
            return expect(match$56[1]).not.toBeUndefined();
          }
      
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
  test(name, (function (finish) {
          Curry._1(callback, (function ($$case) {
                  assert_($$case);
                  return Curry._1(finish, /* () */0);
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
  it.only(name, (function () {
          assert_(Curry._1(callback, /* () */0));
          return undefined;
        }));
  return /* () */0;
}

function testAsync$1(name, callback) {
  it.only(name, (function (finish) {
          Curry._1(callback, (function (assertion) {
                  assert_(assertion);
                  return Curry._1(finish, /* () */0);
                }));
          return undefined;
        }));
  return /* () */0;
}

function testPromise$1(name, callback) {
  it.only(name, (function () {
          return Curry._1(callback, /* () */0).then((function (a) {
                        return Promise.resolve(assert_(a));
                      }));
        }));
  return /* () */0;
}

function testAll$1(name, inputs, callback) {
  return List.iter((function (input) {
                var name$1 = "" + (String(name) + (" - " + (String(input) + "")));
                it.only(name$1, (function () {
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
  return /* Fail */Block.__(0, [message]);
}

function expect$1(a) {
  return /* `Just */[
          826472012,
          a
        ];
}

function expectFn(f, a) {
  return /* `Just */[
          826472012,
          (function () {
              return Curry._1(f, a);
            })
        ];
}

function toBe(b, p) {
  return /* Be */Block.__(4, [mapMod((function (a) {
                    return /* tuple */[
                            a,
                            b
                          ];
                  }), p)]);
}

function toBeCloseTo(b, p) {
  return /* FloatCloseTo */Block.__(8, [mapMod((function (a) {
                    return /* tuple */[
                            a,
                            b,
                            /* None */0
                          ];
                  }), p)]);
}

function toBeSoCloseTo(b, digits, p) {
  return /* FloatCloseTo */Block.__(8, [mapMod((function (a) {
                    return /* tuple */[
                            a,
                            b,
                            /* Some */[digits]
                          ];
                  }), p)]);
}

function toBeGreaterThan(b, p) {
  return /* GreaterThan */Block.__(9, [mapMod((function (a) {
                    return /* tuple */[
                            a,
                            b
                          ];
                  }), p)]);
}

function toBeGreaterThanOrEqual(b, p) {
  return /* GreaterThanOrEqual */Block.__(10, [mapMod((function (a) {
                    return /* tuple */[
                            a,
                            b
                          ];
                  }), p)]);
}

function toBeLessThan(b, p) {
  return /* LessThan */Block.__(11, [mapMod((function (a) {
                    return /* tuple */[
                            a,
                            b
                          ];
                  }), p)]);
}

function toBeLessThanOrEqual(b, p) {
  return /* LessThanOrEqual */Block.__(12, [mapMod((function (a) {
                    return /* tuple */[
                            a,
                            b
                          ];
                  }), p)]);
}

function toBeSupersetOf(b, p) {
  return /* ArraySuperset */Block.__(3, [mapMod((function (a) {
                    return /* tuple */[
                            a,
                            b
                          ];
                  }), p)]);
}

function toContain(b, p) {
  return /* ArrayContains */Block.__(1, [mapMod((function (a) {
                    return /* tuple */[
                            a,
                            b
                          ];
                  }), p)]);
}

function toContainString(b, p) {
  return /* StringContains */Block.__(18, [mapMod((function (a) {
                    return /* tuple */[
                            a,
                            b
                          ];
                  }), p)]);
}

function toEqual(b, p) {
  return /* Equal */Block.__(6, [mapMod((function (a) {
                    return /* tuple */[
                            a,
                            b
                          ];
                  }), p)]);
}

function toHaveLength(l, p) {
  return /* ArrayLength */Block.__(2, [mapMod((function (a) {
                    return /* tuple */[
                            a,
                            l
                          ];
                  }), p)]);
}

function toMatch(s, p) {
  return /* StringMatch */Block.__(19, [mapMod((function (a) {
                    return /* tuple */[
                            a,
                            new RegExp(s)
                          ];
                  }), p)]);
}

function toMatchRe(re, p) {
  return /* StringMatch */Block.__(19, [mapMod((function (a) {
                    return /* tuple */[
                            a,
                            re
                          ];
                  }), p)]);
}

function toMatchSnapshot(param) {
  return /* MatchSnapshot */Block.__(13, [param[1]]);
}

function toMatchSnapshotWithName(name, param) {
  return /* MatchSnapshotName */Block.__(14, [
            param[1],
            name
          ]);
}

function toThrow(f) {
  return /* Throws */Block.__(20, [f]);
}

function toThrowErrorMatchingSnapshot(param) {
  return /* ThrowsMatchSnapshot */Block.__(22, [param[1]]);
}

function toThrowException(e, p) {
  return /* ThrowsException */Block.__(21, [mapMod((function (f) {
                    return /* tuple */[
                            f,
                            e
                          ];
                  }), p)]);
}

function toThrowMessage(message, p) {
  return /* ThrowsMessage */Block.__(23, [mapMod((function (f) {
                    return /* tuple */[
                            f,
                            message
                          ];
                  }), p)]);
}

function toThrowMessageRe(re, p) {
  return /* ThrowsMessageRe */Block.__(24, [mapMod((function (f) {
                    return /* tuple */[
                            f,
                            re
                          ];
                  }), p)]);
}

function not_(param) {
  return /* `Not */[
          3903731,
          param[1]
        ];
}

function $eq$eq(a, b) {
  return toBe(b, a);
}

function $great(a, b) {
  return toBeGreaterThan(b, a);
}

function $great$eq(a, b) {
  return toBeGreaterThanOrEqual(b, a);
}

function $less(a, b) {
  return toBeLessThan(b, a);
}

function $less$eq(a, b) {
  return toBeLessThanOrEqual(b, a);
}

function $eq(a, b) {
  return toEqual(b, a);
}

function $less$great(a, b) {
  return toEqual(b, not_(a));
}

function $bang$eq(a, b) {
  return toBe(b, not_(a));
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
  /* toThrowException */toThrowException,
  /* toThrowMessage */toThrowMessage,
  /* toThrowMessageRe */toThrowMessageRe,
  /* not_ */not_,
  /* Operators */Operators
];

function toBeDefined(a) {
  return /* Defined */Block.__(5, [a]);
}

function toBeFalsy(a) {
  return /* Falsy */Block.__(7, [a]);
}

function toBeNull(a) {
  return /* Null */Block.__(15, [a]);
}

function toBeTruthy(a) {
  return /* Truthy */Block.__(25, [a]);
}

function toBeUndefined(a) {
  return /* Undefined */Block.__(26, [a]);
}

function toContainProperties(props, p) {
  return /* ObjectContains */Block.__(16, [mapMod((function (a) {
                    return /* tuple */[
                            a,
                            props
                          ];
                  }), p)]);
}

function toMatchObject(b, p) {
  return /* ObjectMatch */Block.__(17, [mapMod((function (a) {
                    return /* tuple */[
                            a,
                            b
                          ];
                  }), p)]);
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
    test(name, (function (finish) {
            Curry._1(callback, (function ($$case) {
                    Curry._1(funarg[/* assert_ */0], $$case);
                    return Curry._1(finish, /* () */0);
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
    it.only(name, (function () {
            Curry._1(funarg[/* assert_ */0], Curry._1(callback, /* () */0));
            return undefined;
          }));
    return /* () */0;
  };
  var testAsync$1 = function (name, callback) {
    it.only(name, (function (finish) {
            Curry._1(callback, (function (assertion) {
                    Curry._1(funarg[/* assert_ */0], assertion);
                    return Curry._1(finish, /* () */0);
                  }));
            return undefined;
          }));
    return /* () */0;
  };
  var testPromise$1 = function (name, callback) {
    it.only(name, (function () {
            return Curry._1(callback, /* () */0).then((function (a) {
                          return Promise.resolve(Curry._1(funarg[/* assert_ */0], a));
                        }));
          }));
    return /* () */0;
  };
  var testAll$1 = function (name, inputs, callback) {
    return List.iter((function (input) {
                  var name$1 = "" + (String(name) + (" - " + (String(input) + "")));
                  it.only(name$1, (function () {
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
                it.skip(prim, prim$1, prim$2);
                return /* () */0;
              })]
        ];
}

var pass = /* Ok */0;

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
  toThrowException,
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
