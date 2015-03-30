class AddStateToPiece < ActiveRecord::Migration
  def change
  	add_column :pieces, :state, :string
  end
end
