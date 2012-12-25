$ ->
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
      data: 
        "titulo" : $('#pictureTitle').val()
      success: (html) ->
        $('#titulerForm').fadeOut("fast")
        $('#pictureTitulaco').hide().html(data['titulo']).fadeIn("fast")
        true
    true



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
