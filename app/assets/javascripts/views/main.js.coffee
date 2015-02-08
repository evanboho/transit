Main =

  init: ->
    @geolocate()
    @activateNav()

  geolocate: ->
    return unless navigator.geolocation
    navigator.geolocation.getCurrentPosition (position) ->
      $('#outlet .lat').html position.coords.latitude
      $('#outlet .long').html position.coords.longitude

  activateNav: ->
    $('nav li').removeClass('active')
    if window.location.pathname.match(/\/agencies/)
      $("nav li a[href='/agencies']").parent().addClass('active')
    else
      $("nav li a[href='/nearby']").parent().addClass('active')

$ ->
  Main.init()
