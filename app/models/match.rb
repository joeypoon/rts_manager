class Match < ActiveRecord::Base
  belongs_to :tournament

  def self.play
    p1 = Player.find_by id: self.player_one
    p2 = Player.find_by id: self.player_two
    p1_race = p1.race.downcase
    p2_race = p2.race.downcase
    p1_stats = p1.statistic
    p2_stats = p2.statistic
    p1_macro = p1_stats.macro
    p1_micro = p1_stats.micro
    p1_v = v_tree(p1, p2)
    p2_v = v_tree(p2, p1)
    p1_odds = p1_macro + (p1_micro * 0.5) + (p1_v * 0.5)
    p2_odds = p2_macro + (p2_micro * 0.5) + (p2_v * 0.5)
    winner = if (0..(p1_odds + p2_odds)).to_a.sample <= p1_odds
               win_count(p1, p2)
             else
               win_count(p2, p1)
             end
    self.winner = winner.name
    self.save
  end

  private

    def v_tree(p1, p2)
      if p2.race == "T"
        p1.vt
      elsif p2.race == "Z"
        p1.vz
      else
        p1.vp
      end
    end

    def win_count(p1, p2)
      p1.wins += 1
      p2.losses += 1
      p1.save
      p2.save
      p1
    end
end
