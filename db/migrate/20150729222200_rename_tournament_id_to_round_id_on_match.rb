class RenameTournamentIdToRoundIdOnMatch < ActiveRecord::Migration
  def change
    rename_column :matches, :tournament_id, :round_id
  end
end
