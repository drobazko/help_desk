class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
    	t.integer :stuff_id
    	t.text :body

      	t.timestamps
    end

    add_index :posts, :stuff_id, :unique => true 
  end
end
