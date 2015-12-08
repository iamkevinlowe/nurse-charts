(function() {
  angular
    .module('app.resources')
    .factory('RespirationRatesService', [
      '$resource',
      RespirationRatesService
    ]);

  function RespirationRatesService($resource) {
    return $resource('/api/respiration_rates/:id');
  }
})();