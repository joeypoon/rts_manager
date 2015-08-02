class Match < ActiveRecord::Base
  belongs_to :round

  def play
    macro_multipler = 3
    micro_multiplier = 2.3
    v_multiplier = 1.8
    p1 = Player.find_by id: self.player_one
    p2 = Player.find_by id: self.player_two
    p1_race = p1.race.downcase
    p2_race = p2.race.downcase
    p1_v = v_tree(p1, p2)
    p2_v = v_tree(p2, p1)
    p1_odds = (p1.macro * macro_multipler) + (p1.micro * micro_multiplier) + (p1_v * v_multiplier)
    p2_odds = (p2.macro * macro_multipler) + (p2.micro * micro_multiplier) + (p2_v * v_multiplier)
    winner = if (1..(p1_odds + p2_odds)).to_a.sample <= p1_odds
               win_count(p1, p2)
             else
               win_count(p2, p1)
             end
    self.winner = winner.id
    self.save
  end

  def p1
    Player.find_by id: self.player_one
  end

  def p2
    Player.find_by id: self.player_two
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
      if p1.team
        p1.team.wins += 1
        p1.team.save
      end
      p2.losses += 1
      if p2.team
        p2.team.losses += 1
        p2.team.save
      end
      p1.save
      p2.save
      p1
    end
end
