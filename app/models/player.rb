class Player < ActiveRecord::Base
  belongs_to :team
  has_one :statistic

  scope :teamless, -> { where(team: nil) }
  scope :active, -> { where(retired: false) }

  validates :username, uniqueness: true, presence: true

  def self.create_player
    name = [Faker::App.name, Faker::Team.creature, Faker::Lorem.word].sample + [Faker::App.name, Faker::Team.creature, Faker::Lorem.word].sample
    race = [:Z, :T, :P].sample
    age = (12..20).to_a.sample
    salary = (700..1500).to_a.sample
    talent = (1..100).to_a.sample
    vt = (30..70).to_a.sample
    vz = (30..70).to_a.sample
    vp = (30..70).to_a.sample
    micro = (30..70).to_a.sample
    macro = (30..70).to_a.sample
    player = Player.create!(username: name, age: age, race: race, salary: salary)
    Statistic.create!(player_id: player.id, talent: talent, vt: vt, vz: vz, vp: vp, micro: micro, macro: macro)
  end

end
