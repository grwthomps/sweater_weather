class Trip
  attr_reader :id, :origin, :destination, :duration, :forecast

  def initialize(origin, destination, route_duration_text, forecast)
    @id = nil
    @origin = origin
    @destination = destination
    @duration = route_duration_text
    @forecast = {
                  temperature: forecast[:currently][:temperature],
                  summary: forecast[:currently][:summary]
                }
  end
end
