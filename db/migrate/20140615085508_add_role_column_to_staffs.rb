class AddRoleColumnToStaffs < ActiveRecord::Migration
  def change
    add_column :staffs, :role, :string, default: 'member', null: false
  end
end
