# http://dev.classmethod.jp/client-side/javascript/class-in-coffeescript/

class FormValidationState
  _state = []

  reset_state = ->
    _state = []

  constructor: () ->
    reset_state()

  validate_length = (property_name, property_length) ->
    if property_length == 0
      _state.push ('blank_' + property_name)

  validation: (name, password) ->
    reset_state()
    validate_length('name',     name.length)
    validate_length('password', password.length)

  state: ->
    return _state

class Message
  @t = (message_property) ->
    $('#message .' + message_property).val()


class Flash
  reset_message = ->
    $('#alert > ul').remove()

  show_message = (active_state) ->
    reset_message()
    $('#alert').append('<ul></ul>')
    $('#alert > ul').append('<li>' + Message.t(message_property) + '</li>') for message_property in active_state

  @alert_if_active_state: (state) ->
    show_message(state)

on_blur_validation = (form_validation_state) ->
  form_validation_state.validation($('#user_name').val(), $('#user_password').val())
  form_validation_state.state()

$ ->
  form_validation_state = new FormValidationState()
  $('#user_name').blur ->
    on_blur_validation(form_validation_state)
    Flash.alert_if_active_state(form_validation_state.state())

  $('#user_password').blur ->
    on_blur_validation(form_validation_state)
    Flash.alert_if_active_state(form_validation_state.state())
