'use strict';

var List = require("bs-platform/lib/js/list.js");
var $$Array = require("bs-platform/lib/js/array.js");
var Curry = require("bs-platform/lib/js/curry.js");
var Js_undefined = require("bs-platform/lib/js/js_undefined.js");

function mapMod(f, x) {
  if (x.NAME === "Just") {
    return {
            NAME: "Just",
            VAL: Curry._1(f, x.VAL)
          };
  } else {
    return {
            NAME: "Not",
            VAL: Curry._1(f, x.VAL)
          };
  }
}

var objectContaining = (function (properties) {
      var spec = {};
      properties.forEach(function (property) {
        spec[property] = expect.anything();
      });
      return spec;
    });

function affirm(x) {
  if (typeof x === "number") {
    return ;
  }
  switch (x.TAG | 0) {
    case /* Fail */0 :
        fail(x._0);
        return ;
    case /* ArrayContains */1 :
        var match = x._0;
        if (match.NAME === "Just") {
          var match$1 = match.VAL;
          return expect(match$1[0]).toContain(match$1[1]);
        }
        var match$2 = match.VAL;
        return expect(match$2[0]).not.toContain(match$2[1]);
    case /* ArrayContainsEqual */2 :
        var match$3 = x._0;
        if (match$3.NAME === "Just") {
          var match$4 = match$3.VAL;
          return expect(match$4[0]).toContainEqual(match$4[1]);
        }
        var match$5 = match$3.VAL;
        return expect(match$5[0]).not.toContainEqual(match$5[1]);
    case /* ArrayLength */3 :
        var match$6 = x._0;
        if (match$6.NAME === "Just") {
          var match$7 = match$6.VAL;
          return expect(match$7[0]).toHaveLength(match$7[1]);
        }
        var match$8 = match$6.VAL;
        return expect(match$8[0]).not.toHaveLength(match$8[1]);
    case /* ArraySuperset */4 :
        var match$9 = x._0;
        if (match$9.NAME === "Just") {
          var match$10 = match$9.VAL;
          return expect(match$10[0]).toEqual(expect.arrayContaining(match$10[1]));
        }
        var match$11 = match$9.VAL;
        return expect(match$11[0]).not.toEqual(expect.arrayContaining(match$11[1]));
    case /* Be */5 :
        var match$12 = x._0;
        if (match$12.NAME === "Just") {
          var match$13 = match$12.VAL;
          return expect(match$13[0]).toBe(match$13[1]);
        }
        var match$14 = match$12.VAL;
        return expect(match$14[0]).not.toBe(match$14[1]);
    case /* Equal */6 :
        var match$15 = x._0;
        if (match$15.NAME === "Just") {
          var match$16 = match$15.VAL;
          return expect(match$16[0]).toEqual(match$16[1]);
        }
        var match$17 = match$15.VAL;
        return expect(match$17[0]).not.toEqual(match$17[1]);
    case /* FloatCloseTo */7 :
        var match$18 = x._0;
        if (match$18.NAME === "Just") {
          var match$19 = match$18.VAL;
          return expect(match$19[0]).toBeCloseTo(match$19[1], Js_undefined.fromOption(match$19[2]));
        }
        var match$20 = match$18.VAL;
        return expect(match$20[0]).not.toBeCloseTo(match$20[1], Js_undefined.fromOption(match$20[2]));
    case /* GreaterThan */8 :
        var match$21 = x._0;
        if (match$21.NAME === "Just") {
          var match$22 = match$21.VAL;
          return expect(match$22[0]).toBeGreaterThan(match$22[1]);
        }
        var match$23 = match$21.VAL;
        return expect(match$23[0]).not.toBeGreaterThan(match$23[1]);
    case /* GreaterThanOrEqual */9 :
        var match$24 = x._0;
        if (match$24.NAME === "Just") {
          var match$25 = match$24.VAL;
          return expect(match$25[0]).toBeGreaterThanOrEqual(match$25[1]);
        }
        var match$26 = match$24.VAL;
        return expect(match$26[0]).not.toBeGreaterThanOrEqual(match$26[1]);
    case /* LessThan */10 :
        var match$27 = x._0;
        if (match$27.NAME === "Just") {
          var match$28 = match$27.VAL;
          return expect(match$28[0]).toBeLessThan(match$28[1]);
        }
        var match$29 = match$27.VAL;
        return expect(match$29[0]).not.toBeLessThan(match$29[1]);
    case /* LessThanOrEqual */11 :
        var match$30 = x._0;
        if (match$30.NAME === "Just") {
          var match$31 = match$30.VAL;
          return expect(match$31[0]).toBeLessThanOrEqual(match$31[1]);
        }
        var match$32 = match$30.VAL;
        return expect(match$32[0]).not.toBeLessThanOrEqual(match$32[1]);
    case /* StringContains */12 :
        var match$33 = x._0;
        if (match$33.NAME === "Just") {
          var match$34 = match$33.VAL;
          return expect(match$34[0]).toEqual(expect.stringContaining(match$34[1]));
        }
        var match$35 = match$33.VAL;
        return expect(match$35[0]).not.toEqual(expect.stringContaining(match$35[1]));
    case /* StringMatch */13 :
        var match$36 = x._0;
        if (match$36.NAME === "Just") {
          var match$37 = match$36.VAL;
          return expect(match$37[0]).toMatch(match$37[1]);
        }
        var match$38 = match$36.VAL;
        return expect(match$38[0]).not.toMatch(match$38[1]);
    case /* Throws */14 :
        var match$39 = x._0;
        if (match$39.NAME === "Just") {
          return expect(match$39.VAL).toThrow();
        } else {
          return expect(match$39.VAL).not.toThrow();
        }
    case /* MatchInlineSnapshot */15 :
        return expect(x._0).toMatchInlineSnapshot(x._1);
    case /* MatchSnapshot */16 :
        return expect(x._0).toMatchSnapshot();
    case /* MatchSnapshotName */17 :
        return expect(x._0).toMatchSnapshot(x._1);
    case /* ThrowsMatchSnapshot */18 :
        return expect(x._0).toThrowErrorMatchingSnapshot();
    case /* Defined */19 :
        var match$40 = x._0;
        if (match$40.NAME === "Just") {
          return expect(match$40.VAL).toBeDefined();
        } else {
          return expect(match$40.VAL).not.toBeDefined();
        }
    case /* Falsy */20 :
        var match$41 = x._0;
        if (match$41.NAME === "Just") {
          return expect(match$41.VAL).toBeFalsy();
        } else {
          return expect(match$41.VAL).not.toBeFalsy();
        }
    case /* Null */21 :
        var match$42 = x._0;
        if (match$42.NAME === "Just") {
          return expect(match$42.VAL).toBeNull();
        } else {
          return expect(match$42.VAL).not.toBeNull();
        }
    case /* Truthy */22 :
        var match$43 = x._0;
        if (match$43.NAME === "Just") {
          return expect(match$43.VAL).toBeTruthy();
        } else {
          return expect(match$43.VAL).not.toBeTruthy();
        }
    case /* Undefined */23 :
        var match$44 = x._0;
        if (match$44.NAME === "Just") {
          return expect(match$44.VAL).toBeUndefined();
        } else {
          return expect(match$44.VAL).not.toBeUndefined();
        }
    case /* ObjectContains */24 :
        var match$45 = x._0;
        if (match$45.NAME === "Just") {
          var match$46 = match$45.VAL;
          return expect(match$46[0]).toEqual(objectContaining(match$46[1]));
        }
        var match$47 = match$45.VAL;
        return expect(match$47[0]).not.toEqual(objectContaining(match$47[1]));
    case /* ObjectMatch */25 :
        var match$48 = x._0;
        if (match$48.NAME === "Just") {
          var match$49 = match$48.VAL;
          return expect(match$49[0]).toMatchObject(match$49[1]);
        }
        var match$50 = match$48.VAL;
        return expect(match$50[0]).not.toMatchObject(match$50[1]);
    
  }
}

