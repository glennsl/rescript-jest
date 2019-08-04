'use strict';

var List = require("bs-platform/lib/js/list.js");
var $$Array = require("bs-platform/lib/js/array.js");
var Block = require("bs-platform/lib/js/block.js");
var Curry = require("bs-platform/lib/js/curry.js");
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

function affirm(param) {
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
      case 2 : 
          var match$3 = param[0];
          if (match$3[0] >= 826472012) {
            var match$4 = match$3[1];
            return expect(match$4[0]).toHaveLength(match$4[1]);
          } else {
            var match$5 = match$3[1];
            return expect(match$5[0]).not.toHaveLength(match$5[1]);
          }
      case 3 : 
          var match$6 = param[0];
          if (match$6[0] >= 826472012) {
            var match$7 = match$6[1];
            return expect(match$7[0]).toEqual(expect.arrayContaining(match$7[1]));
          } else {
            var match$8 = match$6[1];
            return expect(match$8[0]).not.toEqual(expect.arrayContaining(match$8[1]));
          }
      case 4 : 
          var match$9 = param[0];
          if (match$9[0] >= 826472012) {
            var match$10 = match$9[1];
            return expect(match$10[0]).toBe(match$10[1]);
          } else {
            var match$11 = match$9[1];
            return expect(match$11[0]).not.toBe(match$11[1]);
          }
      case 5 : 
          var match$12 = param[0];
          if (match$12[0] >= 826472012) {
            var match$13 = match$12[1];
            return expect(match$13[0]).toEqual(match$13[1]);
          } else {
            var match$14 = match$12[1];
            return expect(match$14[0]).not.toEqual(match$14[1]);
          }
      case 6 : 
          var match$15 = param[0];
          if (match$15[0] >= 826472012) {
            var match$16 = match$15[1];
            return expect(match$16[0]).toBeCloseTo(match$16[1], Js_undefined.fromOption(match$16[2]));
          } else {
            var match$17 = match$15[1];
            return expect(match$17[0]).not.toBeCloseTo(match$17[1], Js_undefined.fromOption(match$17[2]));
          }
      case 7 : 
          var match$18 = param[0];
          if (match$18[0] >= 826472012) {
            var match$19 = match$18[1];
            return expect(match$19[0]).toBeGreaterThan(match$19[1]);
          } else {
            var match$20 = match$18[1];
            return expect(match$20[0]).not.toBeGreaterThan(match$20[1]);
          }
      case 8 : 
          var match$21 = param[0];
          if (match$21[0] >= 826472012) {
            var match$22 = match$21[1];
            return expect(match$22[0]).toBeGreaterThanOrEqual(match$22[1]);
          } else {
            var match$23 = match$21[1];
            return expect(match$23[0]).not.toBeGreaterThanOrEqual(match$23[1]);
          }
      case 9 : 
          var match$24 = param[0];
          if (match$24[0] >= 826472012) {
            var match$25 = match$24[1];
            return expect(match$25[0]).toBeLessThan(match$25[1]);
          } else {
            var match$26 = match$24[1];
            return expect(match$26[0]).not.toBeLessThan(match$26[1]);
          }
      case 10 : 
          var match$27 = param[0];
          if (match$27[0] >= 826472012) {
            var match$28 = match$27[1];
            return expect(match$28[0]).toBeLessThanOrEqual(match$28[1]);
          } else {
            var match$29 = match$27[1];
            return expect(match$29[0]).not.toBeLessThanOrEqual(match$29[1]);
          }
      case 11 : 
          var match$30 = param[0];
          if (match$30[0] >= 826472012) {
            var match$31 = match$30[1];
            return expect(match$31[0]).toEqual(expect.stringContaining(match$31[1]));
          } else {
            var match$32 = match$30[1];
            return expect(match$32[0]).not.toEqual(expect.stringContaining(match$32[1]));
          }
      case 12 : 
          var match$33 = param[0];
          if (match$33[0] >= 826472012) {
            var match$34 = match$33[1];
            return expect(match$34[0]).toMatch(match$34[1]);
          } else {
            var match$35 = match$33[1];
            return expect(match$35[0]).not.toMatch(match$35[1]);
          }
      case 13 : 
          var match$36 = param[0];
          if (match$36[0] >= 826472012) {
            return expect(match$36[1]).toThrow();
          } else {
            return expect(match$36[1]).not.toThrow();
          }
      case 14 : 
          var match$37 = param[0];
          if (match$37[0] >= 826472012) {
            var match$38 = match$37[1];
            return expect(match$38[0]).toThrow(String(match$38[1]));
          } else {
            var match$39 = match$37[1];
            return expect(match$39[0]).not.toThrow(String(match$39[1]));
          }
      case 15 : 
          var match$40 = param[0];
          if (match$40[0] >= 826472012) {
            var match$41 = match$40[1];
            return expect(match$41[0]).toThrow(match$41[1]);
          } else {
            var match$42 = match$40[1];
            return expect(match$42[0]).not.toThrow(match$42[1]);
          }
      case 16 : 
          var match$43 = param[0];
          if (match$43[0] >= 826472012) {
            var match$44 = match$43[1];
            return expect(match$44[0]).toThrow(match$44[1]);
          } else {
            var match$45 = match$43[1];
            return expect(match$45[0]).not.toThrow(match$45[1]);
          }
      case 17 : 
          return expect(param[0]).toMatchSnapshot();
      case 18 : 
          return expect(param[0]).toMatchSnapshot(param[1]);
      case 19 : 
          return expect(param[0]).toThrowErrorMatchingSnapshot();
      case 20 : 
          var match$46 = param[0];
          if (match$46[0] >= 826472012) {
            return expect(match$46[1]).toBeDefined();
          } else {
            return expect(match$46[1]).not.toBeDefined();
          }
      case 21 : 
          var match$47 = param[0];
          if (match$47[0] >= 826472012) {
            return expect(match$47[1]).toBeFalsy();
          } else {
            return expect(match$47[1]).not.toBeFalsy();
          }
      case 22 : 
          var match$48 = param[0];
          if (match$48[0] >= 826472012) {
            return expect(match$48[1]).toBeNull();
          } else {
            return expect(match$48[1]).not.toBeNull();
          }
      case 23 : 
          var match$49 = param[0];
          if (match$49[0] >= 826472012) {
            return expect(match$49[1]).toBeTruthy();
          } else {
            return expect(match$49[1]).not.toBeTruthy();
          }
      case 24 : 
          var match$50 = param[0];
          if (match$50[0] >= 826472012) {
            return expect(match$50[1]).toBeUndefined();
          } else {
            return expect(match$50[1]).not.toBeUndefined();
          }
      case 25 : 
          var match$51 = param[0];
          if (match$51[0] >= 826472012) {
            var match$52 = match$51[1];
            return expect(match$52[0]).toEqual(Curry._1(objectContaining, match$52[1]));
          } else {
            var match$53 = match$51[1];
            return expect(match$53[0]).not.toEqual(Curry._1(objectContaining, match$53[1]));
          }
      case 26 : 
          var match$54 = param[0];
          if (match$54[0] >= 826472012) {
            var match$55 = match$54[1];
            return expect(match$55[0]).toMatchObject(match$55[1]);
          } else {
            var match$56 = match$54[1];
            return expect(match$56[0]).not.toMatchObject(match$56[1]);
          }
      
    }
  }
}

