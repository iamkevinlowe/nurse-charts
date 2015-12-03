(function() {
  angular
    .module('app.patientView')
    .controller('PatientViewVitalsController', [
      '$scope',
      PatientViewVitalsController
    ]);

  function PatientViewVitalsController($scope) {

    $scope.isVitalsFormActive = false;
    $scope.isVitalsGraphActive = true;
    $scope.isCelsiusSelected = true;
    $scope.vitalTypes = [
      'Body Temperature',
      'Pulse Rate',
      'Respiration Rate',
      'Blood Pressure'
    ];
    $scope.newVitals = {};

    $scope.init = function() {
      resetNewVitals();
    };

    $scope.onToggleVitalsClick = function() {
      if ($scope.isVitalsFormActive) {
        $scope.isVitalsFormActive = false;
        $scope.isVitalsGraphActive = true;
      } else if ($scope.isVitalsGraphActive) {
        $scope.isVitalsFormActive = true;
        $scope.isVitalsGraphActive = false;
      }
    };

    $scope.onToggleTempClick = function() {
      $scope.isCelsiusSelected = $scope.isCelsiusSelected ? false : true;
    };

    function resetNewVitals() {
      $scope.newVitals = {
        type: $scope.vitalTypes[0]
      };
    }
  }
})();