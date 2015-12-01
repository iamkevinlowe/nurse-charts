(function() {
  angular
    .module('app.resources')
    .factory('PatientsFindService', [
      '$resource',
      PatientsFindService
    ]);

  function PatientsFindService($resource) {
    return $resource('/api/patients/find/:id', {},
      {
        'find': { method: 'POST' }
      }
    );
  }
})();