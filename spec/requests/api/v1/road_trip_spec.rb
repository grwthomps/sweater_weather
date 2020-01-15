require 'rails_helper'

RSpec.describe 'API V1 Road Trip', type: 'request' do
  describe "POST /api/v1/road_trip" do
    WebMock.enable_net_connect!
    VCR.eject_cassette
    VCR.turn_off!(ignore_cassettes: true)

    before(:each) do
      @user = User.create(email: "joe@example.com", password: "password", password_confirmation: "password")
    end

    let(:valid_params) do
      {
        "origin": "Denver,CO",
        "destination": "Pueblo,CO",
        "api_key": @user.api_key
      }
    end

    it 'can return road trip info' do
      post '/api/v1/road_trip', params: valid_params
      expect(response).to have_http_status(200)

      trip = JSON.parse(response.body)

      expect(trip["data"]["attributes"]).not_to be_empty
      expect(trip["data"]["attributes"]["origin"]).to eq("Denver,CO")
      expect(trip["data"]["attributes"]["destination"]).to eq("Pueblo,CO")
    end
  end
end
