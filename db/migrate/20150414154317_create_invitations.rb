class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :game_id
      t.integer :player_id
      t.string :guest_player_email

      t.timestamps
    end
  end
end