function test$1(name, callback) {
  test(name, (function () {
          affirm(Curry._1(callback, undefined));
          
        }));
  
}

function testAsync(name, timeout, callback) {
  test(name, (function (finish) {
          Curry._1(callback, (function ($$case) {
                  affirm($$case);
                  return finish();
                }));
          
        }), Js_undefined.fromOption(timeout));
  
}

function testPromise(name, timeout, callback) {
  test(name, (function () {
          return Curry._1(callback, undefined).then(function (a) {
                      return Promise.resolve(affirm(a));
                    });
        }), Js_undefined.fromOption(timeout));
  
}

function testAll(name, inputs, callback) {
  return List.iter((function (input) {
                var name$1 = "" + name + " - " + input;
                test(name$1, (function () {
                        affirm(Curry._1(callback, input));
                        
                      }));
                
              }), inputs);
}

function describe$1(label, f) {
  describe(label, (function () {
          Curry._1(f, undefined);
          
        }));
  
}

function beforeAllAsync(timeout, callback) {
  beforeAll((function (finish) {
          Curry._1(callback, (function (param) {
                  return finish();
                }));
          
        }), Js_undefined.fromOption(timeout));
  
}

function beforeAllPromise(timeout, callback) {
  beforeAll((function () {
          return Promise.resolve(Curry._1(callback, undefined));
        }), Js_undefined.fromOption(timeout));
  
}

