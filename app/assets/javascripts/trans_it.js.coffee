window.TransIt =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    new TransIt.Routers.IndexRouter()
    Backbone.history.start(pushState: true)

$(document).ready ->
  TransIt.init()
  Static.init()

Static =

  init: ->
    @geolocate()

  geolocate: ->
    return unless navigator.geolocation
    navigator.geolocation.getCurrentPosition (position) ->
      $('#outlet .lat').html position.coords.latitude
      $('#outlet .long').html position.coords.longitude
