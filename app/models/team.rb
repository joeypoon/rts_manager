class Team < ActiveRecord::Base
  belongs_to :user
  has_many :players

  def operating_costs
    self.players.map { |p| p.salary }.reduce(:+)
  end
end