function beforeEachAsync(timeout, callback) {
  beforeEach((function (finish) {
          Curry._1(callback, (function (param) {
                  return finish();
                }));
          
        }), Js_undefined.fromOption(timeout));
  
}

function beforeEachPromise(timeout, callback) {
  beforeEach((function () {
          return Promise.resolve(Curry._1(callback, undefined));
        }), Js_undefined.fromOption(timeout));
  
}

function afterAllAsync(timeout, callback) {
  afterAll((function (finish) {
          Curry._1(callback, (function (param) {
                  return finish();
                }));
          
        }), Js_undefined.fromOption(timeout));
  
}

function afterAllPromise(timeout, callback) {
  afterAll((function () {
          return Promise.resolve(Curry._1(callback, undefined));
        }), Js_undefined.fromOption(timeout));
  
}

function afterEachAsync(timeout, callback) {
  afterEach((function (finish) {
          Curry._1(callback, (function (param) {
                  return finish();
                }));
          
        }), Js_undefined.fromOption(timeout));
  
}

function afterEachPromise(timeout, callback) {
  afterEach((function () {
          return Promise.resolve(Curry._1(callback, undefined));
        }), Js_undefined.fromOption(timeout));
  
}

function test$2(name, callback) {
  it.only(name, (function () {
          affirm(Curry._1(callback, undefined));
          
        }));
  
}

function testAsync$1(name, timeout, callback) {
  it.only(name, (function (finish) {
          Curry._1(callback, (function (assertion) {
                  affirm(assertion);
                  return finish();
                }));
          
        }), Js_undefined.fromOption(timeout));
  
}

function testPromise$1(name, timeout, callback) {
  it.only(name, (function () {
          return Curry._1(callback, undefined).then(function (a) {
                      return Promise.resolve(affirm(a));
                    });
        }), Js_undefined.fromOption(timeout));
  
}

function testAll$1(name, inputs, callback) {
  return List.iter((function (input) {
                var name$1 = "" + name + " - " + input;
                it.only(name$1, (function () {
                        affirm(Curry._1(callback, input));
                        
                      }));
                
              }), inputs);
}

