$(function () {
      // Initialize the jQuery File Upload widget:
      $('#fileupload').fileupload({
        paramName: 'document[file]'
      });
      // 
      // Load existing files:
      $.getJSON($('#fileupload').prop('action'), function (files) {
        var fu = $('#fileupload').data('blueimpFileupload'), 
          template;
        fu._adjustMaxNumberOfFiles(-files.length);
        console.log(files);
        template = fu._renderDownload(files)
          .appendTo($('#fileupload .files'));
        // Force reflow:
        fu._reflow = fu._transition && template.length &&
          template[0].offsetWidth;
        template.addClass('in');
        $('#loading').remove();
      });

  });
