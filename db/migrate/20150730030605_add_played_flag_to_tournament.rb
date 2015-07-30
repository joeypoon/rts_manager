class AddPlayedFlagToTournament < ActiveRecord::Migration
  def change
    add_column :tournaments, :played, :boolean, default: false
  end
end
