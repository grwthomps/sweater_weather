class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attributes  :id,
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
end
