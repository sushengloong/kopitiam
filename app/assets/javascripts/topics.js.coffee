ready = ->
  $('button#toggle-preview').click ->
    $('iframe#preview-iframe').toggle()

$(document).ready(ready)
$(document).on('page:load', ready)
