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

    $scope.onNewVitalsSubmit = function(valid) {
      if (valid) {
        switch ($scope.newVitals.type) {
          case $scope.vitalTypes[0]:
            console.log($scope.newVitals);
            break;
          case $scope.vitalTypes[1]:
            // TODO
            break;
          case $scope.vitalTypes[2]:
            // TODO
            break;
          case $scope.vitalTypes[3]:
            // TODO
            break;
          default:
            console.log("Error: vital type is out of bounds.");         
        }
      }
    };

    function resetNewVitals() {
      $scope.newVitals = {
        type: $scope.vitalTypes[0]
      };
    }
  }
})();