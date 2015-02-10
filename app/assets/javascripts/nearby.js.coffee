window.Nearby =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    @router = new Nearby.Routers.Router()
    width = 15
    _self = @
    @progressBar = setInterval ->
      $('.progress-bar').stop().animate(width: "#{width += 15}%", 200)
      clearInterval(_self.progressBar) if width >= 85
    , 350
    navigator.geolocation.getCurrentPosition (position) ->
      Nearby.lat = position.coords.latitude
      Nearby.long = position.coords.longitude
      Backbone.history.start(pushState: true)

class Nearby.Routers.Router extends Backbone.Router

  routes:
    'nearby(/)': 'stopsIndex'

  stopsIndex: ->
    _self = @
    $('#nearby-outlet .progress-message').text('Getting stops near you...')
    view = new Nearby.Views.StopsList
    stops = new Nearby.Collections.Stops
    stops.fetch
      success: (data) ->
        clearInterval(_self.progressBar)
        $('#nearby-outlet').html(view.render(data).el)
        _.each data.models, (model) ->
          departures = new Nearby.Collections.Departures(stop_id: model.get('stop_id'))
          departures.fetch
            success: (data) ->
              departuresView = new Nearby.Views.DeparturesList
              $("li[data-stop-id='#{model.get('stop_id')}'] .stop-info").html(departuresView.render(data).el)

class Nearby.Models.Stop extends Backbone.Model

class Nearby.Collections.Stops extends Backbone.Collection
  model: Nearby.Models.Stop
  url: ->
    "/v1/stops/near?lat=#{Nearby.lat}&long=#{Nearby.long}"

class Nearby.Models.Departure extends Backbone.Model

class Nearby.Collections.Departures extends Backbone.Collection
  model: Nearby.Models.Departure
  initialize: (options) ->
    @stop_id = options.stop_id
  url: ->
    '/511/departures/' + @stop_id

class Nearby.Views.StopsList extends Backbone.View
  template: JST['nearby_stops_list']

  render: (data) ->
    @.$el.html(@template(data))
    @

class Nearby.Views.DeparturesList extends Backbone.View
  template: JST['nearby_departures_list']
  render: (data) ->
    @.$el.html(@template(data))
    @

$ ->
  if window.location.toString().match(/\/nearby/)
    Nearby.init()
