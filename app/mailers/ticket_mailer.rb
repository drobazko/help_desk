class TicketMailer < ActionMailer::Base
	default from: "info@stockox.com"

	def receive_confirmation(ticket)
		@ticket = ticket
	    mail(
	      :to      => @ticket.customer_email,
	      :subject => 'Ticket have been received'
	    )
			
	end 	
end
