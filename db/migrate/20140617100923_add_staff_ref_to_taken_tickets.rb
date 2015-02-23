class AddStaffRefToTakenTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :taken_staff_id, :integer
    add_index :tickets, :taken_staff_id
  end
end
