window.Nearby =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  Store: {}
  init: ->
    if sessionStorage && sessionStorage.getItem('transIt')
      try
        store = JSON.parse(sessionStorage.getItem('transIt'))
        storedAt = Date.parse(store.storedAt)
        if new Date - storedAt < 300000
          Nearby.Store = store
    store ||= { radius: 0.25 }
    @router = new Nearby.Routers.Router()
    width = 15
    _self = @
    @progressBar = setInterval ->
      $('.progress-bar').stop().animate(width: "#{width += 15}%", 200)
      clearInterval(_self.progressBar) if width >= 85
    , 350
    if !(Nearby.Store.lat && Nearby.Store.long)
      navigator.geolocation.getCurrentPosition (position) ->
        Nearby.Store =
          lat: position.coords.latitude
          long: position.coords.longitude
          radius: store.radius
          storedAt: new Date()
        if sessionStorage
          sessionStorage.setItem('transIt', JSON.stringify(Nearby.Store))
        Backbone.history.start(pushState: true)
    else
      Backbone.history.start(pushState: true)

class Nearby.Routers.Router extends Backbone.Router

  routes:
    'nearby(/)': 'stopsIndex'

  stopsIndex: ->
    _self = @
    $('#nearby-outlet .progress-message').text('Getting stops near you...')
    stops = new Nearby.Collections.Stops
    stops.fetch
      success: (data) ->
        view = new Nearby.Views.StopsList
        if data.models.length
          clearInterval(_self.progressBar)
          data.radius = Nearby.Store.radius
          $('#nearby-outlet').html(view.render(data).el)
          _.each data.models, (model) ->
            if model.get('bart')
              departures = new Nearby.Collections.BartDepartures(id: model.get('abbr'))
              departures.fetch
                success: (data) ->
                  departuresView = new Nearby.Views.DeparturesList
                  $("li[data-stop-id='#{model.get('id')}'] .stop-info").html(departuresView.render(data).el)
            else if model.get('next_bus')
              departures = new Nearby.Collections.NextBusDepartures(id: model.get('stop_id'))
              departures.fetch
                success: (data) ->
                  departuresView = new Nearby.Views.DeparturesList
                  $("li[data-stop-id='#{model.get('stop_id')}'] .stop-info").html(departuresView.render(data).el)
        else
          view = new Nearby.Views.NoStops
          $('#nearby-outlet').html(view.render(radius: Nearby.Store.radius).el)

class Nearby.Models.Stop extends Backbone.Model

class Nearby.Collections.Stops extends Backbone.Collection
  model: Nearby.Models.Stop
  url: ->
    "/v1/stops/near?lat=#{Nearby.Store.lat}&long=#{Nearby.Store.long}&radius=#{Nearby.Store.radius}"

class Nearby.Models.Departure extends Backbone.Model

class Nearby.Collections.NextBusDepartures extends Backbone.Collection
  model: Nearby.Models.Departure
  initialize: (options) ->
    @stop_id = options.stop_id
  url: ->
    '/nb/agencies/sf-muni/departures/' + @stop_id

class Nearby.Models.BartDeparture extends Backbone.Model

class Nearby.Collections.BartDepartures extends Backbone.Collection
  model: Nearby.Models.BartDeparture
  initialize: (options) -> @id = options.id
  url: -> '/bart/departures/' + @id

class Nearby.Views.StopsList extends Backbone.View
  template: JST['nearby_stops_list']
  events:
    'click a.nearby-refresh': 'refreshDepartures'
    'click a.nearby-expand': 'expandRadius'

  refreshDepartures: (e) ->
    Nearby.router.stopsIndex()
    return false

  expandRadius: (e) ->
    Nearby.Store.radius = Nearby.Store.radius * 2
    if sessionStorage
      sessionStorage.setItem('transIt', JSON.stringify(Nearby.Store))
    Nearby.router.stopsIndex()
    return false

  render: (data) ->
    @.$el.html(@template(data)) && @

class Nearby.Views.DeparturesList extends Backbone.View
  template: JST['nearby_departures_list']
  render: (data) ->
    @.$el.html(@template(data)) && @

class Nearby.Views.NoStops extends Backbone.View
  template: JST['nearby_no_stops_near_you']
  render: (data) ->
    @.$el.html(@template(data)) && @
  events:
    'click .increase-radius': 'increaseRadius'

  increaseRadius: ->
    Nearby.Store.radius = Nearby.Store.radius * 2
    if sessionStorage
      sessionStorage.setItem('transIt', JSON.stringify(Nearby.Store))
    Nearby.router.stopsIndex()

$ ->
  if window.location.toString().match(/\/nearby/)
    Nearby.init()
