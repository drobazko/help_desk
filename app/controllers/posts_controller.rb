class PostsController < ApplicationController
	before_filter :load_data, only: [:update, :destroy, :edit]

	def index
		@staff = Staff.find(params[:staff_id])
		@posts = @staff.posts.order(updated_at: :desc)
	end

	def new
	end	

	def edit
	end	

	def create
		@post = Post.new(post_params)
		@post.staff = Staff.find(params[:staff_id])
		@ticket = Ticket.find_by_token(params[:ticket_token])
		@post[:ticket_id] = @ticket.id
		@post.save

		respond_to do |format|
			format.js
		end

	end

	def update
		if @post.update(post_params)
			redirect_to edit_staff_post_path(@staff, @post), notice: "The Post was updated"
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

	private

	def post_params
	  	params.require(:post).permit(:body, pictures_attributes: [:content])
	end	

	def load_data
		@post = Post.find(params[:id])
		@staff = @post.staff
	end

end
