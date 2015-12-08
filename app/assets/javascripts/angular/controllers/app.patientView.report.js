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

    $scope.newReport = {};

    $scope.init = function() {
      $scope.$watchGroup(['patient.careplan.issues.length', 'currentUser'], function(newValues, oldValues) {
        if (newValues[0] && newValues[1]) {
          $scope.patient.reports.forEach(function(report) {
            report = addAssociations(report);
          });

          newReport();
        }
      });
    };

    $scope.onNewReportSubmit = function(valid) {
      if (valid) {
        ReportsService.save(
          {
            report: $scope.newReport
          },
          function onSuccess(response) {
            $scope.patient.reports.unshift(addAssociations(response));

            newReport();
          },
          function onError(response) {
            console.log('Error', response);
          }
        );
      }
    };

    function addAssociations(report) {
      if (report.activity_type == 'Issue') {
        $scope.patient.careplan.issues.some(function(issue) {
          if (issue.id == report.activity_id) {
            report.activity = issue;
            return true;
          }
        });
      } else if (report.activity_type == 'Vital') {
        report.activity = { name: 'Vitals Reading' };
      }
      

      $scope.users.some(function(user) {
        if (user.id == report.user_id) {
          report.user = user;
          return true;
        }
      });

      return report;
    }

    function newReport() {
      $scope.newReport = {
        patient_id: $scope.patient.id,
        user_id: $scope.currentUser.id,
        activity_id: $scope.patient.careplan.issues[0].id,
        activity_type: 'Issue',
        alert: null,
        notes: null
      };
    }

  }
})();