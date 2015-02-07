Static =

  init: ->
    @geolocate()

  geolocate: ->
    return unless navigator.geolocation
    navigator.geolocation.getCurrentPosition (position) ->
      $('#outlet .lat').html position.coords.latitude
      $('#outlet .long').html position.coords.longitude

$ ->
  Static.init()
