window.TransIt =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    @router = new TransIt.Routers.IndexRouter()
    Backbone.history.start(pushState: true)

$ ->
  TransIt.init()
  Static.init()
  $('#outlet').on 'click', 'a[href*=#]', ->
    href = $(@).attr('href').replace('#', '')
    TransIt.router.navigate href
    return false

Static =

  init: ->
    @geolocate()

  geolocate: ->
    return unless navigator.geolocation
    navigator.geolocation.getCurrentPosition (position) ->
      $('#outlet .lat').html position.coords.latitude
      $('#outlet .long').html position.coords.longitude