function test$1(name, callback) {
  test(name, (function () {
          affirm(Curry._1(callback, /* () */0));
          return undefined;
        }));
  return /* () */0;
}

function testAsync(name, timeout, callback) {
  test(name, (function (finish) {
          Curry._1(callback, (function ($$case) {
                  affirm($$case);
                  return finish();
                }));
          return undefined;
        }), Js_undefined.fromOption(timeout));
  return /* () */0;
}

function testPromise(name, timeout, callback) {
  test(name, (function () {
          return Curry._1(callback, /* () */0).then((function (a) {
                        return Promise.resolve(affirm(a));
                      }));
        }), Js_undefined.fromOption(timeout));
  return /* () */0;
}

function testAll(name, inputs, callback) {
  return List.iter((function (input) {
                var name$1 = "" + (String(name) + (" - " + (String(input) + "")));
                test(name$1, (function () {
                        affirm(Curry._1(callback, input));
                        return undefined;
                      }));
                return /* () */0;
              }), inputs);
}

function describe$1(label, f) {
  describe(label, (function () {
          Curry._1(f, /* () */0);
          return undefined;
        }));
  return /* () */0;
}

function beforeAllAsync(timeout, callback) {
  beforeAll((function (finish) {
          Curry._1(callback, (function (param) {
                  return finish();
                }));
          return undefined;
        }), Js_undefined.fromOption(timeout));
  return /* () */0;
}

