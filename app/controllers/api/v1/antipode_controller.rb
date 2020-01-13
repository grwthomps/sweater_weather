class Api::V1::AntipodeController < ApplicationController
  def index
    facade = AntipodeFacade.new
    render json: AntipodeSerializer.new(facade.retrieve_antipode(location_params))
  end

  private

  def location_params
    params.permit(:location)
  end
end
