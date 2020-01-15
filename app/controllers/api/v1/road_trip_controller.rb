class Api::V1::RoadTripController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])
    if user
      trip = RoadTripFacade.calculate_trip(params[:origin], params[:destination])
      render json: RoadTripSerializer.new(trip)
    else
      render json: {error: "Invalid api key."}, status: 401
    end
  end
end
