class TransIt.Views.DeparturesList extends Backbone.View

  template: JST['departures_list']

  render: (data) ->
    $(@el).html(@template(_.extend data, @viewHelpers))
    this

  scrollToFocus: ->
    $('html,body').animate(scrollTop: $(@el).offset().top - $('header').height() - 15, 100)

  viewHelpers:
    assetUrlFor: (path) ->
      $('#asset-paths').data('asset-paths')[path]
