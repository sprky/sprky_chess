class RemoveNameFromPiece < ActiveRecord::Migration
  def change
    remove_column :pieces, :name, :string
  end
end
