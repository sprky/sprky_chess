class RemoveCapturedFromPiece < ActiveRecord::Migration
  def change
  	remove_column :pieces, :captured?, :boolean
  end
end
