require 'rails_helper'

describe 'Forecast API', :vcr do
  it 'can return forecast info' do
    get '/api/v1/forecast?location=denver,co'

    expect(response).to be_successful

    forecast = JSON.parse(response.body)
    expect(forecast["data"]["attributes"]).not_to be_empty
  end
end
