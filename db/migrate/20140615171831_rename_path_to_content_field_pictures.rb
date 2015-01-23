class RenamePathToContentFieldPictures < ActiveRecord::Migration
  def change
  	rename_column :pictures, :path, :content
  end
end
