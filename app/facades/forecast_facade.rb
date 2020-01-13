class ForecastFacade
  def retrieve_forecast(location)
    google_service = GoogleService.new
    geolocation_data = google_service.fetch_lat_long(location)

    lat = geolocation_data[:results][0][:geometry][:location][:lat]
    lng = geolocation_data[:results][0][:geometry][:location][:lng]

    dark_sky_service = DarkSkyService.new
    forecast_data = dark_sky_service.fetch_forecast(lat,lng)

    Forecast.new(forecast_data)
  end
end
