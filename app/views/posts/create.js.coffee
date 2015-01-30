<% broadcast '/posts/new' do %>
	$('.ticket-<%= @ticket.token %> .no-posts').remove();

	$('<div></div>')
		.css({'backgroundColor' : '#ff9f5f'})
		.prependTo('.ticket-<%= @ticket.token %> .posts')
		.hide()
		.append('<%=j render @post %>')
		.fadeIn('slow')
		.css({transition: 'background-color 3s ease-in-out', "background-color": "white"});
<% end %>
