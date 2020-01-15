class GoogleService
  def fetch_lat_long(location)
    response = conn.get('geocode/json') do |req|
      req.params['address'] = location
    end

    parse_response(response)
  end

  def fetch_directions(origin, destination)
    response = conn.get('directions/json') do |req|
      req.params['origin'] = origin
      req.params['destination'] = destination
    end

    parse_response(response)
  end

  private

  def conn
    Faraday.new(
      url: 'https://maps.googleapis.com/maps/api',
      params: {'key' => ENV['google_api_key']}
    )
  end

  def parse_response(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
