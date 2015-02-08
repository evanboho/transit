class TransIt.Views.StopsList extends Backbone.View

  template: JST['stops_list']

  events:
    'click a[data-stop-id]': 'showDepartures'

  showDepartures: (e) ->
    e.preventDefault()
    stopId = $(e.target).data('stop-id')
    pathname = window.location.pathname.replace(/\/stops\/\d+\/?/, '/stops')
    TransIt.router.navigate "#{pathname}/#{stopId}", { trigger: true }

  render: (data)  ->
    $(@el).html(@template(data))
    this

  scrollToFocus: ->
    $('html,body').animate(scrollTop: $(@el).offset().top - $('header').height() - 15, 100)
