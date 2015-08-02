class Team < ActiveRecord::Base
  belongs_to :user
  has_many :players

  scope :sort_by_wins, -> { order(wins: :desc, losses: :asc) }

  validates :name, presence: true, uniqueness: true

  def operating_costs
    self.players.map { |p| p.salary }.reduce(:+)
  end

  def total_wins
    self.players.map { |p| p.wins }.reduce(:+)
  end
end
