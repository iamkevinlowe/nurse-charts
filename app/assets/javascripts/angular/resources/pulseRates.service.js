(function() {
  angular
    .module('app.resources')
    .factory('PulseRatesService', [
      '$resource',
      PulseRatesService
    ]);

  function PulseRatesService($resource) {
    return $resource('/api/pulse_rates/:id');
  }
})();