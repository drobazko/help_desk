class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :customer_name, null: false
      t.string :customer_email, null: false
      t.string :token, null: false, :unique => true
      t.text :body, null: false
      t.string :subject, null: false
      t.string :permalink
      t.string :remote_ip
      t.string :user_agent
      t.text :referrer

      t.timestamps
    end

    add_index :tickets, :token, :unique => true
  end
end
