isValidUrl = (url) ->
  /^(http|https|ftp):\/\/[a-z0-9]+([-.]{1}[a-z0-9]+)*.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/i.test(url)

ready = ->
  $('button#toggle-preview').click ->
    $('iframe#preview-iframe').toggle()

  $('input#topic_link').typeWatch
    callback: (value)->
      if isValidUrl(value)
        $.ajax
          url: '/topics/preview?link=' + value
          success: (data, textStatus, jqXHR)->
            if !$.isEmptyObject(data) && $.trim($('input#topic_title').val()) == ''
              $('input#topic_title').val(data.title)
          error: (jqXHR, textStatus, errorThrown)->
            console.log errorThrown
      else
        console.log 'not a valid url'
    captureLength: 5

$(document).ready(ready)
$(document).on('page:load', ready)
