$ ->
  $('.cromo.mobile').dblclick ->
    votar($(this).data('cromo_id'), $('.cromoplus', $(this)))
    false
  $('.cromoplus').click ->
    votar($(this).data('cromo_id'), $(this))
    false

  votar = (cromoid, $cromoplus) ->
    if ($('#upload').length == 0)
      $('#logindrop h4').html("Vamos pa dentro primero!")
      $('#logindrop a').click()
      return false
    else
      if $cromoplus.hasClass('clicked')
        $cromoplus.data('restando', true)
        $cromoplus.removeClass('clicked')
      else
        $cromoplus.data('sumando', true)
        $('img', $cromoplus).fadeOut "fast", ->
          $(this).attr('src', '/assets/gustico.gif').css(
              'top': '5px'
              'opacity': '1'
              ).fadeIn 'fast'
      $.ajax
        type: "POST"
        beforeSend: (jqXHR, settings) ->
          jqXHR.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
        url: "/users/vote_card"
        data: {"card_id": $cromoplus.data('cromo_id')}
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
