class TransIt.Collections.Stops extends Backbone.Collection
  model: TransIt.Models.Stop

  url: ->
    u = '/511/agencies/' + @agencyName + '/routes/' + @routeTag
    u += "/#{@direction}" if @direction
    u + '/stops'

  initialize: (options) ->
    @agencyName = options.agencyName
    @routeTag = options.routeTag
    @direction = options.direction
