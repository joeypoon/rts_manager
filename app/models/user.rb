class User < ActiveRecord::Base
  has_one :team
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validate :correct_token

  def correct_token
    unless token == 'f731917020d79cf5' then errors.add(:token, "Invalid token") end
  end
end
