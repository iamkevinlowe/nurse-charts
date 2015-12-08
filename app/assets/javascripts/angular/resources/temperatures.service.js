(function() {
  angular
    .module('app.resources')
    .factory('TemperaturesService', [
      '$resource',
      TemperaturesService
    ]);

  function TemperaturesService($resource) {
    return $resource('/api/temperatures/:id');
  }
})();