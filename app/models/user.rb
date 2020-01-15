class User < ApplicationRecord
  has_secure_password
  has_secure_token :api_key

  validates_presence_of :email, uniqueness: true
  validates :password_confirmation, length: { minimum: 1 }
end
