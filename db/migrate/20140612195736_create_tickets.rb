class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :customer_name, null: false
      t.string :customer_email, null: false
      t.string :reference, null: false
      t.text :body, null: false
      t.string :subject, null: false

      t.timestamps
    end
  end
end
