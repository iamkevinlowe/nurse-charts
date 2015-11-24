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

    $scope.init = function(role) {
      UsersService.query(
        {},
        function onSuccess(response) {
          allUsers = response;

          $scope.onTabClick('patient');
        }, function onError(response) {
          console.log(response);
        }
      );

      if (role == 'admin') {
        HospitalsService.query(
          {},
          function onSuccess(response) {
            $scope.hospitals = response;
            resetUser();
          }, function onError(response) {
            console.log(response);
          }
        );
      }
    };

    $scope.onTabClick = function(role, e) {
      if (e) { e.preventDefault(); }

      $scope.isNursesTabActive = false;
      $scope.isPatientsTabActive = false;
      $scope.isAddNewTabActive = false;

      switch (role) {
        case 'addNew':
          $scope.isAddNewTabActive = true;
          break;
        case 'nurse':
          $scope.isNursesTabActive = true;
          break;
        case 'patient':
          $scope.isPatientsTabActive = true;
          break;
        default:
          console.log('Tab click out of bounds.');
      }

      $scope.users = allUsers.filter(function(user) {
        return user.role == role;
      });
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