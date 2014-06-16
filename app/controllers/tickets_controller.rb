class TicketsController < ApplicationController
  before_filter :authenticate_staff!, :set_section_type, only: [:index]
  before_filter :load_ticket, only: [:show, :edit, :update]

  def index
    @tickets = Ticket.with_department(current_staff).send(params[:section])
    #@tickets = Ticket.closed
    

  end

  def broadcast
  end

  def new
    @ticket = Ticket.new
    @ticket.pictures.build
  end

  def create
    @ticket = Ticket.new(ticket_params)

    #@ticket.init_sp(ticket_show_path(Ticket.generate_id), request)
    #@ticket.errors.add(:base, "Are You Spammer?") if @ticket.spam?
    
    if @ticket.errors.empty? and @ticket.save
      #TicketMailer.receive_confirmation(@ticket).deliver
      redirect_to ticket_show_path(@ticket.token), notice: "Ticket created successfully. Message sent."
    else
      render "new"
    end
  end

  def show
    @post = Post.new
    @post.pictures.build
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

  def suggestions
    @tikets = Ticket.where("token like ?", "#{params[:query]}%")
  
    suggestions = []
    data = []
    @tikets.each{|v|
      suggestions << v[:token]
      data << v[:id]
    }

    res = {
      'query' => 'Li',
      'suggestions' => suggestions,
      'data' => data
    }

    render :text => res.to_json
  end

  def search_form
    @tickets = Ticket.none
  end

  def search
    @tickets = Ticket.search(params[:query])
    render 'search_form'
  end

  private
    def load_ticket
      @ticket = Ticket.find_by_token(params[:token])    
      @pictures = @ticket.pictures.any? ? @ticket.pictures.clone : Picture.none
      @staff = current_staff || Staff.find_by_email(@ticket.customer_email)
    end

    def ticket_params
      params.require(:ticket).permit(:customer_name, :customer_email, :subject, :body, :department_id, pictures_attributes: [:content])
    end

    def set_section_type
      params[:section] ||= "unassigned"
    end
    
end
