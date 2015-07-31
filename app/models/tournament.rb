class Tournament < ActiveRecord::Base
  has_many :rounds
  scope :upcoming, -> { where(played: false) }
  scope :recent, -> { where(played: true) }

  validates :name, presence: true

  def start
    start_rounds
  end

  def max_players?
    self.players.count >= self.max_players
  end

  def self.generate(name, prize)
    number = Tournament.where(name: name).count + 1
    Tournament.create(name: "#{name} #{number}", prize_pool: prize)
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
      self.played = true
      self.save
    end
end
