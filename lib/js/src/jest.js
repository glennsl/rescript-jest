'use strict';


((
    function (properties) {
      var spec = {};
      properties.forEach(function (property) {
        spec[property] = expect.anything();
      });
      return spec;
    }
  ));

/*  Not a pure module */
