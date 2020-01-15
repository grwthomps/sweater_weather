class RoadTripFacade
  def self.calculate_trip(origin, destination)
    @raw_directions = google_service.fetch_directions(origin, destination)

    if invalid_request?
      return nil
    else
      parse_directions(@raw_directions)
    end

    forecast = dark_sky_service.fetch_future_forecast(@dest_lat, @dest_lng, @arrival_time)

    Trip.new(origin, destination, @route_duration_text, forecast)
  end

  private

  def self.google_service
    google_service ||= GoogleService.new
  end

  def self.dark_sky_service
    dark_sky_service ||= DarkSkyService.new
  end

  def self.invalid_request?
    @raw_directions[:status] == "INVALID_REQUEST" || @raw_directions[:status] == "NOT_FOUND"
  end

  def self.parse_directions(raw_directions)
    @route_duration_text = raw_directions[:routes][0][:legs][0][:duration][:text]
    @arrival_time = (Time.now + raw_directions[:routes][0][:legs][0][:duration][:value]).to_i
    @dest_lat = raw_directions[:routes][0][:legs][0][:end_location][:lat]
    @dest_lng = raw_directions[:routes][0][:legs][0][:end_location][:lng]
  end
end
