isValidUrl = (url) ->
  /^(http|https|ftp):\/\/[a-z0-9]+([-.]{1}[a-z0-9]+)*.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/i.test(url)

ready = ->

  if $('.pagination').length
    $(window).scroll ->
      url = $('.pagination .next_page').attr('href') + '&tab=' + $('div#topic-tabs-ctn div.tab-pane.active').attr('id')
      if url && $(window).scrollTop() > $(document).height() - $(window).height() - 50
        $('.pagination').text("loading more topics...")
        $.getScript(url)
    $(window).scroll()

  window.timeoutObj = null

  $(document).on 'click', 'a.create_treat_link', (e)->
    e.preventDefault()
    el = $(e.target)
    popover = el.closest('div.popover')
    popover.hide()
    popover.prev('.topic-treat-link').hide()
    $.ajax
      url: el.attr 'href'
      method: 'post'
      success: (data, textStatus, jqXHR)->
        if !$.isEmptyObject(data)
          popover.siblings('.topic-treats').text(data["topic_treat_score"]) if data["topic_treat_score"]
      error: (jqXHR, textStatus, errorThrown)->
        console.log errorThrown

  $('a.topic-treat-link').popover
    offset: 10
    trigger: 'manual'
    html: true
    title: '<h5>Like it? Treat a drink</h5>'
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
          url: '/topics/preview?link=' + encodeURIComponent(value)
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
