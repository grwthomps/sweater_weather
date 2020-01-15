class ForecastFacade
  def self.retrieve_forecast(location)
    @geolocation_data = google_service.fetch_lat_long(location)

    return nil if invalid_request?

    parse_lat_lng(@geolocation_data)

    forecast_data = dark_sky_service.fetch_forecast(@lat,@lng)

    Forecast.new(forecast_data)
  end

  private

  def self.google_service
    google_service ||= GoogleService.new
  end

  def self.dark_sky_service
    dark_sky_service ||= DarkSkyService.new
  end

  def self.invalid_request?
    @geolocation_data[:status] == "ZERO_RESULTS" || @geolocation_data[:status] == "INVALID_REQUEST"
  end

  def self.parse_lat_lng(geolocation_data)
    @lat = geolocation_data[:results][0][:geometry][:location][:lat]
    @lng = geolocation_data[:results][0][:geometry][:location][:lng]
  end
end
