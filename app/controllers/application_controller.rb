class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	alias_method :current_user, :current_staff
	
	def after_sign_in_path_for(resource)
		tickets_path
	end

    def authorize_admin!
    	authenticate_staff!
    	unless current_staff.admin?
    		flash[:alert] = "You have to be administrator"
    		redirect_to root_path
    	end
    end
end
