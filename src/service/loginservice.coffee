_login = require('./login/login.coffee');

module.exports = class

  is_authed: false

  login: null

  try_auth: (api_key, onOk, onFailed) ->
    $.ajax({
      url: 'https://api.easybill.de/rest/v1/account',
      type: 'GET',
      headers:
        "Authorization": 'Bearer ' + api_key,
      dataType: 'json'
    })
    .done((res) =>
      @onAuthed(res);
      return onFailed() if !@is_authed
      onOk @login
    )
    .fail((x) => onFailed() );

  onAuthed: (res) ->
    console.log(res)
    @login = new _login
    @login.setUserId res.id
    @login.setMembership res.membership
    @login.setDisplayName res.login.display_name
    @is_authed = true



