$('#edit_ticket_<%= @ticket.id %> .take').html('taken by <%= @ticket.taken_tickets.name %>');
$('.ajax-loader').hide();