class TicketsController < ApplicationController
  before_filter :load_ticket, only: [:show, :edit, :update]

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(ticket_params)
    if @ticket.save
      flash[:notice] = "Ticket created successfully. Message sent."
      redirect_to ticket_show_path(@ticket.token)
    else
      render "new"
    end
  end

  def show
  end

  def edit
  end

  def update
    if @ticket.update(ticket_params)
      redirect_to ticket_show_path(@ticket.token)
    else
      render 'edit'
    end
  end

 private
  def load_ticket
    @ticket = Ticket.find_by_token(params[:token])    
  end

  def ticket_params
    params.require(:ticket).permit(:customer_name, :customer_email, :subject, :body)
  end

end
