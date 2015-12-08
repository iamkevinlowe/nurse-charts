(function() {
  angular
    .module('app.resources')
    .factory('VitalsService', [
      '$resource',
      VitalsService
    ]);

  function VitalsService($resource) {
    return $resource('/api/vitals/:id');
  }
})();