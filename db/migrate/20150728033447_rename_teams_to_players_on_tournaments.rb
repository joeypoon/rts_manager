class RenameTeamsToPlayersOnTournaments < ActiveRecord::Migration
  def change
    rename_column :tournaments, :teams, :players
  end
end
