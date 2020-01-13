class Antipode
  attr_reader :id,
              :location_name,
              :forecast,
              :search_location

  def initialize(antipode_city, summary, current_temperature, origin_city)
    @id = SecureRandom.hex(2)
    @location_name = antipode_city
    @forecast = {
                  summary: summary,
                  current_temperature: current_temperature
                }
    @search_location = origin_city
  end
end
