class Player < ActiveRecord::Base
  belongs_to :team

  scope :teamless, -> { where(team: nil) }
  scope :active, -> { where(retired: false) }
end
