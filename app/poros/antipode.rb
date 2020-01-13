class Antipode
  def initialize(origin_city, antipode_city, forecast_data)
    @origin_city = origin_city
    @antipode_city = antipode_city
    @forecast_summary = forecast_data[:currently][:summary]
    @current_temperature = forecast_data[:currently][:temperature]
  end
end
