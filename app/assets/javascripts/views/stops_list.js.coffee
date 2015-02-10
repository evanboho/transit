class TransIt.Views.StopsList extends TransIt.Views.View

  template: JST['stops_list']

  outletId: '#stop-list-outlet'

  events:
    'click a[data-stop-id]': 'showDepartures'

  showDepartures: (e) ->
    e.preventDefault()
    stopId = $(e.target).data('stop-id')
    pathname = window.location.pathname.replace(/\/stops\/\d+\/?/, '/stops')
    TransIt.router.navigate "#{pathname}/#{stopId}", { trigger: true }
