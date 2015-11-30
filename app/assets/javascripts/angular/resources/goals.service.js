(function(){
  angular
    .module('app.resources')
    .factory('GoalsService', [
      '$resource',
      GoalsService
    ]);

  function GoalsService($resource) {
    return $resource('/api/goals/:id');
  }
})();