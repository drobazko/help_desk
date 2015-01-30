$(function() {
  var faye = new Faye.Client('http://localhost:9292/faye');
  faye.subscribe('/posts/new', function (data) {
      eval(data);
  });  

    $(".remotable").on("change", function(){
        $(this).closest('form').submit();
    });

  $('#token').autocomplete({
    serviceUrl:'/tickets/suggestions',
    onSelect: function(value, data){ 
      $("#sugg_form").attr('action', 'tickets/token/' + value).submit();
    }
  });

  $('.actions a, .pictures a, .new_post, .edit_staff')
    .on('ajax:before', function(){
      $('.ajax-loader').show();
    })
    .on('ajax:success', function(data, status, xhr) {
      $('.ajax-loader').hide();
    })
    .on('ajax:failure', function(xhr, status, error) {
    })
    .on('ajax:complete', function() {
      $('.ajax-loader').hide();
    });

  $.scrollTo($('.highlight-me'), 1000, function(){
    $('.highlight-me').css({transition: 'background-color 3s ease-in-out', "background-color": "white"});
  });

  

});