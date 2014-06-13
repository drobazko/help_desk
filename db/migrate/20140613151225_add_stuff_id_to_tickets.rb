class AddStuffIdToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :stuff_id, :integer
  end
end
