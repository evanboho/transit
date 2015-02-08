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
  $('#outlet').on 'click', 'a[href*=#]', ->
    return if $(@).attr('href') == '#'
    href = $(@).attr('href').replace('#', '')
    TransIt.router.navigate href, {trigger: true}
    return false
