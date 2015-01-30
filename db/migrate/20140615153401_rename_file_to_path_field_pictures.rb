class RenameFileToPathFieldPictures < ActiveRecord::Migration
  def change
    rename_column :pictures, :file, :path
  end
end
