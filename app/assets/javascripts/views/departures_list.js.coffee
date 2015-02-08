class TransIt.Views.DeparturesList extends Backbone.View

  template: JST['departures_list']

  events:
    'click img.up-arrow': 'scrollBack'

  render: (data) ->
    $(@el).html(@template(_.extend data, @viewHelpers))
    this

  scrollToFocus: ->
    $('html,body').animate(scrollTop: $(@el).offset().top - $('header').height() - 15, 100)

  viewHelpers:
    assetUrlFor: (path) ->
      $('#asset-paths').data('asset-paths')[path]

  scrollBack: (e) ->
    e.stopPropagation()
    index = $(@el).find('.scrolling-list').index('.scrolling-list')
    $prevList = $(".scrolling-list:eq(#{index - 1})")
    $('html,body').animate(scrollTop: $prevList.offset().top - $('header').height() - 15, 100)
