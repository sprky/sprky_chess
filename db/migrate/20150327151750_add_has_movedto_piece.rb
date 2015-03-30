class AddHasMovedtoPiece < ActiveRecord::Migration
  def change
  	add_column :pieces, :has_moved, :string
  end
end
