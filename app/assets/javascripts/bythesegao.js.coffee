$ ->
  $('#signin_form, #login_form, #signin_big_form').validationEngine();

  $('#upload').click ->
    $('#picture_upload').click()
    true

  window.cromo_tags = $('#tag_list').tags
    suggestions: ["PP", "Bárcenas", "Gatetes"],
    promptText: "Tagea este cromico si te sale de un webeter..."
    tagClass: 'btn-success'


  $('#cromoForm form input[type=text]').keypress (e) ->
    false if e.keyCode is 13

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
    $('.logindrop a').click()
    false
  $('#crearCromo').click ->
    $(this).hide()
    $('#cromoText, .tags-input').width($('#picture_img').width()+40)
    $('#stats, #pictureTitulaco').slideUp 'fast', ->
      $('#cromoForm').slideDown '100', ->
        $('#cromoText').focus()
    false

  $('#cancel').click ->
    $('#cromoForm').slideUp "100", ->
      $('#stats, #pictureTitulaco').slideDown "fast"
      $('#crearCromo').show()
  false

  $('#daleCera').click ->
    lines = $('#cromoText').val().split("\n")
    number_of_lines = lines.length
    i = 0
    while i < lines.length
      number_of_lines++ if lines[i].length>40
      number_of_lines++ if lines[i].length>80
      number_of_lines++ if lines[i].length>120
      i++
    number_of_lines = 1 if number_of_lines == 0
    commentSpace = 130
    commentSpace +=  (number_of_lines * 25) if number_of_lines>1

    $('#cardHeight').val($('#picture_img').height() + commentSpace)
    $('#cromoForm form #tags').val(window.cromo_tags.getTags())
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
  $("." + type).delay(2000).show().animate
    top: "0"
  , 500
  $('.info:not(.no-hide)').delay(5000).animate
    top: -$(this).outerHeight()
    , 500
