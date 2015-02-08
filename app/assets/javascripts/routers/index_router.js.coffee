class TransIt.Routers.IndexRouter extends Backbone.Router

  routes:
    '': 'index'
    'agencies': 'index'
    'agencies/:agencyId': 'show'

  index: (fn) ->
    render = (data) ->
      view = new TransIt.Views.AgenciesList
      $('#outlet').html(view.render(data).el)
      fn.call(@) if fn?
    agencies = new TransIt.Collections.Agencies
    if $('#outlet[data-agencies]').length
      agencies.reset $('#outlet').data('agencies')
      render(agencies)
    else
      agencies.fetch
        success: render

  show: (fn) ->
    @index ->
      routes = new TransIt.Collections.Routes
      routes.fetch
        success: (data) ->
          view = new TransIt.Views.RoutesList
          $('#route-list-outlet').html(view.render(data).el)
          fn.call(@) if fn?
