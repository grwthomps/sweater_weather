require 'rails_helper'

RSpec.describe 'API V1 Forecast', :vcr, type: 'request' do
  describe "GET /api/v1/forecast" do
    it 'can return forecast info' do
      get '/api/v1/forecast?location=denver,co'

      expect(response).to be_successful

      forecast = JSON.parse(response.body)
      expect(forecast["data"]["attributes"]).not_to be_empty
    end

    it 'returns error with invalid or empty request' do
      get '/api/v1/forecast?location='

      expect(response).to have_http_status(400)

      forecast = JSON.parse(response.body)
      expect(forecast["error"]).not_to be_empty
      expect(forecast["error"]).to eq("Invalid request or no results found.")
    end
  end
end
