validation = 
  'name':     false
  'password': false

$ ->
  initialize()
  $('#user_name').keyup ->
    if $(':text[name="user[name]"]').val() == ""
      validation['name'] = false
    else
      validation['name'] = true
    toggle_submit_by_validation()

  $('#user_password').keyup ->
    if $(':password[name="user[password]"]').val() == ""
      validation['password'] = false
    else
      validation['password'] = true
    toggle_submit_by_validation()

initialize = ->
  value_name     = $(':text[name="user[name]"]').val()
  value_password = $(':password[name="user[password]"]').val()
  respond_reload(value_name, value_password)
  if value_name == "" || value_password == ""
    $('#user_form .submit_field input').attr('disabled', 'disabled')

respond_reload = (value_name, value_password) ->
  if value_name != ""
    validation['name'] = true
  if value_password  != ""
    validation['password'] = true

toggle_submit_by_validation = ->
  submit_field = $('#user_form .submit_field input')
  if validation['name'] and validation['password']
    submit_field.attr('disabled', false)
    submit_field.removeAttr('disabled')
  else
    submit_field.attr('disabled', 'disabled')

