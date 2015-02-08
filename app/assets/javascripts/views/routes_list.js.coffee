class TransIt.Views.RoutesList extends Backbone.View

  template: JST['routes_list']

  events:
    'click img.up-arrow': 'scrollBack'
