$ ->
  $('.cromo').show()
  item = $('.cromo img')
  comment = $('.cromo .comment p')

  item.delay(Math.floor(Math.random() * 2000)).slideDown 100, "easeOutElastic", ->
    $(this).css "opacity", 1
    $("p", $(this).next()).delay(1000).animate
      top: "0px"
      height: "150px"
    , 100

  $('#ladrido input').keyup (e) ->
    if e.keyCode is 13
      $.ajax 
        type: "POST"
        url: "/cromos/" + $('#cromo-container').data('id') + '/comments'
        data: 
          "comment" : $(this).val()
        beforeSend: (jqXHR, settings) ->
          jqXHR.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
        success: (data) ->
          alert(data)


