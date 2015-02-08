class TransIt.Views.AgenciesList extends Backbone.View

  template: JST['agencies_view']

  render: (data) ->
    $(@el).html(@template(data))
    this

