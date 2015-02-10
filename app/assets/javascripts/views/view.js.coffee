class TransIt.Views.View extends Backbone.View

  initialize: (options) ->
    _.each options, (val, key) =>
      @[key] = val

  events:
    'click [data-remote=true]': 'navigateToHref'
    'click img.up-arrow': 'scrollBack'

  @current: {}

  render: (data)  ->
    @.$el.html(@template(_.extend data, @viewHelpers))
    this

  scrollToFocus: ($el) ->
    if $('img.up-arrow').is(':visible')
      $el ||= @.$el
      $('html,body').animate(scrollTop: $el.offset().top - $('header').height() - 15, 150)

  viewHelpers:
    assetPathFor: (path) ->
      $('#asset-paths').data('asset-paths')[path]

  scrollBack: (e) ->
    e.stopPropagation()
    index = $(@el).find('.scrolling-list').index('.scrolling-list')
    @scrollToFocus $(".scrolling-list:eq(#{index - 1})")

  navigateToHref: (e) ->
    e.stopPropagation()
    href = $(e.target).attr('href').replace(/\s/g, '%20')
    TransIt.router.navigate href, {trigger: true} if href?
    return false

  insertHtml: (data) ->
    if TransIt.Views.View.current[@outletId]
      TransIt.Views.View.current[@outletId].remove()
    TransIt.Views.View.current[@outletId] = @
    $(@outletId).html(@render(data).el)
    if typeof @childRenderFn == 'function'
      @childRenderFn.call()
    else
      @scrollToFocus()
