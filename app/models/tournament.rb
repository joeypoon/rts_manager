class Tournament < ActiveRecord::Base
  has_many :rounds
  scope :upcoming, -> { where(played: false) }
  scope :recent, -> { where(played: true) }

  validates :name, presence: true

  def start
    play_rounds
  end

  def max_players?
    self.players.count >= self.max_players
  end

  def self.generate(name, prize)
    number = Tournament.where(name: name).count + 1
    Tournament.create(name: "#{name} #{number}", prize_pool: prize)
  end

  private

    def play_rounds
      players = self.players.shuffle
      round_number = 1
      while players.count > 1
        round = self.rounds.create round_number: round_number, players: players
        round.start
        players = round.winners
        round_number += 1
      end

      champ = Player.find_by id: self.rounds.last.winners.last
      self.winner = champ.username
      champ.earnings += self.prize_pool
      if champ.team
        champ.team.cash += (self.prize_pool * 0.10)
        champ.team.save
      end
      champ.save
      self.played = true
      self.save
    end

    def award_money
      self.rounds.reverse.each do |r|
        r.players.each do |p|
          #TODO
          # 15 ro16
          # 30 ro8
          # 60 ro4
          # 280 f
        end
      end
    end
end
