require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should have_secure_password }
    it { should have_secure_token(:api_key) }

    it do
      should validate_length_of(:password_confirmation).
        is_at_least(1).
        on(:create)
    end
  end
end
