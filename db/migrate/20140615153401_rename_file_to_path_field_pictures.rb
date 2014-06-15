class RenameFileToPathFieldPictures < ActiveRecord::Migration
  def change
  	rename_column :Pictures, :file, :path
  end
end
