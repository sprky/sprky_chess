class RemoveColorFromPlayer < ActiveRecord::Migration
  def change
    remove_column :players, :color, :boolean
  end
end
