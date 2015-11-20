(function() {
  angular
    .module('app.resources')
    .factory('HospitalsService', [
      '$resource',
      HospitalsService
    ]);

  function HospitalsService($resource) {
    return $resource('/api/hospitals/:id',
      {
        id: '@id'
      }
    );
  }
})();