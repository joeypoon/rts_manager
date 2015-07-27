class Match < ActiveRecord::Base
  belongs_to :round
  has_many :players
end
