class TransIt.Views.AgenciesList extends Backbone.View

  template: JST['agencies_view']

  events:
    'click': 'navigateToHref'

  navigateToHref: (e) ->
    return unless $(e.target).attr('href').match(/#\w+/)
    href = $(e.target).attr('href').replace('#', '')
    TransIt.router.navigate href, {trigger: true}
    return false
