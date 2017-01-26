class SwitchStatustoStateinPieces < ActiveRecord::Migration
  def change
  	remove_column :pieces, :status, :string
  	add_column :pieces, :state, :string
  end
end
