$ ->
  $pictures= $('#pictures')
  $pictures.imagesLoaded ->
    $pictures.masonry  
        itemSelector: '.picture'
        columnWidth: 30
        gutterWidth: 10
        gutterHeight: 10

  
