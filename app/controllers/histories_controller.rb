class HistoriesController < ApplicationController
  before_filter :authenticate_staff!

  def index
    @histories = History.all.order(created_at: :desc)
  end
end
