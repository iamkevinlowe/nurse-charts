(function() {
  angular
    .module('app.users')
    .controller('UsersController', [
      '$scope',
      'UsersService',
      'PatientsService',
      'HospitalsService',
      UsersController
    ]);

  function UsersController(
    $scope,
    UsersService,
    PatientsService,
    HospitalsService
  ) {

    $scope.newUser = {};
    $scope.roles = ['patient', 'nurse'];

    $scope.init = function(role) {
      getPatients();
      
      if (role == 'admin' || role == 'doctor') {
        getUsers();
        getHospitals();
      }

      $scope.onTabClick('patient');
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
    };

    $scope.onNewUserFormSubmit = function(valid) {
      if (valid) {
        if ($scope.newUser.role == 'nurse') {
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
        } else if ($scope.newUser.role == 'patient') {
          PatientsService.save(
            {
              patient: $scope.newUser
            },
            function onSuccess(response) {
              console.log(response);
            }, function onError(response) {
              console.log(response);
            }
          );
        }
        
      }
    };

    function getPatients() {
      PatientsService.query(
        {},
        function onSuccess(response) {
          $scope.patients = response;
        }, function onError(response) {
          console.log('Error', response);
        }
      );
    }

    function getUsers() {
      UsersService.query(
        {},
        function onSuccess(response) {
          $scope.users = response;
        }, function onError(response) {
          console.log('Error', response);
        }
      );
    }

    function getHospitals() {
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

    function resetUser() {
      $scope.newUser = {
        role: $scope.roles[0],
        hospital_id: $scope.hospitals[0].id
      };
    }

  }
})();