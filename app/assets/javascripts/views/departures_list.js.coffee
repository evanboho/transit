class TransIt.Views.DeparturesList extends Backbone.View

  template: JST['departures_list']

  render: (data) ->
    $(@el).html(@template(data))
    this
