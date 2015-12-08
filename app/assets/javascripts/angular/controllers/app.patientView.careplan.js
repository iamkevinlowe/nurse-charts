(function() {
  angular
    .module('app.patientView')
    .controller('PatientViewCareplanController', [
      '$scope',
      'CareplansService',
      'IssuesService',
      'GoalsService',
      PatientViewCareplanController
    ]);

  function PatientViewCareplanController(
    $scope,
    CareplansService,
    IssuesService,
    GoalsService
  ) {

    $scope.newIssue = {};

    $scope.init = function() {
      $scope.$watchGroup(['patient', 'currentUser'], function(newValues, oldValues) {
        if (newValues[0] && newValues[1] && newValues[1].role == 'doctor') {
          $scope.patient.careplan ? newIssue() : createCareplan($scope.patient.id);
        }
      });
    };

    $scope.addGoal = function() {
      $scope.newIssue.goals.push({id: $scope.newIssue.goals.length});
    };

    $scope.removeGoal = function(goal) {
      var goals = $scope.newIssue.goals;
      var i = goals.indexOf(goal);
      goals.splice(i, 1);
      for (; i < goals.length; i++) {
        goals[i].id = i;
      }
    };

    $scope.showAddGoal = function(goal) {
      return goal.id == $scope.newIssue.goals.length - 1;
    };

    $scope.onNewIssueSubmit = function(valid) {
      if (valid) {
        $scope.newIssue.careplan_id = $scope.patient.careplan.id;
        createIssue(angular.copy($scope.newIssue));
      }
    };

    function createCareplan(id) {
      CareplansService.save(
        {
          careplan: { patient_id: id }
        },
        function onSuccess(response) {
          response.issues = [];
          $scope.patient.careplan = response;
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
          $scope.patient.careplan.issues.push(response);
          
          $scope.newIssue.goals.forEach(function(goal) {
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
          var issue = $scope.patient.careplan.issues[$scope.patient.careplan.issues.length - 1];
          issue.goals.push(response);

          if (issue.goals.length == $scope.newIssue.goals.length) {
            newIssue();
          }
        },
        function onError(response) {
          console.log('Error', response);
        }
      );
    }

    function newIssue() {
      $scope.newIssue = {
        goals: [{ id: 0 }]
      };
    }

  }
})();