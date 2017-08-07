class CreateLists < ActiveRecord::Migration[5.0]
  def change
    create_table :lists do |t|
      t.text :content
      t.integer "user_id"
      t.string "name"

      t.timestamps
    end
    add_index("lists", 'user_id')
  end
end
