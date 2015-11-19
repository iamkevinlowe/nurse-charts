(function() {

  angular
    .module('app.signin')
    .controller('SignInController', [
      '$scope',
      '$window',
      'SessionsService',
      SignInController
    ]);

  function SignInController($scope, $window, SessionsService) {

    $scope.init = function() {
      $scope.onMedicalTabClick();
    }

    $scope.onMedicalTabClick = function(e) {
      if (e) {
        e.preventDefault();
      }

      $scope.user = {};
      $scope.isMedicalTabActive = true;
      $scope.isPatientTabActive = false;
    };

    $scope.onPatientTabClick = function(e) {
      if (e) {
        e.preventDefault();
      }

      $scope.patient = {};
      $scope.isMedicalTabActive = false;
      $scope.isPatientTabActive = true;
    };

    $scope.onSignInSubmit = function(valid) {
      if ($scope.isMedicalTabActive) {
        SessionsService.save(
          {
            user: $scope.user
          },
          function onSuccess(response) {
            $window.location.reload();
          },
          function onError(response) {
            var error = {
              status: response.statusText,
              message: response.data.error
            };
            console.log(error);
          }
        );
      } else {
        console.log($scope.patient);
      }
    };
  }

})();