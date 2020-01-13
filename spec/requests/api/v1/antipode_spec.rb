require 'rails_helper'

RSpec.describe 'API V1 Antipode', :vcr, type: 'request' do
  describe "GET /api/v1/antipode" do
    it 'can return antipode info' do
      get '/api/v1/antipode?location=hongkong'

      expect(response).to be_successful

      antipode = JSON.parse(response.body)
      expect(antipode["data"]["attributes"]).not_to be_empty
    end
  end
end
