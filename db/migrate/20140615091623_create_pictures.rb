class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :file, null: false
      t.references :imageable, polymorphic: true, index: true 

      t.timestamps
    end
  end
end 
