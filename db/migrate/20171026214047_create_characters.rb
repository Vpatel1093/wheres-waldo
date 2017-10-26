class CreateCharacters < ActiveRecord::Migration[5.0]
  def change
    create_table :characters do |t|
      t.string :name
      t.integer :top_left_x
      t.integer :top_left_y
      t.integer :bot_right_x
      t.integer :bot_right_y
      t.references :puzzle, foreign_key: true

      t.timestamps
    end
  end
end
