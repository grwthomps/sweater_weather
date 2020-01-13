class AntipodeFacade
  def retrieve_antipode(location)
    convert_location_to_lat_lng(location)

    find_antipode_city

    get_antipode_forecast

    Antipode.new(@antipode_city, @summary, @current_temperature, @origin_city)
  end

  def convert_location_to_lat_lng(location)
    @google_service = GoogleService.new
    geolocation_data = @google_service.fetch_lat_long(location)

    @origin_lat = geolocation_data[:results][0][:geometry][:location][:lat]
    @origin_lng = geolocation_data[:results][0][:geometry][:location][:lng]
    @origin_city = geolocation_data[:results][0][:formatted_address]
  end

  def find_antipode_city
    amypode_service = AmypodeService.new

    raw_antipode_coords = amypode_service.fetch_antipode_city(@origin_lat,@origin_lng)
    @antipode_lat = raw_antipode_coords[:data][:attributes][:lat]
    @antipode_lng = raw_antipode_coords[:data][:attributes][:long]

    raw_antipode_city = @google_service.fetch_city(@antipode_lat, @antipode_lng)
    @antipode_city = raw_antipode_city[:results][0][:formatted_address]
  end

  def get_antipode_forecast
    dark_sky_service = DarkSkyService.new
    raw_forecast = dark_sky_service.fetch_forecast(@antipode_lat,@antipode_lng)

    @summary = raw_forecast[:currently][:summary]
    @current_temperature = raw_forecast[:currently][:temperature]
  end
end
