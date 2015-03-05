class AddTypeToPieces < ActiveRecord::Migration
  def change
  	add_column :pieces, :type, :string
  end
end
