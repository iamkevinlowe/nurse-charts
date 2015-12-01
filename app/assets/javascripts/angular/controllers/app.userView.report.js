(function() {
  angular
    .module('app.userView')
    .controller('UserViewReportsController', [
      '$scope',
      ReportsService
    ]);

  function ReportsService(
    $scope,
    ReportsService
  ) {

    $scope.newReport = {};

    $scope.init = function() {
      $scope.newReport = {
        issue_id: $scope.user.careplan.issues[0].id
      };
    };

    $scope.onNewReportSubmit = function(valid) {
      if (valid) {

      }
    };

  }
})();