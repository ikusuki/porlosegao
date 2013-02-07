$ ->
  $('#padentrer').click ->
    $('#logindrop a').click()
    return false

  $('#ladrido input').keyup (e) ->
    if e.keyCode is 13
      unless $(this).val()==''
        comentario = $(this).val()
        $(this).val("")
        $.ajax 
          type: "POST"
          url: "/cromos/" + $('#cromo-container').data('id') + '/comments'
          data: 
            "comment" : comentario
          beforeSend: (jqXHR, settings) ->
            jqXHR.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
          success: (data) ->
            primero = $('#comments .porcomentar').length == 0
            if primero 
              left = false
            else            
              left = $('#comments .porcomentar:last').hasClass('left')
            if left
              div = "<div class='porcomentar right hide'><div class='user'><p class='com triangle-right right'>" + data.comment + "</p><div class='username'><a href='#'>" + data.username + "</a></div></div>"
            else
              div = "<div class='porcomentar left hide'><div class='user'><div class='username'><a href='#'>" + data.username + "</a></div><p class='com triangle-right left'>" + data.comment + "</p></div>"
            if primero
              $('#nadie').hide()
              $('#comments #nadie').after(div)
            else
              $('#comments .porcomentar:last').after(div)
            $('#comments .porcomentar.hide').fadeIn('fast').removeClass('hide')