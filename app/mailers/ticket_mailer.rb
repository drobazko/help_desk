class TicketMailer < ActionMailer::Base
	default from: "info@stockox.com"

	def receive_confirmation(ticket)
		@ticket = ticket
	    mail(
	      :to      => @ticket.customer_email,
	      :subject => 'Ticket have been received'
	    )
	end 	

	def new_reply(post)
		@post = post
		@ticket = @post.ticket
		@staff = @ticket.staff

	    mail(
	      :to      => @ticket.customer_email,
	      :subject => 'New Reply To Your Ticket'
	    ) #unless @post.staff.id == @ticket.staff.id 
		
	end
end
