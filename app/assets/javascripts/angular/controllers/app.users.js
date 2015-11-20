(function() {
  angular
    .module('app.users')
    .controller('UsersController', [
      '$scope',
      'UsersService',
      'HospitalsService',
      UsersController
    ]);

  function UsersController($scope, UsersService, HospitalsService) {

    var allUsers;
    $scope.roles = ['patient', 'nurse'];

    $scope.init = function() {
      UsersService.query(
        {},
        function onSuccess(response) {
          allUsers = response;

          $scope.onTabClick('patient');
        }, function onError(response) {
          console.log(response);
        }
      );

      HospitalsService.query(
        {},
        function onSuccess(response) {
          $scope.hospitals = response;
          resetUser();
        }, function onError(response) {
          console.log(response);
        }
      );
    };

    $scope.onTabClick = function(role, e) {
      if (e) { e.preventDefault(); }

      $scope.isNursesTabActive = false;
      $scope.isPatientsTabActive = false;
      $scope.isAddNewTabActive = false;

      if (role == 'addNew') {
        $scope.isAddNewTabActive = true;
      } else {
        $scope.users = allUsers.filter(function(user) {
          return user.role == role;
        });

        if (role == 'nurse') {
          $scope.isNursesTabActive = true;
        } else if (role == 'patient') {
          $scope.isPatientsTabActive = true;
        }
      }
    };

    $scope.onNewUserFormSubmit = function(valid) {
      if (valid) {
        if ($scope.user.role == 'nurse') {
          $scope.user.room_number = null;
        }
        UsersService.save(
          {
            user: $scope.user
          },
          function onSuccess(response) {
            allUsers.push(response);
            resetUser();
          }, function onError(response) {
            console.log(response);
          }
        );
      }
    };

    function resetUser() {
      $scope.user = {
        role: $scope.roles[0],
        hospital_id: $scope.hospitals[0].id
      };
    }

  }
})();