function beforeAllPromise(timeout, callback) {
  beforeAll((function () {
          return Promise.resolve(Curry._1(callback, /* () */0));
        }), Js_undefined.fromOption(timeout));
  return /* () */0;
}

function beforeEachAsync(timeout, callback) {
  beforeEach((function (finish) {
          Curry._1(callback, (function (param) {
                  return finish();
                }));
          return undefined;
        }), Js_undefined.fromOption(timeout));
  return /* () */0;
}

function beforeEachPromise(timeout, callback) {
  beforeEach((function () {
          return Promise.resolve(Curry._1(callback, /* () */0));
        }), Js_undefined.fromOption(timeout));
  return /* () */0;
}

function afterAllAsync(timeout, callback) {
  afterAll((function (finish) {
          Curry._1(callback, (function (param) {
                  return finish();
                }));
          return undefined;
        }), Js_undefined.fromOption(timeout));
  return /* () */0;
}

function afterAllPromise(timeout, callback) {
  afterAll((function () {
          return Promise.resolve(Curry._1(callback, /* () */0));
        }), Js_undefined.fromOption(timeout));
  return /* () */0;
}

function afterEachAsync(timeout, callback) {
  afterEach((function (finish) {
          Curry._1(callback, (function (param) {
                  return finish();
                }));
          return undefined;
        }), Js_undefined.fromOption(timeout));
  return /* () */0;
}

function afterEachPromise(timeout, callback) {
  afterEach((function () {
          return Promise.resolve(Curry._1(callback, /* () */0));
        }), Js_undefined.fromOption(timeout));
  return /* () */0;
}

function test$2(name, callback) {
  it.only(name, (function () {
          affirm(Curry._1(callback, /* () */0));
          return undefined;
        }));
  return /* () */0;
}

function testAsync$1(name, timeout, callback) {
  it.only(name, (function (finish) {
          Curry._1(callback, (function (assertion) {
                  affirm(assertion);
                  return finish();
                }));
          return undefined;
        }), Js_undefined.fromOption(timeout));
  return /* () */0;
}

function testPromise$1(name, timeout, callback) {
  it.only(name, (function () {
          return Curry._1(callback, /* () */0).then((function (a) {
                        return Promise.resolve(affirm(a));
                      }));
        }), Js_undefined.fromOption(timeout));
  return /* () */0;
}

function testAll$1(name, inputs, callback) {
  return List.iter((function (input) {
                var name$1 = "" + (String(name) + (" - " + (String(input) + "")));
                it.only(name$1, (function () {
                        affirm(Curry._1(callback, input));
                        return undefined;
                      }));
                return /* () */0;
              }), inputs);
}

function describe$2(label, f) {
  describe.only(label, (function () {
          Curry._1(f, /* () */0);
          return undefined;
        }));
  return /* () */0;
}

var Only = /* module */[
  /* test */test$2,
  /* testAsync */testAsync$1,
  /* testPromise */testPromise$1,
  /* testAll */testAll$1,
  /* describe */describe$2
];

function testAsync$2(name, param, callback) {
  it.skip(name, callback);
  return /* () */0;
}

function testPromise$2(name, param, callback) {
  it.skip(name, (function () {
          return Curry._1(callback, /* () */0);
        }));
  return /* () */0;
}

