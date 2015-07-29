class AddPlayersToMatch < ActiveRecord::Migration
  def change
    add_column :matches, :player_one, :integer
    add_column :matches, :player_two, :integer
  end
end
