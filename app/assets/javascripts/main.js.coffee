Main =

  init: ->
    @activateNav()

  activateNav: ->
    $('nav li').removeClass('active')
    if window.location.pathname.match(/\/agencies/)
      $("nav li a[href='/agencies']").parent().addClass('active')
    else
      $("nav li a[href='/nearby']").parent().addClass('active')

$ ->
  Main.init()
