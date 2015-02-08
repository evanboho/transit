window.TransIt =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    @router = new TransIt.Routers.Router()
    Backbone.history.start(pushState: true)

$ ->
  TransIt.init()
  Static.init()
  $('#outlet').on 'click', 'a[href*=#]', ->
    return if $(@).attr('href') == '#'
    href = $(@).attr('href').replace('#', '')
    TransIt.router.navigate href, {trigger: true}
    return false

Static =

  init: ->
    @geolocate()

  geolocate: ->
    return unless navigator.geolocation
    navigator.geolocation.getCurrentPosition (position) ->
      $('#outlet .lat').html position.coords.latitude
      $('#outlet .long').html position.coords.longitude
