class Bart::RoutesController < ApplicationController

  def index
    render json: Bart.get_routes(params[:relaod])
  end

  def show
    render json: Bart.get_route(params[:id], params[:reload])
  end

end
