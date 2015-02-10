window.TransIt =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    @router = new TransIt.Routers.Router()
    Backbone.history.start(pushState: true)

$ ->
  if window.location.toString().match(/\/agencies/)
    TransIt.init()