function describe$2(label, f) {
  describe.only(label, (function () {
          Curry._1(f, undefined);
          
        }));
  
}

var Only = {
  test: test$2,
  testAsync: testAsync$1,
  testPromise: testPromise$1,
  testAll: testAll$1,
  describe: describe$2
};

function testAsync$2(name, param, callback) {
  it.skip(name, callback);
  
}

function testPromise$2(name, param, callback) {
  it.skip(name, (function () {
          return Curry._1(callback, undefined);
        }));
  
}

function testAll$2(name, inputs, callback) {
  return List.iter((function (input) {
                var name$1 = "" + name + " - " + input;
                it.skip(name$1, (function () {
                        return Curry._1(callback, input);
                      }));
                
              }), inputs);
}

function describe$3(label, f) {
  describe.skip(label, (function () {
          Curry._1(f, undefined);
          
        }));
  
}

function fail$1(message) {
  return {
          TAG: /* Fail */0,
          _0: message
        };
}

function expect$1(a) {
  return {
          NAME: "Just",
          VAL: a
        };
}

function expectFn(f, a) {
  return {
          NAME: "Just",
          VAL: (function (param) {
              return Curry._1(f, a);
            })
        };
}

function toBe(b, p) {
  return {
          TAG: /* Be */5,
          _0: mapMod((function (a) {
                  return [
                          a,
                          b
                        ];
                }), p)
        };
}

function toBeCloseTo(b, p) {
  return {
          TAG: /* FloatCloseTo */7,
          _0: mapMod((function (a) {
                  return [
                          a,
                          b,
                          undefined
                        ];
                }), p)
        };
}

function toBeSoCloseTo(b, digits, p) {
  return {
          TAG: /* FloatCloseTo */7,
          _0: mapMod((function (a) {
                  return [
                          a,
                          b,
                          digits
                        ];
                }), p)
        };
}

function toBeGreaterThan(b, p) {
  return {
          TAG: /* GreaterThan */8,
          _0: mapMod((function (a) {
                  return [
                          a,
                          b
                        ];
                }), p)
        };
}

function toBeGreaterThanOrEqual(b, p) {
  return {
          TAG: /* GreaterThanOrEqual */9,
          _0: mapMod((function (a) {
                  return [
                          a,
                          b
                        ];
                }), p)
        };
}

function toBeLessThan(b, p) {
  return {
          TAG: /* LessThan */10,
          _0: mapMod((function (a) {
                  return [
                          a,
                          b
                        ];
                }), p)
        };
}

function toBeLessThanOrEqual(b, p) {
  return {
          TAG: /* LessThanOrEqual */11,
          _0: mapMod((function (a) {
                  return [
                          a,
                          b
                        ];
                }), p)
        };
}

function toBeSupersetOf(b, p) {
  return {
          TAG: /* ArraySuperset */4,
          _0: mapMod((function (a) {
                  return [
                          a,
                          b
                        ];
                }), p)
        };
}

function toContain(b, p) {
  return {
          TAG: /* ArrayContains */1,
          _0: mapMod((function (a) {
                  return [
                          a,
                          b
                        ];
                }), p)
        };
}

function toContainEqual(b, p) {
  return {
          TAG: /* ArrayContainsEqual */2,
          _0: mapMod((function (a) {
                  return [
                          a,
                          b
                        ];
                }), p)
        };
}

function toContainString(b, p) {
  return {
          TAG: /* StringContains */12,
          _0: mapMod((function (a) {
                  return [
                          a,
                          b
                        ];
                }), p)
        };
}

function toEqual(b, p) {
  return {
          TAG: /* Equal */6,
          _0: mapMod((function (a) {
                  return [
                          a,
                          b
                        ];
                }), p)
        };
}

function toHaveLength(l, p) {
  return {
          TAG: /* ArrayLength */3,
          _0: mapMod((function (a) {
                  return [
                          a,
                          l
                        ];
                }), p)
        };
}

