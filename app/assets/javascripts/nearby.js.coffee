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
      Nearby.radius = 0.25
      Backbone.history.start(pushState: true)

class Nearby.Routers.Router extends Backbone.Router

  routes:
    'nearby(/)': 'stopsIndex'

  stopsIndex: ->
    _self = @
    $('#nearby-outlet .progress-message').text('Getting stops near you...')
    stops = new Nearby.Collections.Stops
    stops.fetch
      success: (data) ->
        view = new Nearby.Views.StopsList
        if data.models.length
          clearInterval(_self.progressBar)
          data.radius = Nearby.radius
          $('#nearby-outlet').html(view.render(data).el)
          _.each data.models, (model) ->
            departures = new Nearby.Collections.Departures(stop_id: model.get('stop_id'))
            departures.fetch
              success: (data) ->
                departuresView = new Nearby.Views.DeparturesList
                $("li[data-stop-id='#{model.get('stop_id')}'] .stop-info").html(departuresView.render(data).el)
        else
          view = new Nearby.Views.NoStops
          $('#nearby-outlet').html(view.render(radius: Nearby.radius).el)

class Nearby.Models.Stop extends Backbone.Model

class Nearby.Collections.Stops extends Backbone.Collection
  model: Nearby.Models.Stop
  url: ->
    "/v1/stops/near?lat=#{Nearby.lat}&long=#{Nearby.long}&radius=#{Nearby.radius}"

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
    @.$el.html(@template(data)) && @

class Nearby.Views.DeparturesList extends Backbone.View
  template: JST['nearby_departures_list']
  render: (data) ->
    @.$el.html(@template(data)) && @

class Nearby.Views.NoStops extends Backbone.View
  template: JST['nearby_no_stops_near_you']
  render: (data) ->
    @.$el.html(@template(data)) && @
  events:
    'click .increase-radius': 'increaseRadius'

  increaseRadius: ->
    Nearby.radius = Nearby.radius * 2
    Nearby.router.stopsIndex()

$ ->
  if window.location.toString().match(/\/nearby/)
    Nearby.init()
