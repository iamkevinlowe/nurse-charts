(function() {
  angular
    .module('app.resources')
    .factory('ReportsService', [
      '$resource',
      ReportsService
    ]);

  function ReportsService($resource) {
    return $resource('/api/reports/:id');
  }
})();