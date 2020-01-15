class Api::V1::RoadTripController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])

    return render json: {error: "Invalid api key."}, status: 401 if user.nil?

    trip = RoadTripFacade.calculate_trip(params[:origin], params[:destination])

    if trip.nil?
      render json: {error: "Invalid request or no results found."}, status: 400
    else
      render json: RoadTripSerializer.new(trip)
    end
  end
end
