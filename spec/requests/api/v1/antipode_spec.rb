require 'rails_helper'

RSpec.describe 'API V1 Antipode', :vcr, type: 'request' do
  describe "GET /api/v1/antipode" do
    it 'can return antipode info' do
      get '/api/v1/antipode?location=hongkong'

      expect(response).to be_successful

      antipode = JSON.parse(response.body)
      expect(antipode["data"]["attributes"]).not_to be_empty
      expect(antipode["data"]["attributes"]["location_name"]).not_to be_empty
      expect(antipode["data"]["attributes"]["forecast"]).not_to be_empty
      expect(antipode["data"]["attributes"]["forecast"]["summary"]).not_to be_empty
      expect(antipode["data"]["attributes"]["forecast"]["current_temperature"]).not_to be_nil
      expect(antipode["data"]["attributes"]["search_location"]).not_to be_empty
    end
  end
end
