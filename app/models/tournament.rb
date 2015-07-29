class Tournament < ActiveRecord::Base
  has_many :matches
  scope :upcoming, -> { where(winner: nil) }

  validates :name, uniqueness: true, presence: true

  def start
    setup_matches(self)
    self.matches.each do |m|
      m.play
    end
  end

  private
    def setup_matches(tournament)
      players = tournament.players
      while players.count >= 2
        player_one = players.delete(players.sample)
        player_two = players.delete(players.sample)
        Match.create!(tournament_id: tournament.id, player_one: player_one, player_two: player_two)
      end
    end
end
