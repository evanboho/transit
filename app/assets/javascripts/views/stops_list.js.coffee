class TransIt.Views.StopsList extends Backbone.View

  template: JST['stops_list']

  events:
    'click a[data-stop-id]': 'showDepartures'

  showDepartures: (e) ->
    e.preventDefault()
    stopId = $(e.target).data('stop-id')
    # pathname = window.location.pathname.replace(/\/\d+\/departures/, '')
    pathname = window.location.pathname.replace(/\/stops\/\d+\/?/, '')
    TransIt.router.navigate "#{pathname}/stops/#{stopId}", { trigger: true }
    # return false


  render: (data)  ->
    $(@el).html(@template(data))
    this
