(function() {
  angular
    .module('app.resources')
    .factory('BloodPressuresService', [
      '$resource',
      BloodPressuresService
    ]);

  function BloodPressuresService($resource) {
    return $resource('/api/blood_pressures/:id');
  }
})();