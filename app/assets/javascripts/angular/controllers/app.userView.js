(function() {
  angular
    .module('app.userView')
    .controller('UserViewController', [
      '$scope',
      'UsersService',
      UserViewController
    ]);

  function UserViewController(
    $scope,
    UsersService
  ) {

    $scope.init = function(id) {
      UsersService.get(
        {
          id: id
        },
        function onSuccess(response) {
          $scope.user = response;
        },
        function onError(response) {
          console.log('Error', response);
        }
      );
    };

  }
})();