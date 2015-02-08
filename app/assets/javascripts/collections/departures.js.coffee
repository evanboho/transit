class TransIt.Collections.Departures extends Backbone.Collection
  model: TransIt.Models.Departure

  url: ->
    "/511/departures/#{@stopId}"

  initialize: (options) ->
    @stopId = options.stopId
