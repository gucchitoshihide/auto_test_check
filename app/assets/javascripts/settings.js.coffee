hide_flash = ->
  $('#notice').hide()
  $('#alert').hide()

change_tab = (selected_tab) ->
  for tab in ['password', 'avatar', 'write_style']
    $('#setting .' + tab).hide()
  $('#setting .' + selected_tab.parentElement.className).show()

$ ->
  $('#tab a').click ->
    hide_flash()
    change_tab(this)
