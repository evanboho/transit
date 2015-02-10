class V1::StopsController < ApplicationController

  def index
    render json: NextBus::Stop.all
  end

  def show
    render json: NextBus::Stop.find(params[:id])
  end

  def near
    if params[:lat] && params[:long]
      sql = NextBus::Stop.near([params[:lat], params[:long]], 0.25).limit(10).to_sql
      results = NextBus::Stop.connection.execute(sql)
      stops = results.values.map do |value|
        Hash[results.fields.zip(value)]
      end
      routes = NextBus::Route.where(id: stops.map { |stop| stop['route_id'] })
      stops.each do |stop|
        stop[:route_name] = routes.select { |route| route.id == stop['route_id'] }
      end
      render json: stops
    else
      render json: { error: "Missing paramters: #{missing_paramters}" }
    end
  end

  private

  def missing_paramters
    [(params[:lat] ? nil : "lat"), (params[:long] ? "" : "long")].compact.join(', ')
  end

end
