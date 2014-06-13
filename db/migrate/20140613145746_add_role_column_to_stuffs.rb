class AddRoleColumnToStuffs < ActiveRecord::Migration
  def change
    add_column :stuffs, :role, :string, :default => 'member', :null => false 
  end
end
