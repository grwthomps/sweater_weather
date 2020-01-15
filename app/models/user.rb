class User < ApplicationRecord
  has_secure_password
  has_secure_token :api_key

  validates_presence_of :email
  validates_uniqueness_of :email
  validates :password_confirmation, length: { minimum: 1 }
end
