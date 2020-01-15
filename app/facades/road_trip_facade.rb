class RoadTripFacade
  def self.calculate_trip(origin, destination)
    google_service = GoogleService.new
    raw_directions = google_service.fetch_directions(origin, destination)[:routes][0][:legs][0]
    route_duration_text = raw_directions[:duration][:text]
    arrival_time = (Time.now + raw_directions[:duration][:value]).to_i
    dest_lat = raw_directions[:end_location][:lat]
    dest_lng = raw_directions[:end_location][:lng]

    dark_sky_service = DarkSkyService.new
    forecast = dark_sky_service.fetch_future_forecast(dest_lat, dest_lng, arrival_time)
    # dest_temp = forecast[:currently][:temperature]
    # dest_summary = forecast[:currently][:summary]

    Trip.new(origin, destination, route_duration_text, forecast)
  end
end
