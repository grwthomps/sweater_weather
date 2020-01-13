class GoogleService
  def fetch_lat_long(location)
    response = conn.get do |req|
      req.params['address'] = location
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  def fetch_city(lat,lng)
    latlng = "#{lat},#{lng}"

    response = conn.get do |req|
      req.params['latlng'] = latlng
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def conn
    Faraday.new(
      url: 'https://maps.googleapis.com/maps/api/geocode/json',
      params: {'key' => ENV['google_api_key']}
    )
  end
end
