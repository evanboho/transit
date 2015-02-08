class TransIt.Routers.IndexRouter extends Backbone.Router

  routes:
    '': 'index'

  index: ->
    view = new TransIt.Views.AgenciesList
    $('#outlet').html(view.render().el)
