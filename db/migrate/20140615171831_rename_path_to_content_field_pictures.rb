class RenamePathToContentFieldPictures < ActiveRecord::Migration
  def change
  	rename_column :Pictures, :path, :content
  end
end
