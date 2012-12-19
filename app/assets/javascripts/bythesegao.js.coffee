$ ->
  $('#signin_form, #login_form').validationEngine();
  window.myMessages = ['info','warning','error','success']
  # Initially, hide them all
  hideAllMessages()


  showMessage 'info'


  # When message is clicked, hide it
  $(".message").click ->
    $(this).animate
      top: -$(this).outerHeight()
    , 500

hideAllMessages = () ->
  messagesHeights = new Array() # this array will store height for each
  i = 0
  while i < window.myMessages.length
    messagesHeights[i] = $("." + window.myMessages[i]).outerHeight() # fill array
    $("." + window.myMessages[i]).css "top", -messagesHeights[i] #move element outside viewport
    i++
  true

showMessage = (type) ->
  $("." + type).animate
    top: "0"
  , 500
