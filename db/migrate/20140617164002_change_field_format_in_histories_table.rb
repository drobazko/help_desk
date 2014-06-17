class ChangeFieldFormatInHistoriesTable < ActiveRecord::Migration
  def change
  	change_column :histories, :body, :text
  end
end
