(function() {

  angular
    .module('app.resources')
    .config([
      '$httpProvider',
      HttpProviderConfig
    ]);

  function HttpProviderConfig($httpProvider) {
    $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
    $httpProvider.defaults.headers.common['Accept'] = 'application/json';
  }

})();