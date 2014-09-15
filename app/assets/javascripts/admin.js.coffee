class Flash
  @hide_alert: (id) ->
    $('#alert').hide()

$ ->
  for id_input_form in ['#admin_email', '#admin_password']
    $(id_input_form).focus ->
      Flash.hide_alert()
