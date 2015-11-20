(function() {
  angular
    .module('app.navigation')
    .controller('NavigationController', [
      '$scope',
      '$window',
      'SessionsService',
      NavigationController
    ]);

  function NavigationController($scope, $window, SessionsService) {

    $scope.onRootClick = function(e) {
      if (e) { e.preventDefault(); }

      $window.location.href = "/";
    };

    $scope.onSignOutClick = function(e) {
      if (e) { e.preventDefault(); }

      SessionsService.delete(
        {},
        function onSuccess() {
          $window.location.reload();
        }
      );
    };

  }
})();