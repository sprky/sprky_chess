class SwitchHasMovedToStatusInPieces < ActiveRecord::Migration
  def change
  	remove_column :pieces, :has_moved, :string
  	add_column :pieces, :status, :string
  end
end
