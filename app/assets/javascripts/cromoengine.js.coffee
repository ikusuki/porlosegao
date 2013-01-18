$ ->
  $cromos = $('#cromos')
  cromoptions =
    offset: 50
    itemWidth: 500
    containerWidth: $('#cromos').width()
    container: $cromos

  handler = $('div.cromo', $cromos)
  handler.toscamark(cromoptions)

  $('.cromo').live('mouseover', ->
    $('ul.social', $(this)).show()
    $('.credits', $(this)).stop().show().animate
      height: '15px'
      top: '-20px'
    , 100
    $('.votos', $(this)).stop().show().animate
      left: '0px'
    , 100
  ).live 'mouseout', ->
    $('ul.social', $(this)).hide()
    $credits = $('.credits', $(this))
    unless $credits.hasClass('hover')
      $credits.stop().animate
        height: '0px'
        top: '-10px'
      , 50
      , ->
        $(this).hide()
    $votos = $('.votos', $(this))
    unless $votos.hasClass('hover')
      $votos.stop().animate
        left: '55px'
      , 100

  $('.credits, .votos').live('mouseover', ->
    $(this).addClass('hover')
  ).live 'mouseout', ->
    $(this).removeClass('hover')


# $ ->
#   window.handler = null
#   window.$cds = $('#cds')
#   window.options = 
#     offset: 20
#     itemWidth: 220
#     container: window.$cds
#   window.ajax_cards = false
#   window.cards_page = 1
 
#   window.moreCards = ->
#     unless window.ajax_cards
#       window.ajax_cards = true  
#       $('#spinner').show()  
#       $.ajax
#         type: "GET"
#         url: "/cards/index_ajax?page=" + window.cards_page
#         success: (cards_html) ->
#           if cards_html
#             window.$cds.append(cards_html) 
#             window.ajaxPage = true
#             window.handler = $('div.flip-card.shown', window.$cds)
#             window.cards_page++ unless cards_html is ""
#             window.handler.wookmark(window.options)
#             window.adjustLoadDelay()
#           else
#             $('#spinner').hide()
#           true
#   true

#   window.fullWookmark()
  
#   $(window).scroll ->
#     window.checkScrollPosition()
#     true
  
#   $(window).resize ->
#     window.resizing = true
#     clearTimeout(window.resizeTimer) if (window.resizeTimer)
#     window.resizeTimer = setTimeout window.fullWookmark, 1000
#     true
#   true

# window.fullWookmark = () ->
#   $('#spinner').addClass('resizing').show()
#   window.handler = $('div.flip-card', window.$cds)
#   window.handler.wookmark(window.options)
#   $('#spinner').removeClass('resizing').hide()

# true  

# window.adjustLoadDelay = () ->
#   c = setTimeout('window.ajax_cards = false;  $("#spinner").hide();   window.checkScrollPosition();', 500)
#   true

# window.checkScrollPosition = () ->
#   window.moreCards() if (!window.ajax_cards && ($(window).scrollTop() + $(window).height() > $(document).height() - 100))
#   true





