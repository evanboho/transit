class TransIt.Views.DeparturesList extends Backbone.View

  template: JST['departures_list']

  events:
    'click img.up-arrow': 'scrollBack'
