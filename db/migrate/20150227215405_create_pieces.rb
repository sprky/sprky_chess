class CreatePieces < ActiveRecord::Migration
  def change
    create_table :pieces do |t|
      t.string :name
      t.integer :x_position
      t.integer :y_position
      t.string :symbol
      t.boolean :color
      t.boolean :captured?
      t.integer :player_id
      t.integer :game_id

      t.timestamps
    end
  end
end
