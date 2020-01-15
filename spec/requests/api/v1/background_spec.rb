require 'rails_helper'

RSpec.describe 'API V1 Background', :vcr, type: 'request' do
  describe "GET /api/v1/backgrounds" do
    it 'can return a background url' do
      get '/api/v1/backgrounds?location=denver,co'

      expect(response).to be_successful

      background = JSON.parse(response.body)
      expect(background["data"]["attributes"]["url"]).not_to be_empty
    end

    it 'can return a default background url if no image is found' do
      get '/api/v1/backgrounds?location=sldhfkhsfa;sh'

      expect(response).to be_successful

      background = JSON.parse(response.body)
      expect(background["data"]["attributes"]["url"]).not_to be_empty
    end
  end
end
