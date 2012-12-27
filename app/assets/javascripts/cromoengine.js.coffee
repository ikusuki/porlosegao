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
    $('.credits', $(this)).stop().show().animate
      height: '15px'
      top: '-20px'
    , 100
  ).live 'mouseout', ->
    $credits = $('.credits', $(this))
    unless $credits.hasClass('hover')
      $credits.stop().animate
        height: '0px'
        top: '-10px'
      , 50
      , ->
        $(this).hide()
  $('.credits').live('mouseover', ->
    $(this).addClass('hover')
  ).live 'mouseout', ->
    $(this).removeClass('hover')