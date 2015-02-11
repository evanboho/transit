class V1::StopsController < ApplicationController

  def index
    sql = NextBus::Stop.all.to_sql
    results = NextBus::Stop.connection.execute(sql)
    stops = results.values.map do |value|
      Hash[results.fields.zip(value)]
    end
    render json: results
  end

  def show
    render json: NextBus::Stop.find(params[:id])
  end

  def near
    if params[:lat] && params[:long]
      sql = NextBus::Stop.near([params[:lat], params[:long]], (params[:radius] || 0.25).to_f).limit(20).to_sql
      results = NextBus::Stop.connection.execute(sql)
      stops = results.values.map do |value|
        Hash[results.fields.zip(value)]
      end
      routes = NextBus::Route.where(id: stops.map { |stop| stop['route_id'] })
      stops.each do |stop|
        stop[:route_name] = routes.select { |route| route.id == stop['route_id'] }
      end
      stops = stops.group_by { |stop| stop['tag'] }.map { |k,v| v.first }
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
