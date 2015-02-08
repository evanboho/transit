class TransIt.Routers.Router extends Backbone.Router

  routes:
    'agencies(/)': 'agenciesIndex'
    'agencies/:agencyName/routes(/)': 'routesIndex'
    'agencies/:agencyName/routes/:id(/:direction)/stops(/)': 'stopsIndex'
    'agencies/:agencyName/routes/:id(/:direction)/stops/:stopId(/)': 'departuresIndex'

  agenciesIndex: (fn) ->
    render = (data) ->
      view = new TransIt.Views.AgenciesList
      $('#outlet').html(view.render(data).el)
      fn.call(@) if typeof fn == 'function'
    agencies = new TransIt.Collections.Agencies
    if $('#outlet[data-agencies]').length
      agencies.reset $('#outlet').data('agencies')
      render(agencies)
    else
      agencies.fetch
        success: render

  routesIndex: (agencyName, fn) ->
    routes = new TransIt.Collections.Routes(agencyName: agencyName)
    render = (data) ->
      view = new TransIt.Views.RoutesList
      $('#route-list-outlet').html(view.render(data).el)
      if typeof fn == 'function'
        fn.call(@)
      else
        view.scrollToFocus()
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
      @agenciesIndex fetchRoutes

  stopsIndex: (agencyName, routeTag, direction, fn) ->
    stops = new TransIt.Collections.Stops(agencyName: agencyName, routeTag: routeTag, direction: direction)
    render = (data) ->
      view = new TransIt.Views.StopsList
      $('#stop-list-outlet').html(view.render(data).el)
      if typeof fn == 'function'
        fn.call(@)
      else
        view.scrollToFocus()
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
      @routesIndex agencyName, fetchStops

  departuresIndex: (agencyName, routeTag, direction, stopId) ->
    departures = new TransIt.Collections.Departures(stopId: stopId)
    render = (data) ->
      view = new TransIt.Views.DeparturesList
      $('#departure-list-outlet').html(view.render(data).el)
      view.scrollToFocus()
    fetchDepartures = ->
      if $('#outlet[data-departures]').length
        departures.reset $('#outlet').data('departures')
        $('#outlet').removeAttr('data-departures')
        render departures
      else
        departures.fetch
          success: render
    if $('#stop-list-outlet').length
      fetchDepartures()
    else
      @stopsIndex agencyName, routeTag, direction, fetchDepartures


