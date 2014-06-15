class TicketsController < ApplicationController
  before_filter :load_ticket, only: [:show, :edit, :update]
  before_filter :authenticate_staff!, only: [:index]

  def index
    @tickets = Ticket.all
  end

  def new
    @ticket = Ticket.new
    @ticket.pictures.build
  end

  def create
    @ticket = Ticket.new(ticket_params)

    @ticket.init_sp(ticket_show_path(Ticket.generate_id), request)

    @ticket.errors.add(:base, "Are You Spammer?") if @ticket.spam?
    
    if @ticket.errors.empty? and @ticket.save
      TicketMailer.receive_confirmation(@ticket).deliver
      redirect_to ticket_show_path(@ticket.token), notice: "Ticket created successfully. Message sent."
    else
      render "new"
    end
  end

  def show
  end

  def edit
    @ticket.pictures.build
  end

  def update
    if @ticket.update(ticket_params)
      redirect_to ticket_show_path(@ticket.token), notice: "The Ticket was updated"
    else
      render 'edit'
    end
  end

 private
  def load_ticket
    @ticket = Ticket.find_by_token(params[:token])    
    @pictures = @ticket.pictures.any? ? @ticket.pictures.clone : Picture.none
  end

  def ticket_params
    params.require(:ticket).permit(:customer_name, :customer_email, :subject, :body, :department_id, pictures_attributes: [:content])
  end
end
