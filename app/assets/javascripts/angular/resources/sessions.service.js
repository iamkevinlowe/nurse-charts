(function() {
  angular
    .module('app.resources')
    .factory('SessionsService', [
      '$resource',
      SessionsService
    ]);

  function SessionsService($resource) {
    return $resource('/session/:id');
  }
})();