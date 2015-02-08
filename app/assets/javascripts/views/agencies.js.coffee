window.AgenciesView = Backbone.View.extend

  template: JST['agencies_view']

  render: ->
    $(@el).html(@template())
    this
