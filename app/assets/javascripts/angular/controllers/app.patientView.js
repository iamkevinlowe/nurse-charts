(function() {
  angular
    .module('app.patientView')
    .controller('PatientViewController', [
      '$scope',
      'PatientsService',
      'UsersService',
      PatientViewController
    ]);

  function PatientViewController(
    $scope,
    PatientsService,
    UsersService
  ) {

    $scope.init = function(patientId, userId) {
      getPatient(patientId);
      getUsers(userId);
    };

    $scope.onTabClick = function(tab, e) {
      if (e) { e.preventDefault(); }

      $scope.isCareplanTabActive = false;
      $scope.isReportTabActive = false;
      $scope.isHistoryTabActive = false;
      $scope.isVitalsTabActive = false;

      switch (tab) {
        case 'careplan':
          $scope.isCareplanTabActive = true;
          break;
        case 'report':
          $scope.isReportTabActive = true;
          break;
        case 'history':
          $scope.isHistoryTabActive = true;
          break;
        case 'vitals':
          $scope.isVitalsTabActive = true;
          break;
        default:
          console.log('Tab click out of bounds.');
      }
    };

    $scope.formatDate = function(date) {
      var months = [
        "January", "February", "March", "April",
        "May", "June", "July", "August",
        "September", "October", "November", "December"
      ];
      var d = new Date(date);
      var year = d.getFullYear();
      var month = months[d.getMonth()];
      var date = d.getDate();
      return month + " " + date + ", " + year;
    };

    function getPatient(id) {
      PatientsService.get(
        { id: id },
        function onSuccess(response) {
          $scope.patient = response;

          $scope.onTabClick('careplan');
        },
        function onError(response) {
          console.log('Error', response);
        }
      );
    }

    function getUsers(id) {
      UsersService.query({},
        function onSuccess(response) {
          $scope.users = response;

          $scope.currentUser = getCurrentUser(id);
        },
        function onError(response) {
          console.log('Error', response);
        }
      );
    }

    function getCurrentUser(id) {
      var result = null;
      $scope.users.some(
        function(user) {
          if (user.id == id) {
            result = user;
            return true;
          }
        }
      );
      return result;
    }

  }
})();