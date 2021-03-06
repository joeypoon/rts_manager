class Tournament < ActiveRecord::Base
  has_many :rounds
  scope :upcoming, -> { where(played: false).order(created_at: :asc) }
  scope :recent, -> { where(played: true).order(updated_at: :desc) }

  validates :name, presence: true

  def start
    if self.players.count >= 4
      play_rounds
      award_money
      Tournament.generate(self.name, self.prize_pool)
    end
  end

  def max_players?
    self.players.count >= self.max_players
  end

  def self.generate(name, prize)
    name.gsub!(/\d+/,'')
    number = Tournament.where("name @@ :n", n: name).count + 1
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
      champ.save
      self.played = true
      self.save
    end

    def award_money
      ro16_multiplier = 0.012
      ro8_multiplier = 0.024
      ro4_multiplier = 0.048
      ro2_multiplier = 0.096
      champ_multiplier = 0.232
      team_multiplier = 0.1

      self.rounds.each do |r|
        r_multiplier = if r.winners.count == 16 then ro16_multiplier
          elsif r.winners.count == 8 then ro8_multiplier
          elsif r.winners.count == 4 then ro4_multiplier
          elsif r.winners.count == 2 then ro2_multiplier
          elsif r.winners.count == 1 then champ_multiplier
        end
        r.winners.each do |player|
          p = get_player player
          winnings = self.prize_pool * r_multiplier
          p.earnings += winnings

          if p.team
            p.team.cash += winnings * team_multiplier
            p.team.save
          end

          p.save
        end
      end
    end

    def get_player player_id
      Player.find_by id: player_id
    end
end