function toMatch(s, p) {
  return {
          TAG: /* StringMatch */13,
          _0: mapMod((function (a) {
                  return [
                          a,
                          new RegExp(s)
                        ];
                }), p)
        };
}

function toMatchInlineSnapshot(inlineSnapshot, param) {
  return {
          TAG: /* MatchInlineSnapshot */15,
          _0: param.VAL,
          _1: inlineSnapshot
        };
}

function toMatchRe(re, p) {
  return {
          TAG: /* StringMatch */13,
          _0: mapMod((function (a) {
                  return [
                          a,
                          re
                        ];
                }), p)
        };
}

function toMatchSnapshot(param) {
  return {
          TAG: /* MatchSnapshot */16,
          _0: param.VAL
        };
}

function toMatchSnapshotWithName(name, param) {
  return {
          TAG: /* MatchSnapshotName */17,
          _0: param.VAL,
          _1: name
        };
}

function toThrow(f) {
  return {
          TAG: /* Throws */14,
          _0: f
        };
}

function toThrowErrorMatchingSnapshot(param) {
  return {
          TAG: /* ThrowsMatchSnapshot */18,
          _0: param.VAL
        };
}

function not_(param) {
  return {
          NAME: "Not",
          VAL: param.VAL
        };
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

var Operators = {
  $eq$eq: $eq$eq,
  $great: $great,
  $great$eq: $great$eq,
  $less: $less,
  $less$eq: $less$eq,
  $eq: $eq,
  $less$great: $less$great,
  $bang$eq: $bang$eq
};

var Expect = {
  expect: expect$1,
  expectFn: expectFn,
  toBe: toBe,
  toBeCloseTo: toBeCloseTo,
  toBeSoCloseTo: toBeSoCloseTo,
  toBeGreaterThan: toBeGreaterThan,
  toBeGreaterThanOrEqual: toBeGreaterThanOrEqual,
  toBeLessThan: toBeLessThan,
  toBeLessThanOrEqual: toBeLessThanOrEqual,
  toBeSupersetOf: toBeSupersetOf,
  toContain: toContain,
  toContainEqual: toContainEqual,
  toContainString: toContainString,
  toEqual: toEqual,
  toHaveLength: toHaveLength,
  toMatch: toMatch,
  toMatchInlineSnapshot: toMatchInlineSnapshot,
  toMatchRe: toMatchRe,
  toMatchSnapshot: toMatchSnapshot,
  toMatchSnapshotWithName: toMatchSnapshotWithName,
  toThrow: toThrow,
  toThrowErrorMatchingSnapshot: toThrowErrorMatchingSnapshot,
  not_: not_,
  not__: not_,
  Operators: Operators
};

function toBeDefined(a) {
  return {
          TAG: /* Defined */19,
          _0: a
        };
}

function toBeFalsy(a) {
  return {
          TAG: /* Falsy */20,
          _0: a
        };
}

function toBeNull(a) {
  return {
          TAG: /* Null */21,
          _0: a
        };
}

function toBeTruthy(a) {
  return {
          TAG: /* Truthy */22,
          _0: a
        };
}

function toBeUndefined(a) {
  return {
          TAG: /* Undefined */23,
          _0: a
        };
}

function toContainProperties(props, p) {
  return {
          TAG: /* ObjectContains */24,
          _0: mapMod((function (a) {
                  return [
                          a,
                          props
                        ];
                }), p)
        };
}

function toMatchObject(b, p) {
  return {
          TAG: /* ObjectMatch */25,
          _0: mapMod((function (a) {
                  return [
                          a,
                          b
                        ];
                }), p)
        };
}

var ExpectJs = {
  expect: expect$1,
  expectFn: expectFn,
  toBe: toBe,
  toBeCloseTo: toBeCloseTo,
  toBeSoCloseTo: toBeSoCloseTo,
  toBeGreaterThan: toBeGreaterThan,
  toBeGreaterThanOrEqual: toBeGreaterThanOrEqual,
  toBeLessThan: toBeLessThan,
  toBeLessThanOrEqual: toBeLessThanOrEqual,
  toBeSupersetOf: toBeSupersetOf,
  toContain: toContain,
  toContainEqual: toContainEqual,
  toContainString: toContainString,
  toEqual: toEqual,
  toHaveLength: toHaveLength,
  toMatch: toMatch,
  toMatchInlineSnapshot: toMatchInlineSnapshot,
  toMatchRe: toMatchRe,
  toMatchSnapshot: toMatchSnapshot,
  toMatchSnapshotWithName: toMatchSnapshotWithName,
  toThrow: toThrow,
  toThrowErrorMatchingSnapshot: toThrowErrorMatchingSnapshot,
  not_: not_,
  not__: not_,
  Operators: Operators,
  toBeDefined: toBeDefined,
  toBeFalsy: toBeFalsy,
  toBeNull: toBeNull,
  toBeTruthy: toBeTruthy,
  toBeUndefined: toBeUndefined,
  toContainProperties: toContainProperties,
  toMatchObject: toMatchObject
};

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
  return $$Array.map((function (args) { return args.length === 1 ? args[0] : args }), self.mock.calls.slice());
}

