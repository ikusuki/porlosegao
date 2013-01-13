$ ->
  $('#signin_form, #login_form, #signin_big_form').validationEngine();
  $(".line-button").click ->
    launchApp $(this).attr("data-url"), "http://itunes.apple.com/jp/app/line/id443904275"
    false

launchApp = (schema, url) ->
  iframe = document.createElement("iframe")
  iframe.src = schema
  document.body.appendChild iframe
  time = (new Date()).getTime()
  setTimeout (->
    now = (new Date()).getTime()
    document.body.removeChild iframe
    return  if (now - time) > 400
  ), 300



