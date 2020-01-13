class AntipodeFacade
  def initialize(location)
    google_service = GoogleService.new
    geolocation_data = google_service.fetch_lat_long(location)

    lat = geolocation_data[:results][0][:geometry][:location][:lat]
    lng = geolocation_data[:results][0][:geometry][:location][:lng]
    origin_city = geolocation_data[:results][0][:formatted_address]

    dark_sky_service = DarkSkyService.new
    forecast_data = dark_sky_service.fetch_forecast(lat,lng)

    amypode_service = AmypodeService.new
    antipode_city_coord = amypode_service.fetch_antipode_city(lat,lng)[:data][:attributes]

    antipode_city = google_service.fetch_city(antipode_city_coord[:lat], antipode_city_coord[:long])[:results][0][:formatted_address]

    Antipode.new(origin_city, antipode_city, forecast_data)
  end
end
