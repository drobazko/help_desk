class AddDepatmentRefToStaffs < ActiveRecord::Migration
  def change
    add_reference :staffs, :department, index: true
  end
end
