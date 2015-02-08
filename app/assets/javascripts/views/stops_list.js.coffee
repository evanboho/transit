class TransIt.Views.StopsList extends Backbone.View

  template: JST['stops_list']

  render: (data)  ->
    $(@el).html(@template(data))
    this
