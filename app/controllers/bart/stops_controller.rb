class Bart::StopsController < ApplicationController

  def index
    render json: Bart.get_stations
  end
end
