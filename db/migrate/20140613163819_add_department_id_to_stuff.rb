class AddDepartmentIdToStuff < ActiveRecord::Migration
  def change
  	add_column :stuffs, :department_id, :integer
  	add_index :stuffs, :department_id, :unique => true
  end
end
