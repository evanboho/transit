class TransIt.Views.StopsList extends Backbone.View

  template: JST['stops_list']

  events:
    'click a[data-stop-id]': 'showDepartures'
    'click img.up-arrow': 'scrollBack'

  showDepartures: (e) ->
    e.preventDefault()
    stopId = $(e.target).data('stop-id')
    pathname = window.location.pathname.replace(/\/stops\/\d+\/?/, '/stops')
    TransIt.router.navigate "#{pathname}/#{stopId}", { trigger: true }
