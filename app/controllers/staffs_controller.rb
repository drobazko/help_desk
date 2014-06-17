class StaffsController < ApplicationController
	before_filter :authenticate_staff!
	before_filter :authorize_admin!, except: [:edit, :update_password]

	def index
		@staffs = Staff.not_customer.not_admin
		@dpts = Department.all.map{|v| [v.title, v.id]}
	end

	def new
		@staff = Staff.new
	end

	def create_member
	    @staff = Staff.new(staff_params)

	    if @staff.save
	      redirect_to list_staff_path, notice: "Member created successfully."
	    else
	      render "new"
	    end
	end

	def edit
		@staff = current_staff
	end

	def update_password
		@staff = Staff.find(current_staff.id)
		if @staff.update(staff_params)
		  sign_in @staff, :bbypass => true
		  redirect_to edit_staff_path, notice: "Password changed"
		else
		  render "edit"
		end
	end

	def update
		@staff = Staff.find(params[:id])
		@staff.update(staff_params)
		render nothing: true
	end

	private

	def staff_params
		params.required(:staff).permit(:name, :email, :password, :password_confirmation, :only_department, :department_id)
	end

end
