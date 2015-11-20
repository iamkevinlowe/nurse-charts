(function() {
  angular
    .module('app.utilities')
    .filter('capitalize',
      CapitalizeFilter
    );

  function CapitalizeFilter() {
    return function(input) {
      return input.charAt(0).toUpperCase() + input.slice(1);
    }
  }
})();