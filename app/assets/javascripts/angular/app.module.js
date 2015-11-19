(function() {

  angular.module('app.navigation', []);
  angular.module('app.signin', []);
  angular.module('app.users', []);

  angular.module('app.resources', [
    'ngResource'
  ]);

  angular.module('app', [
    'app.navigation',
    'app.signin',
    'app.users',
    'app.resources'
  ]);

})();