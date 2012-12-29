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
    $('.votos', $(this)).stop().show().animate
      left: '0px'
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
    $votos = $('.votos', $(this))
    unless $votos.hasClass('hover')
      $votos.stop().animate
        left: '55px'
      , 100

  $('.credits, .votos').live('mouseover', ->
    $(this).addClass('hover')
  ).live 'mouseout', ->
    $(this).removeClass('hover')

  $('.cromoplus').click ->
    if ($('#upload').length == 0)
      $('#logindrop h4').html("Vamos pa dentro primero!")
      $('#logindrop a').click()
      return false
    else
      if $(this).hasClass('clicked')
        $(this).data('restando', true)
        $(this).removeClass('clicked')
      else
        $(this).data('sumando', true)
        $('img', $(this)).fadeOut "fast", ->
          $(this).attr('src', '/assets/gustico.gif').css(
              'top': '5px'
              'opacity': '1'
              ).fadeIn 'fast'
      $.ajax
        type: "POST"
        beforeSend: (jqXHR, settings) ->
          jqXHR.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
        url: "/users/vote_card"
        data: {"card_id": $(this).data('cromo_id')}
        success: (data) ->
          if data["votos"]!=undefined
            $('#n'+ data['id']).fadeOut 'fast', ->
              $(this).html(data["votos"]).fadeIn "fast", ->
                $cromoplus = $(this).parent().prev()
                console.log ($cromoplus.data())
                if $cromoplus.data('restando')
                  $cromoplus.removeClass('clicked')
                  $cromoplus.find('img').attr('src', '/assets/votar.gif')
                  $cromoplus.data('restando', false)
                else if $cromoplus.data('sumando')
                  setTimeout (->
                    window.gustico($cromoplus)
                    ), 3000
                  $cromoplus.data('sumando', false)
                  true
        true
    true

window.gustico = ($cromoplus) ->
  $cromoplus.addClass('clicked')
  $cromoplus.find('img').fadeOut 'fast',->
    $(this).attr('src', '/assets/votar.gif')
    $(this).fadeIn 'slow'

  true


