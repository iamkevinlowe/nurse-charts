(function() {

  angular
    .module('app.resources')
    .factory('SessionsService', [
      '$resource',
      SessionsService
    ]);

  function SessionsService($resource) {
    return $resource('/users/sign_in/:id');
  }

})();