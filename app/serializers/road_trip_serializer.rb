class RoadTripSerializer
  include FastJsonapi::ObjectSerializer
  attributes :origin, :destination, :duration, :forecast
end
