class TransIt.Collections.Routes extends Backbone.Collection
  model: TransIt.Models.Route

  url: ->
    '/511/agencies/' + @agencyName + '/routes'

  initialize: (options) ->
    @agencyName = options.agencyName

