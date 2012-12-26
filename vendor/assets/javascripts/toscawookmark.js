$.fn.toscamark = function(options) {
  
  if(!this.wookmarkOptions) {
    this.wookmarkOptions = $.extend( {
        container: $('body'),
        offset: 40,
        offset_y: 30,
        autoResize: false,
        itemWidth: $(this[0]).outerWidth(false),
        resizeDelay: 50,
      }, options);
  } else if(options) {
    this.wookmarkOptions = $.extend(this.wookmarkOptions, options);
  }
  
  // Layout variables.
  if(!this.containerWidth) 
    this.containerWidth = null;
  
  // Main layout function.
  this.wookmarkLayout = function() {
    // Calculate basic layout parameters.
    var columnWidth = this.wookmarkOptions.itemWidth + this.wookmarkOptions.offset;
    var containerWidth = this.wookmarkOptions.container.width();
    var columns = Math.floor((containerWidth+this.wookmarkOptions.offset)/columnWidth);
    var offset = this.wookmarkOptions.offset;
    var offset_y = this.wookmarkOptions.offset_y;
    
    // If container and column count hasn't changed, we can only update the columns.
    var bottom = 0;
    bottom = this.wookmarkLayoutFull(columnWidth, columns, offset, offset_y);
    window.resizing = false;
    
    // Set container height to height of the grid.
    this.wookmarkOptions.container.css('height', bottom+'px');
  };
  
  /**
   * Perform a full layout update.
   */
  this.wookmarkLayoutFull = function(columnWidth, columns, offset, offset_y) {

    // Prepare Array to store height of columns.
    var heights = [];
      if (window.heights==null || window.resizing) {
        window.heights = [];
        while(window.heights.length < columns) {
          window.heights.push(0);
        }
      }
    // Loop over items.
    var item, top, left, i=0, k=0, length=this.length, shortest=null, shortestIndex=null, bottom = 0;
    for(; i<length; i++ ) {
      item = $(this[i]);
      // Find the shortest column.
      shortest = null;
      shortestIndex = 0;
      for(k=0; k<columns; k++) {
        if(shortest == null || window.heights[k] < shortest) {
          shortest = window.heights[k];
          shortestIndex = k;
          if (shortest < 400)
              shortest = 0;
          }
      }
      // Center cards in the layout
      // always 3 columns -> 3x500 = 1500 pixels
      var contentWidth = columns * (500 + offset);
      var newOffest = ((this.wookmarkOptions.containerWidth - contentWidth)/2) + (offset / columns);
      item.removeClass('shown').css ({
        top: shortest+offset_y+'px',
        left: (shortestIndex*columnWidth + newOffest)+'px'
      });
      
      // Update column height.
      window.heights[shortestIndex] = shortest + item.outerHeight(true) + this.wookmarkOptions.offset_y;
      bottom = Math.max(bottom, window.heights[shortestIndex]);
    }
    return bottom;
  };
  
  // Apply layout
  this.wookmarkLayout();
  
  // Display items (if hidden).
  var i=0;
  $(this).show();
  for(i=0; i<this.length; i++ ) {
    var item = $('img', $(this[i]));
    var comment = $('.comment p', $(this[i]));
    item.delay(Math.floor(Math.random() * 2000)).slideDown(100, "easeOutElastic", function() {
      $(this).css("opacity", 1);
      $('p', $(this).next()).delay(1000).animate({
        "top": "0px",
        "height": "150px"
      }, 100);
    });
   }
};
