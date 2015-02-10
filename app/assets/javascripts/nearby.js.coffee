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
    stops = new Nearby.Collections.Stop
    stops.fetch
      success: (data) ->
        $('#nearby-outlet').html(view.render(data).el)
        clearInterval(_self.progressBar)

class Nearby.Models.Stop extends Backbone.Model
  url: ''

class Nearby.Collections.Stop extends Backbone.Collection
  model: Nearby.Models.Stop
  url: ->
    "/v1/stops/near?lat=#{Nearby.lat}&long=#{Nearby.long}"

class Nearby.Views.StopsList extends Backbone.View
  template: JST['nearby_stops_list']

  render: (data) ->
    @.$el.html(@template(data))
    @

$ ->
  if window.location.toString().match(/\/nearby/)
    Nearby.init()
