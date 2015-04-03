class TicketsController < ApplicationController
  before_filter :authenticate_staff!, only: [:index, :suggestions, :search_form, :search, :take, :change_status]
  before_filter :set_section_type
  before_filter :load_ticket, only: [:show, :edit, :update, :change_status]

  def index
    @tickets = Ticket
      .with_department(current_staff)
      .send(params[:section])
      .order(updated_at: :desc)
      .page(params[:page])
  end

  def broadcast
  end

  def new
    @ticket = Ticket.new
    @ticket.pictures.build
  end

  def create
    @ticket = Ticket.new(ticket_params)

    @ticket.init_sp(show_tickets_path(Ticket.generate_id), request)
    @ticket.errors.add(:base, "Are You Spammer?") if @ticket.spam?
    
    if @ticket.errors.empty? and @ticket.save
      save_images @ticket

      TicketMailer.receive_confirmation(@ticket).deliver
      redirect_to show_tickets_path(@ticket.token), notice: "Ticket created successfully. Message sent."
    else
      render "new"
    end
  end

  def show
    @post = Post.new
    @post.pictures.build
    @posts = @ticket.posts.order(updated_at: :desc)
  end

  def edit
    @ticket.pictures.build
  end

  def update
    if @ticket.update(ticket_params)
      save_images @ticket

      redirect_to show_tickets_path(@ticket.token), notice: "The Ticket was updated"
    else
      render 'edit'
    end
  end

  def take
    @ticket = Ticket.find(params[:id])
    @ticket.taken_tickets = current_staff
    @ticket.save
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
    @tickets = params[:query].present? ? Ticket.search(params[:query]).records : Ticket.none
    render 'search_form'
  end

  def change_status
    @ticket.status = Status.find(params[:ticket][:status_id])
    @ticket.save
    render nothing: true
  end

  private
    def load_ticket
      @ticket = Ticket.find_by_token(params[:token] || params[:id])    
      @pictures = @ticket.pictures.any? ? @ticket.pictures.clone : Picture.none
      @staff = current_staff || Staff.find_by_email(@ticket.customer_email)
    end

    def ticket_params
      params.require(:ticket).permit(:customer_name, :customer_email, :subject, :body, :department_id, :status_id, pictures_attributes: [:content])
    end

    def set_section_type
      params[:section] ||= "unassigned"
    end
end
