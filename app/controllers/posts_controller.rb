class PostsController < ApplicationController
	before_filter :load_data, except: [:index]

	def index
		@staff = Staff.find(params[:staff_id])
		@posts = @staff.posts.order(updated_at: :desc)
	end

	def edit
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
			format.html { staff_posts_path(@staff.id) }
			format.js
		end
	end

	private

	def load_data
		@post = Post.find(params[:id])
		@staff = @post.postable
	end

	def post_params
	  params.require(:post).permit(:body)
	end	
end
