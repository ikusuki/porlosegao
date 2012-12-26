$ ->
  # $('#pictures .picture img, #cromos .inside img').imgr
  #   size: "1px"
  #   color: "white"
  #   radius: "20px 20px 0px 0px"
  $('#signin_form, #login_form, #signin_big_form').validationEngine();

  $('#upload').click ->
    $('#picture_upload').click()
    true

  window.myMessages = ['info','warning','error','success']
  # Initially, hide them all
  hideAllMessages()

  window.showMessage 'info'
  window.showMessage 'error'

  # When message is clicked, hide it
  $(".message").click ->
    unless $(this).hasClass('no-hide')
      $(this).animate
        top: -$(this).outerHeight()
      , 500

  $('#bautizer').click ->
    $.ajax
      url: "/pictures/" + $(this).data('id') + "/bautizer"
      type: "POST"
      beforeSend: (jqXHR, settings) ->
        jqXHR.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
      data: 
        "titulo" : $('#pictureTitle').val()
      success: (data) ->
        $('#user-form').fadeOut("fast")
        $('#pictureTitulaco').hide().html(data['titulo']).fadeIn("fast")
        true
    true
  $('#logueate').click ->
    $('#login').click()
    false
  $('#crearCromo').click ->
    $(this).hide()
    $('#cromoText').width($('#picture_img').width()+40)
    $('#stats, #pictureTitulaco').slideUp 'fast', ->
      $('#cromoForm').slideDown 'fast', ->
        $('#cromoText').focus()
    false

  $('#cancel').click ->
    $('#cromoForm').slideUp "fast", ->
      $('#stats, #pictureTitulaco').slideDown "fast"
      $('#crearCromo').show()
  false
  $('#daleCera').click ->
    lines = $('#cromoText').val().split("\n")
    number_of_lines = lines.length
    i = 0
    while i < lines.length
      number_of_lines++ if lines[i].length>40
      i++
    number_of_lines = 1 if number_of_lines == 0
    commentSpace = 120
    commentSpace +=  (number_of_lines * 45) if number_of_lines>1
    console.log("lines:" + number_of_lines)

    $('#cardHeight').val($('#picture_img').height() + commentSpace)
    $('#cromoForm form').submit()
    true

lineBreaksCount = (str) ->
  try
    return (str.match(/[^\n]*\n[^\n]*/g).length)
  catch e
    return 0

hideAllMessages = () ->
  messagesHeights = new Array() # this array will store height for each
  i = 0
  while i < window.myMessages.length
    messagesHeights[i] = $("." + window.myMessages[i]).outerHeight() # fill array
    $("." + window.myMessages[i]).css "top", -messagesHeights[i] #move element outside viewport
    i++
  true

window.showMessage = (type) ->
  $("." + type).animate
    top: "0"
  , 500
  $('.info:not(.no-hide)').delay(5000).animate
    top: -$(this).outerHeight()
    , 500
