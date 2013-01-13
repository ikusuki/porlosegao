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
