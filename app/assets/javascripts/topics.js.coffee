isValidUrl = (url) ->
  /^(http|https|ftp):\/\/[a-z0-9]+([-.]{1}[a-z0-9]+)*.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/i.test(url)

ready = ->
  $('button#toggle-preview').click ->
    $('iframe#preview-iframe').toggle()

  $('select#topic_thumbnail').imagepicker()

  $('input#topic_link').typeWatch
    callback: (value)->
      if isValidUrl(value)
        $.ajax
          url: '/topics/preview?link=' + value
          success: (data, textStatus, jqXHR)->
            if !$.isEmptyObject(data) && $.trim($('input#topic_title').val()) == ''
              $('input#topic_title').val(data.title)
              $.each data.images, (i, e)->
                $('select#topic_thumbnail').append('<option data-img-src="' + e + '" value="' + e + '"></option>')
                $('select#topic_thumbnail').imagepicker() # refresh image picker
          error: (jqXHR, textStatus, errorThrown)->
            console.log errorThrown
      else
        console.log 'not a valid url'
    captureLength: 5

$(document).ready(ready)
$(document).on('page:load', ready)
