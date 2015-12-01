(function() {
  angular
    .module('app.resources')
    .factory('PatientsService', [
      '$resource',
      PatientsService
    ]);

  function PatientsService($resource) {
    return $resource('/api/patients/:id');
  }
})();