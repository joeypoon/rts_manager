class Statistic < ActiveRecord::Base
  belongs_to :player

  def talent_grade
    case self.talent
    when 1..25
      'F'
    when 26..50
      'D'
    when 51..75
      'C'
    when 76..85
      'B'
    when 86..95
      'A'
    else
      'S'
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
      when 1..30
        'F'
      when 30..45
        'D'
      when 46..55
        'C'
      when 56..65
        'B'
      when 66..75
        'A'
      else
        'S'
      end
    end
end
