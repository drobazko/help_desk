class AddStaffRefToTickets < ActiveRecord::Migration
  def change
  	add_reference :tickets, :staff, index: true
  end
end
