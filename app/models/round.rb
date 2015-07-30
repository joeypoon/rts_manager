class Round < ActiveRecord::Base
  belongs_to :tournament
  has_many :matches

  def start
    setup_matches
    self.matches.each do |m|
      m.play
      self.winners << m.winner
      self.save
    end
  end

  private
    def setup_matches
      players = Array.new self.players
      while players.count >= 2
        player_one = players.shift
        player_two = players.shift
        if players.count == 1
          self.winners << players.last
          self.save
        end
        self.matches.create player_one: player_one, player_two: player_two
      end
    end
end
