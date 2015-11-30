(function() {
  angular
    .module('app.resources')
    .factory('CareplansService', [
      '$resource',
      CareplansService
    ]);

  function CareplansService($resource) {
    return $resource('/api/careplans/:id');
  }
})();