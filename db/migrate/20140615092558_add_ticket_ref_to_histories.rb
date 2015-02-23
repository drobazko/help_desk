class AddTicketRefToHistories < ActiveRecord::Migration
  def change
    add_reference :histories, :ticket, index: true
  end
end