function testAll$2(name, inputs, callback) {
  return List.iter((function (input) {
                var name$1 = "" + (String(name) + (" - " + (String(input) + "")));
                it.skip(name$1, (function () {
                        return Curry._1(callback, input);
                      }));
                return /* () */0;
              }), inputs);
}

function describe$3(label, f) {
  describe.skip(label, (function () {
          Curry._1(f, /* () */0);
          return undefined;
        }));
  return /* () */0;
}

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
          (function (param) {
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
  return /* FloatCloseTo */Block.__(6, [mapMod((function (a) {
                    return /* tuple */[
                            a,
                            b,
                            undefined
                          ];
                  }), p)]);
}

function toBeSoCloseTo(b, digits, p) {
  return /* FloatCloseTo */Block.__(6, [mapMod((function (a) {
                    return /* tuple */[
                            a,
                            b,
                            digits
                          ];
                  }), p)]);
}

function toBeGreaterThan(b, p) {
  return /* GreaterThan */Block.__(7, [mapMod((function (a) {
                    return /* tuple */[
                            a,
                            b
                          ];
                  }), p)]);
}

function toBeGreaterThanOrEqual(b, p) {
  return /* GreaterThanOrEqual */Block.__(8, [mapMod((function (a) {
                    return /* tuple */[
                            a,
                            b
                          ];
                  }), p)]);
}

function toBeLessThan(b, p) {
  return /* LessThan */Block.__(9, [mapMod((function (a) {
                    return /* tuple */[
                            a,
                            b
                          ];
                  }), p)]);
}

function toBeLessThanOrEqual(b, p) {
  return /* LessThanOrEqual */Block.__(10, [mapMod((function (a) {
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
  return /* StringContains */Block.__(11, [mapMod((function (a) {
                    return /* tuple */[
                            a,
                            b
                          ];
                  }), p)]);
}

function toEqual(b, p) {
  return /* Equal */Block.__(5, [mapMod((function (a) {
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
  return /* StringMatch */Block.__(12, [mapMod((function (a) {
                    return /* tuple */[
                            a,
                            new RegExp(s)
                          ];
                  }), p)]);
}

function toMatchRe(re, p) {
  return /* StringMatch */Block.__(12, [mapMod((function (a) {
                    return /* tuple */[
                            a,
                            re
                          ];
                  }), p)]);
}

function toMatchSnapshot(param) {
  return /* MatchSnapshot */Block.__(17, [param[1]]);
}

function toMatchSnapshotWithName(name, param) {
  return /* MatchSnapshotName */Block.__(18, [
            param[1],
            name
          ]);
}

function toThrow(f) {
  return /* Throws */Block.__(13, [f]);
}

function toThrowErrorMatchingSnapshot(param) {
  return /* ThrowsMatchSnapshot */Block.__(19, [param[1]]);
}

function toThrowException(e, p) {
  return /* ThrowsException */Block.__(14, [mapMod((function (f) {
                    return /* tuple */[
                            f,
                            e
                          ];
                  }), p)]);
}

function toThrowMessage(message, p) {
  return /* ThrowsMessage */Block.__(15, [mapMod((function (f) {
                    return /* tuple */[
                            f,
                            message
                          ];
                  }), p)]);
}

function toThrowMessageRe(re, p) {
  return /* ThrowsMessageRe */Block.__(16, [mapMod((function (f) {
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
  /* not__ */not_,
  /* Operators */Operators
];

function toBeDefined(a) {
  return /* Defined */Block.__(20, [a]);
}

function toBeFalsy(a) {
  return /* Falsy */Block.__(21, [a]);
}

function toBeNull(a) {
  return /* Null */Block.__(22, [a]);
}

function toBeTruthy(a) {
  return /* Truthy */Block.__(23, [a]);
}

function toBeUndefined(a) {
  return /* Undefined */Block.__(24, [a]);
}

function toContainProperties(props, p) {
  return /* ObjectContains */Block.__(25, [mapMod((function (a) {
                    return /* tuple */[
                            a,
                            props
                          ];
                  }), p)]);
}

function toMatchObject(b, p) {
  return /* ObjectMatch */Block.__(26, [mapMod((function (a) {
                    return /* tuple */[
                            a,
                            b
                          ];
                  }), p)]);
}


    function makeNewMock(self) {
      return new (Function.prototype.bind.apply(self, arguments));
    }
  
;

function new0(prim) {
  return makeNewMock(prim);
}

function new1(a, self) {
  return makeNewMock(self, a);
}

function new2(a, b, self) {
  return makeNewMock(self, a, b);
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
  /* new0 */new0,
  /* new1 */new1,
  /* new2 */new2,
  /* calls */calls,
  /* instances */instances
];

var Jest = /* module */[];

var JestJs = /* module */[];

function Runner(funarg) {
  var affirm = funarg[/* affirm */0];
  var test$3 = function (name, callback) {
    test(name, (function () {
            Curry._1(affirm, Curry._1(callback, /* () */0));
            return undefined;
          }));
    return /* () */0;
  };
  var testAsync = function (name, timeout, callback) {
    test(name, (function (finish) {
            Curry._1(callback, (function ($$case) {
                    Curry._1(affirm, $$case);
                    return finish();
                  }));
            return undefined;
          }), Js_undefined.fromOption(timeout));
    return /* () */0;
  };
  var testPromise = function (name, timeout, callback) {
    test(name, (function () {
            return Curry._1(callback, /* () */0).then((function (a) {
                          return Promise.resolve(Curry._1(funarg[/* affirm */0], a));
                        }));
          }), Js_undefined.fromOption(timeout));
    return /* () */0;
  };
  var testAll = function (name, inputs, callback) {
    return List.iter((function (input) {
                  var name$1 = "" + (String(name) + (" - " + (String(input) + "")));
                  test(name$1, (function () {
                          Curry._1(affirm, Curry._1(callback, input));
                          return undefined;
                        }));
                  return /* () */0;
                }), inputs);
  };
  var describe$4 = function (label, f) {
    describe(label, (function () {
            Curry._1(f, /* () */0);
            return undefined;
          }));
    return /* () */0;
  };
  var beforeAllAsync = function (timeout, callback) {
    beforeAll((function (finish) {
            Curry._1(callback, (function (param) {
                    return finish();
                  }));
            return undefined;
          }), Js_undefined.fromOption(timeout));
    return /* () */0;
  };
  var beforeAllPromise = function (timeout, callback) {
    beforeAll((function () {
            return Promise.resolve(Curry._1(callback, /* () */0));
          }), Js_undefined.fromOption(timeout));
    return /* () */0;
  };
  var beforeEachAsync = function (timeout, callback) {
    beforeEach((function (finish) {
            Curry._1(callback, (function (param) {
                    return finish();
                  }));
            return undefined;
          }), Js_undefined.fromOption(timeout));
    return /* () */0;
  };
  var beforeEachPromise = function (timeout, callback) {
    beforeEach((function () {
            return Promise.resolve(Curry._1(callback, /* () */0));
          }), Js_undefined.fromOption(timeout));
    return /* () */0;
  };
  var afterAllAsync = function (timeout, callback) {
    afterAll((function (finish) {
            Curry._1(callback, (function (param) {
                    return finish();
                  }));
            return undefined;
          }), Js_undefined.fromOption(timeout));
    return /* () */0;
  };
  var afterAllPromise = function (timeout, callback) {
    afterAll((function () {
            return Promise.resolve(Curry._1(callback, /* () */0));
          }), Js_undefined.fromOption(timeout));
    return /* () */0;
  };
  var afterEachAsync = function (timeout, callback) {
    afterEach((function (finish) {
            Curry._1(callback, (function (param) {
                    return finish();
                  }));
            return undefined;
          }), Js_undefined.fromOption(timeout));
    return /* () */0;
  };
  var afterEachPromise = function (timeout, callback) {
    afterEach((function () {
            return Promise.resolve(Curry._1(callback, /* () */0));
          }), Js_undefined.fromOption(timeout));
    return /* () */0;
  };
  var test$4 = function (name, callback) {
    it.only(name, (function () {
            Curry._1(affirm, Curry._1(callback, /* () */0));
            return undefined;
          }));
    return /* () */0;
  };
  var testAsync$1 = function (name, timeout, callback) {
    it.only(name, (function (finish) {
            Curry._1(callback, (function (assertion) {
                    Curry._1(affirm, assertion);
                    return finish();
                  }));
            return undefined;
          }), Js_undefined.fromOption(timeout));
    return /* () */0;
  };
  var testPromise$1 = function (name, timeout, callback) {
    it.only(name, (function () {
            return Curry._1(callback, /* () */0).then((function (a) {
                          return Promise.resolve(Curry._1(affirm, a));
                        }));
          }), Js_undefined.fromOption(timeout));
    return /* () */0;
  };
  var testAll$1 = function (name, inputs, callback) {
    return List.iter((function (input) {
                  var name$1 = "" + (String(name) + (" - " + (String(input) + "")));
                  it.only(name$1, (function () {
                          Curry._1(affirm, Curry._1(callback, input));
                          return undefined;
                        }));
                  return /* () */0;
                }), inputs);
  };
  var describe$5 = function (label, f) {
    describe.only(label, (function () {
            Curry._1(f, /* () */0);
            return undefined;
          }));
    return /* () */0;
  };
  var Only = /* module */[
    /* test */test$4,
    /* testAsync */testAsync$1,
    /* testPromise */testPromise$1,
    /* testAll */testAll$1,
    /* describe */describe$5
  ];
  var testAsync$2 = function (name, param, callback) {
    it.skip(name, callback);
    return /* () */0;
  };
  var testPromise$2 = function (name, param, callback) {
    it.skip(name, (function () {
            return Curry._1(callback, /* () */0);
          }));
    return /* () */0;
  };
  var testAll$2 = function (name, inputs, callback) {
    return List.iter((function (input) {
                  var name$1 = "" + (String(name) + (" - " + (String(input) + "")));
                  it.skip(name$1, (function () {
                          return Curry._1(callback, input);
                        }));
                  return /* () */0;
                }), inputs);
  };
  var describe$6 = function (label, f) {
    describe.skip(label, (function () {
            Curry._1(f, /* () */0);
            return undefined;
          }));
    return /* () */0;
  };
  return [
          test$3,
          testAsync,
          testPromise,
          testAll,
          describe$4,
          beforeAllAsync,
          beforeAllPromise,
          beforeEachAsync,
          beforeEachPromise,
          afterAllAsync,
          afterAllPromise,
          afterEachAsync,
          afterEachPromise,
          Only,
          [
            (function (prim, prim$1) {
                it.skip(prim, (function () {
                        return Curry._1(prim$1, /* () */0);
                      }));
                return /* () */0;
              }),
            testAsync$2,
            testPromise$2,
            testAll$2,
            describe$6
          ]
        ];
}

function Skip_000(prim, prim$1) {
  it.skip(prim, (function () {
          return Curry._1(prim$1, /* () */0);
        }));
  return /* () */0;
}

var Skip = [
  Skip_000,
  testAsync$2,
  testPromise$2,
  testAll$2,
  describe$3
];

var Todo = [(function (prim) {
      it.todo(prim);
      return /* () */0;
    })];

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

exports.Runner = Runner;
exports.test = test$1;
exports.testAsync = testAsync;
exports.testPromise = testPromise;
exports.testAll = testAll;
exports.describe = describe$1;
exports.beforeAllAsync = beforeAllAsync;
exports.beforeAllPromise = beforeAllPromise;
exports.beforeEachAsync = beforeEachAsync;
exports.beforeEachPromise = beforeEachPromise;
exports.afterAllAsync = afterAllAsync;
exports.afterAllPromise = afterAllPromise;
exports.afterEachAsync = afterEachAsync;
exports.afterEachPromise = afterEachPromise;
exports.Only = Only;
exports.Skip = Skip;
exports.Todo = Todo;
exports.pass = pass;
exports.fail = fail$1;
exports.Expect = Expect;
exports.ExpectJs = ExpectJs;
exports.MockJs = MockJs;
exports.Jest = Jest;
exports.JestJs = JestJs;
/* objectContaining Not a pure module */
