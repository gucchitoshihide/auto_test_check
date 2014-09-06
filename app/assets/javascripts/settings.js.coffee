$ ->
  $('#tab a').click ->
    for tab in ['password', 'avatar']
      $('#setting .' + tab).hide()
    $('#setting .' + this.parentElement.className).show()
