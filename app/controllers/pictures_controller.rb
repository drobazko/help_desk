class PicturesController < ApplicationController
  def index
  end

  def new
  end

  def create
  end

  def update
  end

  def destroy
	@picture = Picture.find(params[:id])
	@picture.destroy
	
	respond_to do |format|
		format.js
	end
  end
end
