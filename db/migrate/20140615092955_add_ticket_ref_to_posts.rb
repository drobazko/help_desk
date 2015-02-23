class AddTicketRefToPosts < ActiveRecord::Migration
  def change
    add_reference :posts, :ticket, index: true
  end
end
