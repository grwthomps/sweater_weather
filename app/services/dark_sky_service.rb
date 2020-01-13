class DarkSkyService
  def fetch_forecast(lat,lng)
    response = Faraday.get("https://api.darksky.net/forecast/#{ENV['dark_sky_api_key']}/#{lat},#{lng}") do |req|
      req.params['exclude'] = 'minutely,alert,flags'
    end

    JSON.parse(response.body, symbolize_names: true)
  end
end
