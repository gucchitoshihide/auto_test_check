$ ->
  $('#tab a').click ->
    for tab in ['password', 'dummy']
      $('#setting .' + tab).hide()
    $('#setting .' + this.parentElement.className).show()
