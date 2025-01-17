class AuthToken < ApplicationRecord
  validates :token, presence: :true
end
