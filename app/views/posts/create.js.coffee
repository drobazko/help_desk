$('.no-posts').remove();
$('.posts').prepend('<%=j render @post %>').fadeIn('slow');
<% broadcast 'posts/new' do %>
	$('.user-win .posts').prepend('<%=j render @post %>').fadeIn('slow');
<% end %>
