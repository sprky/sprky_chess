class AddColumnsToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :provider, :string
    add_column :players, :uid, :string
  end
end
