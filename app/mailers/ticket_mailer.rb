class TicketMailer < ActionMailer::Base
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
    )
  end
end
