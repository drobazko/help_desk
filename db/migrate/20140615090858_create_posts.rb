class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
    	t.text :body, null: false
    	t.references :postable, polymorphic: true, index: true

    	t.timestamps
    end
  end
end