function instances(self) {
  return self.mock.instances.slice();
}

var MockJs = {
  new0: new0,
  new1: new1,
  new2: new2,
  calls: calls,
  instances: instances
};

var Jest = {};

var JestJs = {};

function Runner(funarg) {
  var affirm = funarg.affirm;
  var test$3 = function (name, callback) {
    test(name, (function () {
            Curry._1(affirm, Curry._1(callback, undefined));
            
          }));
    
  };
  var testAsync = function (name, timeout, callback) {
    test(name, (function (finish) {
            Curry._1(callback, (function ($$case) {
                    Curry._1(affirm, $$case);
                    return finish();
                  }));
            
          }), Js_undefined.fromOption(timeout));
    
  };
  var testPromise = function (name, timeout, callback) {
    test(name, (function () {
            return Curry._1(callback, undefined).then(function (a) {
                        return Promise.resolve(Curry._1(funarg.affirm, a));
                      });
          }), Js_undefined.fromOption(timeout));
    
  };
  var testAll = function (name, inputs, callback) {
    return List.iter((function (input) {
                  var name$1 = "" + name + " - " + input;
                  test(name$1, (function () {
                          Curry._1(affirm, Curry._1(callback, input));
                          
                        }));
                  
                }), inputs);
  };
  var describe$4 = function (label, f) {
    describe(label, (function () {
            Curry._1(f, undefined);
            
          }));
    
  };
  var beforeAllAsync = function (timeout, callback) {
    beforeAll((function (finish) {
            Curry._1(callback, (function (param) {
                    return finish();
                  }));
            
          }), Js_undefined.fromOption(timeout));
    
  };
  var beforeAllPromise = function (timeout, callback) {
    beforeAll((function () {
            return Promise.resolve(Curry._1(callback, undefined));
          }), Js_undefined.fromOption(timeout));
    
  };
  var beforeEachAsync = function (timeout, callback) {
    beforeEach((function (finish) {
            Curry._1(callback, (function (param) {
                    return finish();
                  }));
            
          }), Js_undefined.fromOption(timeout));
    
  };
  var beforeEachPromise = function (timeout, callback) {
    beforeEach((function () {
            return Promise.resolve(Curry._1(callback, undefined));
          }), Js_undefined.fromOption(timeout));
    
  };
  var afterAllAsync = function (timeout, callback) {
    afterAll((function (finish) {
            Curry._1(callback, (function (param) {
                    return finish();
                  }));
            
          }), Js_undefined.fromOption(timeout));
    
  };
  var afterAllPromise = function (timeout, callback) {
    afterAll((function () {
            return Promise.resolve(Curry._1(callback, undefined));
          }), Js_undefined.fromOption(timeout));
    
  };
  var afterEachAsync = function (timeout, callback) {
    afterEach((function (finish) {
            Curry._1(callback, (function (param) {
                    return finish();
                  }));
            
          }), Js_undefined.fromOption(timeout));
    
  };
  var afterEachPromise = function (timeout, callback) {
    afterEach((function () {
            return Promise.resolve(Curry._1(callback, undefined));
          }), Js_undefined.fromOption(timeout));
    
  };
  var test$4 = function (name, callback) {
    it.only(name, (function () {
            Curry._1(affirm, Curry._1(callback, undefined));
            
          }));
    
  };
  var testAsync$1 = function (name, timeout, callback) {
    it.only(name, (function (finish) {
            Curry._1(callback, (function (assertion) {
                    Curry._1(affirm, assertion);
                    return finish();
                  }));
            
          }), Js_undefined.fromOption(timeout));
    
  };
  var testPromise$1 = function (name, timeout, callback) {
    it.only(name, (function () {
            return Curry._1(callback, undefined).then(function (a) {
                        return Promise.resolve(Curry._1(affirm, a));
                      });
          }), Js_undefined.fromOption(timeout));
    
  };
  var testAll$1 = function (name, inputs, callback) {
    return List.iter((function (input) {
                  var name$1 = "" + name + " - " + input;
                  it.only(name$1, (function () {
                          Curry._1(affirm, Curry._1(callback, input));
                          
                        }));
                  
                }), inputs);
  };
  var describe$5 = function (label, f) {
    describe.only(label, (function () {
            Curry._1(f, undefined);
            
          }));
    
  };
  var Only = {
    test: test$4,
    testAsync: testAsync$1,
    testPromise: testPromise$1,
    testAll: testAll$1,
    describe: describe$5
  };
  var testAsync$2 = function (name, param, callback) {
    it.skip(name, callback);
    
  };
  var testPromise$2 = function (name, param, callback) {
    it.skip(name, (function () {
            return Curry._1(callback, undefined);
          }));
    
  };
  var testAll$2 = function (name, inputs, callback) {
    return List.iter((function (input) {
                  var name$1 = "" + name + " - " + input;
                  it.skip(name$1, (function () {
                          return Curry._1(callback, input);
                        }));
                  
                }), inputs);
  };
  var describe$6 = function (label, f) {
    describe.skip(label, (function () {
            Curry._1(f, undefined);
            
          }));
    
  };
  return {
          test: test$3,
          testAsync: testAsync,
          testPromise: testPromise,
          testAll: testAll,
          describe: describe$4,
          beforeAllAsync: beforeAllAsync,
          beforeAllPromise: beforeAllPromise,
          beforeEachAsync: beforeEachAsync,
          beforeEachPromise: beforeEachPromise,
          afterAllAsync: afterAllAsync,
          afterAllPromise: afterAllPromise,
          afterEachAsync: afterEachAsync,
          afterEachPromise: afterEachPromise,
          Only: Only,
          Skip: {
            test: (function (prim, prim$1) {
                it.skip(prim, (function () {
                        return Curry._1(prim$1, undefined);
                      }));
                
              }),
            testAsync: testAsync$2,
            testPromise: testPromise$2,
            testAll: testAll$2,
            describe: describe$6
          }
        };
}

function Skip_test(prim, prim$1) {
  it.skip(prim, (function () {
          return Curry._1(prim$1, undefined);
        }));
  
}

var Skip = {
  test: Skip_test,
  testAsync: testAsync$2,
  testPromise: testPromise$2,
  testAll: testAll$2,
  describe: describe$3
};

var Todo = {
  test: (function (prim) {
      it.todo(prim);
      
    })
};

var pass = /* Ok */0;

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
/*  Not a pure module */
