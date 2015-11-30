(function() {
  angular
    .module('app.userView')
    .controller('UserViewController', [
      '$scope',
      'UsersService',
      'CareplansService',
      'IssuesService',
      'GoalsService',
      UserViewController
    ]);

  function UserViewController(
    $scope,
    UsersService,
    CareplansService,
    IssuesService,
    GoalsService
  ) {

    $scope.init = function(id) {
      UsersService.get(
        {
          id: id
        },
        function onSuccess(response) {
          $scope.user = response;
          
          if ($scope.user.role == 'patient') {
            $scope.user.careplan ? newIssue() : createCareplan(id);
          }

          
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
      $scope.user.careplan.newIssue.goals.push({id: $scope.user.careplan.newIssue.goals.length});
    };

    $scope.removeGoal = function(goal) {
      var goals = $scope.user.careplan.newIssue.goals;
      var i = goals.indexOf(goal);
      goals.splice(i, 1);
      for (; i < goals.length; i++) {
        goals[i].id = i;
      }
    };

    $scope.showAddGoal = function(goal) {
      return goal.id == $scope.user.careplan.newIssue.goals.length - 1;
    };

    $scope.onNewIssueSubmit = function(valid) {
      if (valid) {
        $scope.user.careplan.newIssue.careplan_id = $scope.user.careplan.id;
        createIssue(angular.copy($scope.user.careplan.newIssue));
      }
    };

    function createCareplan(id) {
      CareplansService.save(
        {
          careplan: { user_id: id }
        },
        function onSuccess(response) {
          $scope.user.careplan = response;
          $scope.user.careplan.issues = [];
          newIssue();
        },
        function onError(response) {
          console.log('Error', response);
        }
      );
    }

    function createIssue(issue) {
      IssuesService.save(
        { issue },
        function onSuccess(response) {
          response.goals = [];
          $scope.user.careplan.issues.push(response);
          
          $scope.user.careplan.newIssue.goals.forEach(function(goal) {
            goal.issue_id = response.id;
            createGoal(angular.copy(goal));
          });
        },
        function onError(response) {
          console.log('Error', response);
        }
      );
    }

    function createGoal(goal) {
      GoalsService.save(
        { goal },
        function onSuccess(response) {
          var issue = $scope.user.careplan.issues[$scope.user.careplan.issues.length - 1];
          issue.goals.push(response);

          if (issue.goals.length == $scope.user.careplan.newIssue.goals.length) {
            newIssue();
          }
        },
        function onError(response) {
          console.log('Error', response);
        }
      );
    }

    function newIssue() {
      $scope.user.careplan.newIssue = {
        goals: [{ id: 0 }]
      };
    }

  }
})();