$ ->
  $('.cromo.mobile').dblclick ->
    votar($(this).data('cromoId'), $('.cromoplus', $(this)))
    false
  $('.cromoplus').click ->
    votar($(this).data('cromoId'), $(this))
    false

  votar = (cromoid, $cromoplus) ->
    if ($('#upload').length == 0)
      $('#logindrop h4').html("Vamos pa dentro primero!")
      $('#logindrop a').click()
      return false
    else
      $n = $('.n', $cromoplus.parent())
      votos = parseInt($n.html())
      if $cromoplus.hasClass('clicked')
        $cromoplus.data('restando', true)
        $n.html(zeroPad(votos--,3))
        $cromoplus.removeClass('clicked')
      else
        $n.html(zeroPad(votos++,3))
        $cromoplus.data('sumando', true)
        $('img', $cromoplus).hide().css('top', '5px').attr('src', '/assets/gustico.gif').fadeIn "slow"

      $.ajax
        type: "POST"
        beforeSend: (jqXHR, settings) ->
          jqXHR.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
        url: "/users/vote_card"
        data: {"card_id": cromoid}
        success: (data) ->
          if data["votos"]!=undefined
            $('#n'+ data['id']).fadeOut 'fast', ->
              $(this).html(data["votos"]).fadeIn "fast", ->
                $cromoplus = $(this).parent().prev()
                if $cromoplus.data('restando')
                  $cromoplus.removeClass('clicked')
                  $cromoplus.find('img').hide().css('top', '0px').attr('src', '/assets/votar.gif').show()
                  $cromoplus.data('restando', false)
                else if $cromoplus.data('sumando')
                  setTimeout (->
                    window.gustico($cromoplus)
                    ), 5000
                  $cromoplus.data('sumando', false)
                  true
        true
    true

  zeroPad = (num, places) ->
    zero = places - num.toString().length + 1
    Array(+(zero > 0 && zero)).join("0") + num;

window.gustico = ($cromoplus) ->
  $cromoplus.find('img').hide().css('top','0px').attr('src', '/assets/votar.gif').fadeIn "fast", ->
    $cromoplus.addClass('clicked')
  true
