class Api::V1::ForecastController < ApplicationController
  def index
    facade = ForecastFacade.new
    forecast = facade.retrieve_forecast(location_params)
    render json: ForecastSerializer.new(forecast)
  end

  private

  def location_params
    params.permit(:location)
  end
end
