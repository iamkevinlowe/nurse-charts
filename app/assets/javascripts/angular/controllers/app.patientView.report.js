(function() {
  angular
    .module('app.patientView')
    .controller('PatientViewReportsController', [
      '$scope',
      'ReportsService',
      PatientViewReportsController
    ]);

  function PatientViewReportsController(
    $scope,
    ReportsService
  ) {

    $scope.init = function() {
      $scope.$watchGroup(['patient.careplan.issues.length', 'currentUser'], function(newValues, oldValues) {
        if (newValues[0] && newValues[1]) {
          $scope.patient.reports.forEach(function(report) {
            report = addAssociations(report);
          });

          resetNewReport();
        }
      });
    };

    $scope.onNewReportSubmit = function(valid) {
      if (valid) {
        ReportsService.save(
          { report: $scope.patient.newReport },
          function onSuccess(response) {
            $scope.patient.reports.unshift(addAssociations(response));

            resetNewReport();
          },
          function onError(response) {
            console.log('Error', response);
          }
        );
      }
    };

    function addAssociations(report) {
      $scope.patient.careplan.issues.some(function(issue) {
        if (issue.id == report.issue_id) {
          report.issue = issue;
          return true;
        }
      });

      $scope.users.some(function(user) {
        if (user.id == report.user_id) {
          report.user = user;
          return true;
        }
      });

      return report;
    }

    function resetNewReport() {
      $scope.patient.newReport = {
        patient_id: $scope.patient.id,
        user_id: $scope.currentUser.id,
        issue_id: $scope.patient.careplan.issues[0].id,
        alert: null,
        notes: null
      };
    }

  }
})();