class Forecast
  attr_reader :id,
              :timezone,
              :time,
              :current_summary,
              :current_temp,
              :icon,
              :humidity,
              :feels_like,
              :visibility,
              :uv_index,
              :day_summary,
              :night_summary,
              :hourly_forecasts,
              :daily_forecasts

  def initialize(forecast_data)
    @id = SecureRandom.hex(2)
    @timezone = forecast_data[:timezone]
    @time = convert_time(forecast_data[:currently][:time])
    @current_summary = forecast_data[:currently][:summary]
    @current_temp = forecast_data[:currently][:temperature]
    @icon = forecast_data[:currently][:icon]
    @humidity = forecast_data[:currently][:humidity]
    @feels_like = forecast_data[:currently][:apparentTemperature]
    @visibility = forecast_data[:currently][:visibility]
    @uv_index = forecast_data[:currently][:uvIndex]
    @day_summary = forecast_data[:daily][:data][0][:summary]
    @night_summary = find_night_summary(forecast_data)
    @hourly_forecasts = parse_hourly_forecasts(forecast_data[:hourly][:data][0..7])
    @daily_forecasts = parse_daily_forecasts(forecast_data[:daily][:data][1..5])
  end

  def find_night_summary(forecast)
    summary = forecast[:hourly][:data].select do |hourly_forecast|
      hourly_forecast[:time] == @time.change({ hour: 20 }).to_i
    end

    if summary.empty?
      return forecast[:hourly][:data][0][:summary]
    else
      return summary[0][:summary]
    end
  end

  def parse_hourly_forecasts(hourly_forecasts)
    hourly_forecasts.map do |forecast|
      {
        time: convert_time(forecast[:time]),
        temperature: forecast[:temperature],
        icon: forecast[:icon]
      }
    end
  end

  def convert_time(unix_time)
    Time.at(unix_time).in_time_zone(@timezone)
  end

  def parse_daily_forecasts(daily_forecasts)
    daily_forecasts.map do |forecast|
      {
        day: convert_time(forecast[:time]),
        summary: forecast[:summary],
        icon: forecast[:icon],
        precipitation: forecast[:precipProbability],
        temp_high: forecast[:temperatureHigh],
        temp_low: forecast[:temperatureLow]
      }
    end
  end
end
