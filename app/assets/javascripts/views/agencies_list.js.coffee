class TransIt.Views.AgenciesList extends Backbone.View

  template: JST['agencies_view']

  render: ->
    $(@el).html(@template())
    this