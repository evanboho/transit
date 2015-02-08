class TransIt.Views.RoutesList extends Backbone.View

  template: JST['routes_list']

  events:
    'click img.up-arrow': 'scrollBack'

  render: (data) ->
    $(@el).html(@template(_.extend data, @viewHelpers))
    this

  scrollToFocus: ->
    $('html,body').animate(scrollTop: $(@el).offset().top - $('header').height() - 15, 100)

  viewHelpers:
    assetPathFor: (path) ->
      $('#asset-paths').data('asset-paths')[path]

  scrollBack: ->
    index = $(@el).find('.scrolling-list').index('.scrolling-list')
    $prevList = $(".scrolling-list:eq(#{index - 1})")
    $('html,body').animate(scrollTop: $prevList.offset().top - $('header').height() - 15, 100)
