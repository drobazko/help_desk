class TicketsController < ApplicationController
  def index
  end

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(params)
  end

  def show
  end

  def edit
  end

  def update
  end
end
