class Antipode
  attr_reader :id,
              :location_name,
              :forecast,
              :search_location

  def initialize(origin_city, antipode_city, forecast_data)
    @id = SecureRandom.hex(2)
    @location_name = antipode_city
    @forecast = {
                  summary: forecast_data[:currently][:summary],
                  current_temperature: forecast_data[:currently][:temperature]
                }
    @search_location = origin_city
  end
end
