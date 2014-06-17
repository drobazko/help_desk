class PostsController < ApplicationController
	before_filter :load_data, only: [:update, :destroy, :edit]

	def index
		@ticket = Ticket.find(params[:ticket_id])
		@posts = @ticket.posts.order(updated_at: :desc)
	end

	def new
		@ticket = Ticket.find(params[:ticket_id])
		@post = Post.new
		@post.pictures.build
	end	

	def edit
		@post = Post.find(params[:id])
		@ticket = Ticket.find(params[:ticket_id]) 
	end

	def create
		@post = Post.new(post_params)
		@ticket = Ticket.find(params[:ticket_id]) 
		@post.staff = @ticket.staff
		@post.ticket = @ticket
		
		respond_to do |format|
			if @post.save
				format.html { redirect_to(ticket_posts_path(@ticket), notice: "The Post was Created") }
				format.js
			else
				format.html
				format.js
			end
		end
	end

	def update
		@ticket = Ticket.find(params[:ticket_id]) 
		if @post.update(post_params)
			redirect_to ticket_posts_path(@ticket), notice: "The Post was updated"
		else
			render 'edit'
		end
	end

 	def destroy
 		@post.destroy

		respond_to do |format|
			format.html { staff_posts_path(@staff) }
			format.js
		end
	end

	def for_ticket
	end	

	private

	def post_params
	  	params.require(:post).permit(:body, pictures_attributes: [:content])
	end	

	def load_data
		@post = Post.find(params[:id])
		@staff = @post.staff
	end

end
