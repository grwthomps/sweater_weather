class DarkSkyService
  def fetch_forecast(lat,lng)
    response = conn.get("#{lat},#{lng}") do |req|
      req.params['exclude'] = 'minutely,alert,flags'
    end

    parse_response(response)
  end

  def fetch_future_forecast(lat, lng, time)
    response = conn.get("#{lat},#{lng},#{time}") do |req|
      req.params['exclude'] = 'daily,hourly,minutely,alert,flags'
    end

    parse_response(response)
  end

  private

  def conn
    Faraday.new(url: "https://api.darksky.net/forecast/#{ENV['dark_sky_api_key']}")
  end

  def parse_response(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
