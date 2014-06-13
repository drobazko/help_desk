class AddIndexToPicture < ActiveRecord::Migration
  def change
  	add_index :pictures, [:imageable_id, :imageable_type], :unique => true
  end
end
