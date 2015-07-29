class RenameRoundIdToTournamentIdOnMatches < ActiveRecord::Migration
  def change
    rename_column :matches, :round_id, :tournament_id
  end
end
