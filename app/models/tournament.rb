class Tournament < ActiveRecord::Base
  has_many :rounds
  scope :upcoming, -> { where(winner: nil) }

  validates :name, uniqueness: true, presence: true

  def start
    start_rounds
  end

  private

    def start_rounds
      players = self.players.shuffle
      round_number = 1
      while players.count > 1
        round = self.rounds.create round_number: round_number, players: players
        round.start
        players = round.winners
        round_number += 1
      end
      self.winner = self.rounds.last.winners.last
      self.save
    end
end
