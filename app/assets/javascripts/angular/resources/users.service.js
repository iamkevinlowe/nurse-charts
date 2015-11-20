(function() {
  angular
    .module('app.resources')
    .factory('UsersService', [
      '$resource',
      UsersService
    ]);

  function UsersService($resource) {
    return $resource('/api/users/:id');
  }
})();