class Team < ActiveRecord::Base
  belongs_to :user
  has_many :players

  validates :name, presence: true, uniqueness: true

  def operating_costs
    self.players.map { |p| p.salary }.reduce(:+)
  end

  def total_wins
    self.players.map { |p| p.wins }.reduce(:+)
  end
end
