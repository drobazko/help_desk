$('.no-posts').remove();
$('.posts').prepend('<%=j render @post %>').fadeIn('slow');