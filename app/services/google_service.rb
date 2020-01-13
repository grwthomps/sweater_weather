class GoogleService
  def fetch_lat_long(location)
    response = Faraday.get('https://maps.googleapis.com/maps/api/geocode/json') do |req|
      req.params['address'] = location
      req.params['key'] = ENV['google_api_key']
    end

    JSON.parse(response.body, symbolize_names: true)
  end
end