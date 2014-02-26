$.fn.toscamark = (options) ->
  animations = [
    "slideInUp"
    "slideInDown"
    "slideInLeft"
    "slideInRight"

  ]
  unless @wookmarkOptions
    @wookmarkOptions = $.extend(
      container: $("body")
      offset: 40
      offset_y: 30
      autoResize: false
      itemWidth: $(this[0]).outerWidth(false)
      resizeDelay: 50
    , options)
  else @wookmarkOptions = $.extend(@wookmarkOptions, options)  if options

  # Layout variables.
  @containerWidth = null  unless @containerWidth

  # Main layout function.
  @wookmarkLayout = ->

    # Calculate basic layout parameters.
    columnWidth = @wookmarkOptions.itemWidth + @wookmarkOptions.offset
    containerWidth = @wookmarkOptions.container.width()
    columns = Math.floor((containerWidth + @wookmarkOptions.offset) / columnWidth)
    offset = @wookmarkOptions.offset
    offset_y = @wookmarkOptions.offset_y

    # If container and column count hasn't changed, we can only update the columns.
    bottom = 0
    bottom = @wookmarkLayoutFull(columnWidth, columns, offset, offset_y)
    window.resizing = false

    # Set container height to height of the grid.
    @wookmarkOptions.container.css "height", bottom + "px"
    return


  ###
  Perform a full layout update.
  ###
  @wookmarkLayoutFull = (columnWidth, columns, offset, offset_y) ->

    # Prepare Array to store height of columns.
    heights = []
    if not window.heights? or window.resizing
      window.heights = []
      window.heights.push 0  while window.heights.length < columns

    # Loop over items.
    item = undefined
    top = undefined
    left = undefined
    i = 0
    k = 0
    length = @length
    shortest = null
    shortestIndex = null
    bottom = 0
    while i < length
      item = $(this[i])

      # Find the shortest column.
      shortest = null
      shortestIndex = 0
      k = 0
      while k < columns
        if not shortest? or window.heights[k] < shortest
          shortest = window.heights[k]
          shortestIndex = k
          shortest = 0  if shortest < 400
        k++

      # Center cards in the layout
      # always 3 columns -> 3x500 = 1500 pixels
      contentWidth = columns * (500 + offset)
      newOffest = ((@wookmarkOptions.containerWidth - contentWidth) / 2) + (offset / columns)
      item.removeClass("shown").css
        top: shortest + offset_y + "px"
        left: (shortestIndex * columnWidth + newOffest) + "px"


      # Update column height.
      window.heights[shortestIndex] = shortest + item.outerHeight(true) + @wookmarkOptions.offset_y
      bottom = Math.max(bottom, window.heights[shortestIndex])
      i++
    bottom


  # Apply layout
  @wookmarkLayout()

  @show_card_anim = ($card) ->
    randomAnimation = animations[Math.floor(Math.random() * animations.length)]
    $card.addClass(randomAnimation)
    comment = $(".comment p", $card)
    item = $(".cromo_img img", $card)
    item.delay(1000 + Math.floor(Math.random() * 2000)).slideDown 100, "easeOutElastic", ->
      $(this).css "opacity", 1
      $("p", $(this).next()).delay(1000).animate
        top: "0px"
        height: "185px"
      , 100, ->
        $(this).css "height", "auto"
    return true

  # Display items (if hidden).
  $(this).show()
  i = 0
  while i < @length
    $card = $(this[i])
    setTimeout (
      @show_card_anim($card)
    ), Math.floor(Math.random() * 10000)
    i++