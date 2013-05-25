isValidUrl = (url) ->
  /^(http|https|ftp):\/\/[a-z0-9]+([-.]{1}[a-z0-9]+)*.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/i.test(url)

ready = ->
  window.timeoutObj = null

  # # populate treat popover content
  # $("a.topic-treat-link").each (index) ->
  #   el = $(this)
  #   $.get el.data("poload"), (d) ->
  #     el.attr 'data-content', d # for some reasons .data() doesn't update DOM

  $('a.topic-treat-link').popover
    offset: 10
    trigger: 'manual'
    html: true
    title: '<h5>Like it? Treat it a drink</h5>'
    template: '<div class="popover right" onmouseover="clearTimeout(window.timeoutObj); $(this).mouseleave(function() {$(this).hide(); });"><div class="arrow"></div><div class="popover-inner"><h3 class="popover-title"></h3><div class="popover-content"><p></p></div></div></div>'
  .mouseenter (e)->
    $(this).popover 'show'
  .mouseleave (e)->
    ref = $(this)
    window.timeoutObj = setTimeout ->
      ref.popover 'hide'
    , 1000

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
