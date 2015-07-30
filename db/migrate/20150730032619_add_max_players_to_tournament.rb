class AddMaxPlayersToTournament < ActiveRecord::Migration
  def change
    add_column :tournaments, :max_players, :integer, default: 32
    add_column :rounds, :walk_overs, :integer, array: true, default: []
  end
end
