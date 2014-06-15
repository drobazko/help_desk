class StaffsController < ApplicationController
	before_filter :authenticate_staff!

	def edit
		@staff = current_staff
	end

	def list
		@staffs = Staff.all
	end

	def update_password
		@staff = Staff.find(current_staff.id)
		if @staff.update(staff_params)
		  sign_in @staff, :bypass => true
		  redirect_to edit_staff_path, notice: "Password changed"
		else
		  render "edit"
		end
	end

	private

	def staff_params
		params.required(:staff).permit(:password, :password_confirmation)
	end

end
