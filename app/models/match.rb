class Match < ActiveRecord::Base
  belongs_to :round

  def play
    macro_multipler = 3
    micro_multiplier = 2.3
    v_multiplier = 1.8
    p1 = Player.includes(:statistic).find_by id: self.player_one
    p2 = Player.includes(:statistic).find_by id: self.player_two
    p1_race = p1.race.downcase
    p2_race = p2.race.downcase
    p1_stats = p1.statistic
    p2_stats = p2.statistic
    p1_macro = p1_stats.macro
    p1_micro = p1_stats.micro
    p2_macro = p2_stats.macro
    p2_micro = p2_stats.micro
    p1_v = v_tree(p1, p2)
    p2_v = v_tree(p2, p1)
    p1_odds = (p1_macro * macro_multipler) + (p1_micro * micro_multiplier) + (p1_v * v_multiplier)
    puts "p1: #{p1_odds}"
    p2_odds = (p2_macro * macro_multipler) + (p2_micro * micro_multiplier) + (p2_v * v_multiplier)
    puts "p2: #{p2_odds}"
    winner = if (1..(p1_odds + p2_odds)).to_a.sample <= p1_odds
               win_count(p1, p2)
             else
               win_count(p2, p1)
             end
    self.winner = winner.id
    puts winner.username
    self.save
  end

  private

    def v_tree(p1, p2)
      if p2.race == "T"
        p1.statistic.vt
      elsif p2.race == "Z"
        p1.statistic.vz
      else
        p1.statistic.vp
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
