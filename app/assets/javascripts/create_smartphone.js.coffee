$ ->
  $('#crearCromo').click ->
    if ($('#upload').length == 0)
      $('#logindrop h4').html("Vamos pa dentro primero!")
      $('#logindrop a').click()
      return false
    else
      $('#header').hide()
      $(this).hide()
      $('#comentario').hide()
      $('#cromoForm').show()
      $('#cromoText').focus()

  $('#cancel').click ->
    $('#cromoForm').slideUp "fast", ->
      $('#stats, #pictureTitulaco').slideDown "fast"
      $('#crearCromo').show()
      $('#comentario').show()
      $('#header').show()
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
    alert ("lines:"  + number_of_lines)
    commentSpace = 130
    commentSpace +=  (number_of_lines * 25) if number_of_lines>1
    alert ("comment space: " + commentSpace)
    alert ("picture height: " + $('#picture_img').height())


    $('#cardHeight').val($('#picture_img').height() + commentSpace)
    $('#cromoForm form').submit()
    true

lineBreaksCount = (str) ->
  try
    return (str.match(/[^\n]*\n[^\n]*/g).length)
  catch e
    return 0