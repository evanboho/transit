class TransIt.Routers.Router extends Backbone.Router

  routes:
    'agencies(/)': 'agenciesIndex'
    'agencies/:agencyName/routes(/)': 'routesIndex'
    'agencies/:agencyName/routes/:id(/:direction)/stops(/)': 'stopsIndex'
    'agencies/:agencyName/routes/:id(/:direction)/stops/:stopId(/)': 'departuresIndex'

  agenciesIndex: (fn) ->
    view = new TransIt.Views.AgenciesList(childRenderFn: fn)
    insertHtmlFn = _.bind view.insertHtml, view
    agencies = new TransIt.Collections.Agencies
    fetchAgencies = ->
      if $('#outlet[data-agencies]').length
        agencies.reset $('#outlet').data('agencies')
        insertHtmlFn agencies
      else
        agencies.fetch
          success: insertHtmlFn
    fetchAgencies()

  routesIndex: (agencyName, fn) ->
    routes = new TransIt.Collections.Routes(agencyName: agencyName)
    view = new TransIt.Views.RoutesList(childRenderFn: fn)
    insertHtmlFn = _.bind view.insertHtml, view
    fetchRoutes = ->
      if $('#outlet[data-routes]').length
        routes.reset $('#outlet').data('routes')
        $('#outlet').removeAttr('data-routes')
        insertHtmlFn routes
      else
        routes.fetch
          success: insertHtmlFn
    if $('#outlet').html().length
      fetchRoutes()
    else
      @agenciesIndex fetchRoutes

  stopsIndex: (agencyName, routeTag, direction, fn) ->
    stops = new TransIt.Collections.Stops(agencyName: agencyName, routeTag: routeTag, direction: direction)
    view = new TransIt.Views.StopsList(childRenderFn: fn)
    insertHtmlFn = _.bind view.insertHtml, view
    fetchStops = ->
      if $('#outlet[data-stops]').length
        stops.reset $('#outlet').data('stops')
        $('#outlet').removeAttr('data-stops')
        insertHtmlFn stops
      else
        stops.fetch
          success: insertHtmlFn
    if $('#route-list-outlet').html()?
      fetchStops()
    else
      @routesIndex agencyName, fetchStops

  departuresIndex: (agencyName, routeTag, direction, stopId) ->
    departures = new TransIt.Collections.Departures(stopId: stopId)
    view = new TransIt.Views.DeparturesList
    insertHtmlFn = _.bind view.insertHtml, view
    fetchDepartures = ->
      if $('#outlet[data-departures]').length
        departures.reset $('#outlet').data('departures')
        $('#outlet').removeAttr('data-departures')
        insertHtmlFn departures
      else
        departures.fetch
          success: insertHtmlFn
    if $('#stop-list-outlet').html()?
      fetchDepartures()
    else
      @stopsIndex agencyName, routeTag, direction, fetchDepartures





