class AddIndexToTickets < ActiveRecord::Migration
  def change
    add_index :tickets, :stuff_id, :unique => true 
  end
end
