$ ->
  $cromos = $('#cromos')
  cromoptions =
    offset: 50
    itemWidth: 500
    containerWidth: $('#cromos').width()
    container: $cromos

  handler = $('div.cromo', $cromos)
  handler.toscamark(cromoptions)
