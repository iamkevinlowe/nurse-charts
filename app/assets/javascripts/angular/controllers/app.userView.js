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
      $scope.userId = id;
      UsersService.get(
        {
          id: id
        },
        function onSuccess(response) {
          $scope.user = response;

          $scope.onTabClick('careplan');
        }, function onError(response) {
          console.log('Error', response);
        }
      );
    };

    $scope.onTabClick = function(tab, e) {
      if (e) { e.preventDefault(); }

      $scope.isCareplanTabActive = false;
      $scope.isReportTabActive = false;
      $scope.isHistoryTabActive = false;
      $scope.isVitalsTabActive = false;

      switch (tab) {
        case 'careplan':
          $scope.isCareplanTabActive = true;
          break;
        case 'report':
          $scope.isReportTabActive = true;
          break;
        case 'history':
          $scope.isHistoryTabActive = true;
          break;
        case 'vitals':
          $scope.isVitalsTabActive = true;
          break;
        default:
          console.log('Tab click out of bounds.');
      }
    };

  }
})();