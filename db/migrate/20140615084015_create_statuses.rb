class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.string :title, null: false
      t.string :short_title, null: false

      t.timestamps
    end
  end
end
