class Round < ActiveRecord::Base
  belongs_to :tournament
  has_many :matches
  has_many :teams

  def setup_matches
    team_one = self.team_one_players
    i = 0
    while i < self.team_one_players.count
      Match.create!(round_id: self.id, player_one: , player_two: )
    end
  end
end
