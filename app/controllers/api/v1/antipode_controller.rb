class Api::V1::AntipodeController < ApplicationController
  def index
    facade = AntipodeFacade.new
    antipode = facade.retrieve_antipode(location_params)
    render json: AntipodeSerializer.new(antipode)
  end

  private

  def location_params
    params.permit(:location)
  end
end
