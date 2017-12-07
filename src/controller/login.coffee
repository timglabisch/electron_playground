abstractController = require './abstract.coffee'

module.exports = class extends abstractController

  clicks: 0

  constructor: (@login_service) ->
    super()

  indexAction: (req) ->
    @dom.append('
      <div class="txt"></div>
      <span>Api Key</span>
      <input class="api-key" type="text" value="">
      <input class="check-api-key" type="button" value="Ok">
    ')
    @dom.find('.check-api-key').on 'click', @onFooClicked.bind @

  getApiKey: ->
    @dom.find('.api-key').val()

  onFooClicked: =>
    @dom.find(".txt").html("trying to auth...");
    @login_service.try_auth @getApiKey(), @onAuthed.bind(@), @onAuthFailed.bind(@)

  onAuthFailed: ->
    @dom.find(".txt").html("auth failed");

  onAuthed: (login) ->
    @dom.html("Hello " + login.getDisplayName())
