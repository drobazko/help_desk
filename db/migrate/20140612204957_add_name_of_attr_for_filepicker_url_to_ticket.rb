class AddNameOfAttrForFilepickerUrlToTicket < ActiveRecord::Migration
  def change
  	add_column :tickets, :filepicker_url, :string
  end
end

