_di = require '../lib/di.coffee'
_dispatcher = require '../lib/dispatcher.coffee'
_controllerLogin = require '../controller/login.coffee'
_login_service = require '../service/loginservice.coffee'


class main
  di: null

  getContainer: ->
    return @di if @di
    @di = new _di
    @di.set 'di', @di
    @di.configure
      factories:
        login_service: (di) -> new _login_service
        dispatcher: (di) -> new _dispatcher di
        controllerLogin:
          shared: false,
          factory: (di) -> new _controllerLogin di.get('login_service')()
    @di

  handle: (request) ->
    @getContainer().get('dispatcher')().dispatchRoute request

app = new main

$('#app').append('
  <div class="app_controller" data-controller="Login"></div>
');

$('.app_controller').each (i, el) ->
  try
    app.handle
      controller: $(el).data('controller')
      dom: $(el)
  catch e
    console.log e