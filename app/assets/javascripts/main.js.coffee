$ -> 
  $(".remotable").on "change", ->
    $(this).closest('form').submit()

  $('#token').autocomplete
    serviceUrl: '/tickets/suggestions'
    onSelect: (value, data) -> 
      $("#sugg_form").attr('action', 'tickets/token/' + value).submit()

  $('.actions a, .pictures a, .new_post, .edit_staff')
    .on 'ajax:before', ->
      $('.ajax-loader').show()
    .on 'ajax:success', (data, status, xhr) ->
      $('.ajax-loader').hide()
    .on 'ajax:failure', (xhr, status, error) ->
      ;
    .on 'ajax:complete', ->
      $('.ajax-loader').hide()

  dest_elem = $('.highlight-me')  
  if dest_elem.length 
    $.scrollTo dest_elem, 1000, ->
      dest_elem.css
        transition: 'background-color 3s ease-in-out'
        "background-color": "white"
