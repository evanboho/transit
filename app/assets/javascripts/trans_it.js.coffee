window.TransIt =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    @router = new TransIt.Routers.Router()
    Backbone.history.start(pushState: true)

window.Nearby =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    @router = new Nearby.Routers.Router()
    navigator.geolocation.getCurrentPosition (position) ->
      Nearby.lat = position.coords.latitude
      Nearby.long = position.coords.longitude
      Backbone.history.start(pushState: true)

$ ->
  if window.location.toString().match(/\/agencies/)
    TransIt.init()
  else
    Nearby.init()
