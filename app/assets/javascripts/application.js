// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.remotipart
//= require turbolinks
//= require_tree .


$(function() {
	//var faye = new Faye.Client('http://localhost:9292/faye');
	//faye.subscribe('/messages/new', function (data) {
	//	eval(data);
	//});	

	$('#token').autocomplete({
		serviceUrl:'/tickets/suggestions',
		onSelect: function(value, data){ 
			$("#sugg_form input").remove();
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


    $(".edit_staff input, .edit_staff select").on("change", function(){
        $(this).closest('form').submit();
    });
});