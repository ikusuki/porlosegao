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

  


