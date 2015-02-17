class Bart::RoutesController < ApplicationController

  def index
    render json: Bart.get_routes
  end

end
