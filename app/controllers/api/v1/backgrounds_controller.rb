class Api::V1::BackgroundsController < ApplicationController
  def index
    facade = BackgroundFacade.new
    background = facade.retrieve_background(params[:location])
    render json: BackgroundSerializer.new(background)
  end
end
