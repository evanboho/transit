class Nearby.Models.Stop extends Backbone.Model
  url: ''

class Nearby.Collections.Stop extends Backbone.Collection
  model: Nearby.Models.Stop
  url: '/v1/stops'
