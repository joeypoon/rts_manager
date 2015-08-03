class Team < ActiveRecord::Base
  belongs_to :user
  has_many :players

  scope :sort_by_wins, -> { order(wins: :desc, losses: :asc) }
  scope :active, -> { where(bankrupt: false, deleted: false) }

  validates :name, presence: true, uniqueness: true

  def operating_costs
    self.players.map { |p| p.salary }.reduce(:+)
  end

  def total_wins
    self.players.map { |p| p.wins }.reduce(:+)
  end

  def self.subtract_costs
    Team.active.each do |t|
      t.cash -= t.operating_costs
      t.boom if t.cash <= 0
      t.save
    end
  end

  def boom
    self.bankrupt = true
    self.players.update_all team_id: nil
    self.user_id = nil
    self.save
    redirect_to proc { new_team_path }, alert: "#{self.name} has gone bankrupt."
  end
end
