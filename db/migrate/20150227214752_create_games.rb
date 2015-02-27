class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.string :state
      t.integer :white_player_id
      t.integer :black_player_id
      t.integer :winning_player_id

      t.timestamps
    end
  end
end
