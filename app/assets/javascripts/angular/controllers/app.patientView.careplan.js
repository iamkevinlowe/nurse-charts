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

    $scope.init = function() {
      $scope.$watchGroup(['patient', 'currentUser'], function(newValues, oldValues) {
        if (newValues[0] && newValues[1] && newValues[1].role == 'doctor') {
          $scope.patient.careplan ? newIssue() : createCareplan($scope.patient.id);
        }
      });
    };

    $scope.addGoal = function() {
      $scope.patient.careplan.newIssue.goals.push({id: $scope.patient.careplan.newIssue.goals.length});
    };

    $scope.removeGoal = function(goal) {
      var goals = $scope.patient.careplan.newIssue.goals;
      var i = goals.indexOf(goal);
      goals.splice(i, 1);
      for (; i < goals.length; i++) {
        goals[i].id = i;
      }
    };

    $scope.showAddGoal = function(goal) {
      return goal.id == $scope.patient.careplan.newIssue.goals.length - 1;
    };

    $scope.onNewIssueSubmit = function(valid) {
      if (valid) {
        $scope.patient.careplan.newIssue.careplan_id = $scope.patient.careplan.id;
        createIssue(angular.copy($scope.patient.careplan.newIssue));
      }
    };

    function createCareplan(id) {
      CareplansService.save(
        {
          careplan: { patient_id: id }
        },
        function onSuccess(response) {
          $scope.patient.careplan = response;
          $scope.patient.careplan.issues = [];
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
          
          $scope.patient.careplan.newIssue.goals.forEach(function(goal) {
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

          if (issue.goals.length == $scope.patient.careplan.newIssue.goals.length) {
            newIssue();
          }
        },
        function onError(response) {
          console.log('Error', response);
        }
      );
    }

    function newIssue() {
      $scope.patient.careplan.newIssue = {
        goals: [{ id: 0 }]
      };
    }

  }
})();