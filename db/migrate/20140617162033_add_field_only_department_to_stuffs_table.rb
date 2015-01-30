class AddFieldOnlyDepartmentToStuffsTable < ActiveRecord::Migration
  def change
    add_column :staffs, :only_department, :integer, default: 0
  end
end
