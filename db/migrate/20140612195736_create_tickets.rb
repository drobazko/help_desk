class CreateTickets < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.string :title
      t.string :short_title

      t.timestamps
    end

    create_table :tickets do |t|
      t.belongs_to :status

      t.string :customer_name, null: false
      t.string :customer_email, null: false
      t.string :token, null: false
      t.text :body, null: false
      t.string :subject, null: false
      
      t.timestamps
    end

    add_index :tickets, :status_id 
  end
end
