class TransIt.Views.RoutesList extends Backbone.View

  template: JST['routes_list']

  render: (data) ->
    $(@el).html(@template(data))
    this

  scrollToFocus: ->
    $('html,body').animate(scrollTop: $(@el).offset().top - $('header').height(), 100)

