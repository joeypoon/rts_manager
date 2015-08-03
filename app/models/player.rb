class Player < ActiveRecord::Base
  belongs_to :team

  scope :teamless, -> { where(team_id: nil) }
  scope :active, -> { where(retired: false) }
  scope :sort_by_wins, -> { order(wins: :desc, losses: :asc) }

  validates :username, uniqueness: true, presence: true

  def self.create_player
    name = [Faker::App.name, Faker::Team.creature, Faker::Lorem.word].sample + [Faker::App.name, Faker::Team.creature, Faker::Lorem.word].sample
    race = [:Z, :T, :P].sample
    age = (11..20).to_a.sample
    salary = (700..1500).to_a.sample
    talent = (1..100).to_a.sample
    vt = (30..70).to_a.sample
    vz = (30..70).to_a.sample
    vp = (30..70).to_a.sample
    micro = (30..70).to_a.sample
    macro = (30..70).to_a.sample
    player = Player.create!(username: name, age: age, race: race, salary: salary, talent: talent, vt: vt, vz: vz, vp: vp, micro: micro, macro: macro)
  end

  def leave_team
    self.team = nil
    self.save
  end

  def raise_stats opponent
    if opponent.race == "T"
      raise_stat("vt", opponent)
    elsif opponent.race == "Z"
      raise_stat("vz", opponent)
    elsif opponent.race == "P"
      raise_stat("vp", opponent)
    end
    raise_stat("macro", opponent)
    raise_stat("micro", opponent)
  end

  def talent_grade
    case self.talent
    when 1..25 then 'F'
    when 26..50 then 'D'
    when 51..75 then 'C'
    when 76..85 then 'B'
    when 86..95 then 'A'
    else 'S'
    end
  end

  def vt_grade
    skill_grade(self.vt)
  end

  def vz_grade
    skill_grade(self.vz)
  end

  def vp_grade
    skill_grade(self.vp)
  end

  def macro_grade
    skill_grade(self.macro)
  end

  def micro_grade
    skill_grade(self.micro)
  end

  private

    def skill_grade(skill)
      case skill
      when 1..30 then 'F'
      when 30..45 then 'D'
      when 46..55 then 'C'
      when 56..65 then 'B'
      when 66..75 then 'A'
      else 'S'
      end
    end

    def opponent_v opponent
      if self.race == "T"
        opponent.vt
      elsif self.race == "Z"
        opponent.vz
      elsif self.race == "P"
        opponent.vp
      end
    end

    def raise_stat stat, opponent
      stat_multiplier = 0.01
      if stat == "macro"
        self.macro += (talent * stat_multiplier) * (opponent.macro * stat_multiplier)
      elsif stat == "micro"
        self.micro += (talent * stat_multiplier) * (opponent.micro * stat_multiplier)
      elsif stat == "vt"
        self.vt += (talent * stat_multiplier) * (opponent_v(opponent) * stat_multiplier)
      elsif stat == "vz"
        self.vz += (talent * stat_multiplier) * (opponent_v(opponent) * stat_multiplier)
      elsif stat == "vp"
        self.vp += (talent * stat_multiplier) * (opponent_v(opponent) * stat_multiplier)
      end

      self.save
    end
end
