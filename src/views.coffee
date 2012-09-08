class BaseView extends spore.View
  constructor: () ->
  setLoading: (loading) =>
    if loading
      $('#loading').show()
    else
      $('#loading').hide()

###
Views go here
###

########################################################################################################################
##### MainView ########################################################################################################
class MainView extends BaseView
  constructor: () ->
    @el = $ '#main'

  show: () =>
    @el.show()
    window.scrollTo(0,0)
    @setLoading false

  clear: () =>
    @el.empty()

  display: () =>
    template = ->
      a id: 'play', href: '', "Play"
      h1 id: "time", style: 'color: white;', "0:00"
    @el.append CoffeeKup.render template
    $("#play").click (e) =>
      e.preventDefault()
      models.Track.fromURI 'spotify:track:4fOFWrYmRUfS9sC9TyOlUb', (spotifyTrack) =>
        models.player.play spotifyTrack

  showPosition: (millis) =>
    $('#time').text (millis / 1000)

  hide: () =>
    @el.hide()

exports.MainView = MainView
########################################################################################################################
