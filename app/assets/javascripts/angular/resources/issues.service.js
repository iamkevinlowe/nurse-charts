(function() {
  angular
    .module('app.resources')
    .factory('IssuesService', [
      '$resource',
      IssuesService
    ]);

  function IssuesService($resource) {
    return $resource('/api/issues/:id');
  }
})();