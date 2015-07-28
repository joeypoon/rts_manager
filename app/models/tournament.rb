class Tournament < ActiveRecord::Base
  has_many :rounds

  scope :upcoming, -> { where(winner: nil) }

  validates :name, uniqueness: true, presence: true

  def setup_rounds
    teams = self.teams
    i = 0
    j = 1
    while i < teams.count
      while j < teams.count
        Round.create!(tournament_id: self.id, team_one: teams[i], team_two: teams[j])
        j += 1
      end

      i += 1
      j = i + 1
    end
  end
end
