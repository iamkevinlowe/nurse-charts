(function() {
  angular
    .module('app.userView')
    .controller('UserViewController', [
      '$scope',
      'UsersService',
      UserViewController
    ]);

  function UserViewController($scope, UsersService) {

    $scope.issues = [];

    $scope.init = function(id) {
      UsersService.get(
        {
          id: id
        },
        function onSuccess(response) {
          $scope.user = response;
          newCarePlan();
          $scope.onTabClick('careplan');
        }, function onError(response) {
          console.log('error', response);
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

    $scope.addGoal = function() {
      $scope.careplan.newIssue.goals.push({id: $scope.careplan.newIssue.goals.length});
    };

    $scope.removeGoal = function(goal) {
      var goals = $scope.careplan.newIssue.goals;
      var i = goals.indexOf(goal);
      goals.splice(i, 1);
      for (; i < goals.length; i++) {
        goals[i].id = i;
      }
    };

    $scope.showAddGoal = function(goal) {
      return goal.id == $scope.careplan.newIssue.goals.length - 1;
    }

    $scope.onNewIssueSubmit = function(valid) {
      if (valid) {
        $scope.issues.push($scope.careplan.newIssue);
        newCarePlan();
      }
    };

    function newCarePlan() {
      $scope.careplan = {
        newIssue: {
          goals: [
            {
              id: 0
            }
          ]
        }
      };
    }

  }
})();