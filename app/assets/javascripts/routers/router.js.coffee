class TransIt.Routers.Router extends Backbone.Router

  routes:
    '': 'index'
    'agencies': 'index'
    'agencies/:agencyName': 'show'
    'agencies/:agencyName/routes/:id(/:direction)': 'routeShow'

  index: (fn) ->
    render = (data) ->
      view = new TransIt.Views.AgenciesList
      $('#outlet').html(view.render(data).el)
      fn.call(@) if fn?
    agencies = new TransIt.Collections.Agencies
    if $('#outlet[data-agencies]').length
      agencies.reset $('#outlet').data('agencies')
      $('#outlet').removeAttr('data-agencies')
      render(agencies)
    else
      agencies.fetch
        success: render

  show: (agencyName, fn) ->
    routes = new TransIt.Collections.Routes(agencyName: agencyName)
    render = (data) ->
      view = new TransIt.Views.RoutesList
      $('#route-list-outlet').html(view.render(data).el)
      fn.call(@) if fn?
    fetchRoutes = ->
      if $('#outlet[data-routes]').length
        routes.reset $('#outlet').data('routes')
        $('#outlet').removeAttr('data-routes')
        render routes
      else
        routes.fetch
          success: render
    if $('#outlet').html().length
      fetchRoutes()
    else
      @index fetchRoutes

  routeShow: (agencyName, routeTag, direction) ->
    stops = new TransIt.Collections.Stops(agencyName: agencyName, routeTag: routeTag, direction: direction)
    render = (data) ->
      view = new TransIt.Views.StopsList
      $('#stop-list-outlet').html(view.render(data).el)
    fetchStops = ->
      if $('#outlet[data-stops]').length
        stops.reset $('#outlet').data('stops')
        $('#outlet').removeAttr('data-stops')
        render stops
      else
        stops.fetch
          success: render
    if $('#route-list-outlet').length
      fetchStops()
    else
      @show agencyName, fetchStops

