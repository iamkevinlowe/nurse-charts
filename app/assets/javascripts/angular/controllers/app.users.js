(function() {

  angular
    .module('app.users')
    .controller('UsersController', [
      '$scope',
      'UsersService',
      UsersController
    ]);

  function UsersController($scope, UsersService) {

    $scope.init = function() {
      UsersService.query(
        {},
        function onSuccess(response) {
          console.log(response);
          $scope.users = response;
        }, function onError(response) {
          console.log(response);
        }
      );
    }

  }

})();