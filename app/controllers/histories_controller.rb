class HistoriesController < ApplicationController
	before_filter :authenticate_staff!

	def index
		History.all.order(created_at: :desc)
	end
end
