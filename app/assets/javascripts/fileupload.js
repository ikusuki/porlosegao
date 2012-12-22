$(function() {

    $('.direct-upload').each(function() {
    var form = $(this)

    $(this).fileupload({
      url: form.attr('action'),
      type: 'POST',
      autoUpload: true,
      process:[
      {
        action: 'load',
        fileTypes: /^image\/(gif|jpeg|png)$/,
        maxFileSize: 5000000
      },
      {
        action: 'resize',
        maxWidth: 500,
        maxHeight: 3000
      },
      {
        action: 'save'
      }
      ],
      dataType: 'xml', // This is really important as s3 gives us back the url of the file in a XML document
      add: function (event, data) {
        window.showMessage('warning');
        $(this).fileupload('process', data).done(function () {
        $.ajax({
          url: "/signed_urls",
          type: 'GET',
          dataType: 'json',
          data: {doc: {title: data.files[0].name}}, // send the file name to the server so it can generate the key param
          async: false,
          success: function(data) {
            // Now that we have our data, we update the form so it contains all
            // the needed data to sign the request
            form.find('input[name=key]').val(data.key)
            form.find('input[name=policy]').val(data.policy)
            form.find('input[name=signature]').val(data.signature)
          }
        })
        data.submit();
      })},
      send: function(e, data) {
        $('#upload_message').html('Subiendo... parriba... parriba...');
        $('.progress').fadeIn();
      },
      progress: function(e, data){
        // This is what makes everything really cool, thanks to that callback
        // you can now update the progress bar based on the upload progress
        var percent = Math.round((e.loaded / e.total) * 100)
        $('.bar').css('width', percent + '%')
      },
      fail: function(e, data) {
        $('#upload_message').html('Ná, no ha podido ser!! error raruno!!')
        console.log('fail')
      },
      success: function(data) {
        $('#upload_message').html('Hecho!')
        $('.warning').delay(3000).animate({
          top: -200,
        }, 500)

        // Here we get the file url on s3 in an xml doc
        var url = $(data).find('Location').text()

        $('#real_file_url').val(url) // Update the real input in the other form
      },
      done: function (event, data) {
        $.ajax({
          type: 'POST',
          url: "/pictures",
          beforeSend: function(jqXHR, settings) {
            jqXHR.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
          },
          data: { url: $('#uploaded_file_path').val()},
          success: function(data) { 
            // window.location = "/cromosImagen/" + data.id;
            window.location = "/pictures";
          }})
        
        $('.progress').fadeOut(3000, function() {
          $('.bar').css('width', 0)
        })
      },
    })
  })
})