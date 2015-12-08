(function() {
  angular
    .module('app.patientView')
    .controller('PatientViewVitalsController', [
      '$scope',
      'VitalsService',
      'TemperaturesService',
      'PulseRatesService',
      'RespirationRatesService',
      'BloodPressuresService',
      'ReportsService',
      PatientViewVitalsController
    ]);

  function PatientViewVitalsController(
    $scope,
    VitalsService,
    TemperaturesService,
    PulseRatesService,
    RespirationRatesService,
    BloodPressuresService,
    ReportsService
  ) {

    $scope.isVitalsFormActive = false;
    $scope.isVitalsGraphActive = true;
    $scope.isCelsiusSelected = true;
    $scope.vitalTypes = [
      'Body Temperature',
      'Pulse Rate',
      'Respiration Rate',
      'Blood Pressure'
    ];
    $scope.newReading = {};

    $scope.init = function() {
      $scope.$watchGroup(['patient', 'currentUser'], function(newValues, oldValues) {
        if (newValues[0] && newValues[1]) {
          $scope.patient.vital ? newReading() : createVital($scope.patient.id);
        }
      });
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
        switch ($scope.newReading.type) {
          case $scope.vitalTypes[0]:
            if (!$scope.isCelsiusSelected) {
              $scope.newReading.temperature = ($scope.newReading.temperature - 32) / 1.8;
            }
            createTemperature($scope.newReading.temperature, $scope.patient.vital.id);
            break;
          case $scope.vitalTypes[1]:
            createPulseRate($scope.newReading.pulseRate, $scope.patient.vital.id);
            break;
          case $scope.vitalTypes[2]:
            createRespirationRate($scope.newReading.respirationRate, $scope.patient.vital.id);
            break;
          case $scope.vitalTypes[3]:
            createBloodPressure($scope.newReading.bloodPressure, $scope.patient.vital.id);
            break;
          default:
            console.log("Error: vital type is out of bounds.");         
        }
        newReading();
      }
    };

    $scope.submitButtonDisabler = function(form) {
      switch ($scope.newReading.type) {
        case $scope.vitalTypes[0]:
          if (form.temperature.$valid) { return false; }
        case $scope.vitalTypes[1]:
          if (form.pulseRate.$valid) { return false; }
        case $scope.vitalTypes[2]:
          if (form.respirationRate.$valid) { return false; }
        case $scope.vitalTypes[3]:        
          if (form.systolic.$valid && form.diastolic.$valid) { return false; }
        default:
          return true;
      }
    };

    function createVital(id) {
      VitalsService.save(
        {
          vital: { patient_id: id }
        },
        function onSuccess(response) {
          response.blood_pressures = [];
          response.pulse_rates = [];
          response.respiration_rates = [];
          response.temperatures = [];
          $scope.patient.vital = response;
          newReading();
        },
        function onError(response) {
          console.log('Error', response);
        }
      );
    }

    function createTemperature(reading, id) {
      TemperaturesService.save(
        {
          temperature: {
            celsius: reading,
            vital_id: id
          }
        },
        function onSuccess(response) {
          $scope.patient.vital.temperatures.push(response);
          $scope.newReading.report.notes = "Temperature has been recorded.";
          createReport($scope.newReading.report);
        },
        function onError(response) {
          console.log('Error', response);
        }
      );
    }

    function createPulseRate(reading, id) {
      PulseRatesService.save(
        {
          pulse_rate: {
            bpm: reading,
            vital_id: id
          }
        },
        function onSuccess(response) {
          $scope.patient.vital.pulse_rates.push(response);
          $scope.newReading.report.notes = "Pulse Rate has been recorded.";
          createReport($scope.newReading.report);
        },
        function onError(response) {
          console.log('Error', response);
        }
      );
    }

    function createRespirationRate(reading, id) {
      RespirationRatesService.save(
        {
          respiration_rate: {
            bpm: reading,
            vital_id: id
          }
        },
        function onSuccess(response) {
          $scope.patient.vital.respiration_rates.push(response);
          $scope.newReading.report.notes = "Respiration Rate has been recorded.";
          createReport($scope.newReading.report);
        },
        function onError(response) {
          console.log('Error', response);
        }
      );
    }

    function createBloodPressure(reading, id) {
      BloodPressuresService.save(
        {
          blood_pressure: {
            systolic: reading.systolic,
            diastolic: reading.diastolic,
            vital_id: id
          }
        },
        function onSuccess(response) {
          $scope.patient.vital.blood_pressures.push(response);
          $scope.newReading.report.notes = "Blood Pressure has been recorded.";
          createReport($scope.newReading.report);
        },
        function onError(response) {
          console.log('Error', response);
        }
      );
    }

    function createReport(newReport) {
      ReportsService.save(
        {
          report: newReport
        },
        function onSuccess(response) {
          $scope.patient.reports.unshift(addAssociations(response));

          newReading();
        },
        function onError(response) {
          console.log('Error', response);
        }
      );
    }

    function addAssociations(report) {
      report.activity = { name: 'Vitals Reading' };

      $scope.users.some(function(user) {
        if (user.id == report.user_id) {
          report.user = user;
          return true;
        }
      });

      return report;
    }

    function newReading() {
      $scope.newReading = {
        type: $scope.vitalTypes[0],
        report: {
          patient_id: $scope.patient.id,
          user_id: $scope.currentUser.id,
          activity_id: $scope.patient.vital.id,
          activity_type: 'Vital',
          alert: null,
          notes: null
        }
      };
    }
  }
})();