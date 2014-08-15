validation =
  'comment': false

$ ->
  initialize()
  $('#comment_content').keyup ->
    if $(':text[name="comment[content]"]').val() == ""
      validation['comment'] = false
    else
      validation['comment'] = true
    toggle_submit_by_validation()

initialize = ->
  value_comment =  $(':text[name="comment[content]"]').val()
  respond_reload(value_comment)
  if value_comment == ""
    $('#comment_form .submit_field input').attr('disabled', 'disabled')

respond_reload = (value_comment) ->
  if value_comment != ""
    validation['content'] = true

toggle_submit_by_validation = ->
  submit_field = $('#comment_form .submit_field input')
  if validation['comment'] == true
    submit_field.attr('disabled', false)
    submit_field.removeAttr('disabled')
  else
    submit_field.attr('disabled', 'disabled')
