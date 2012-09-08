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
      h1 id: "time", style: 'color: white;', "0:00"
      div id: "tracks"
    @el.append CoffeeKup.render template

  showPosition: (millis) =>
    $('#time').text (millis / 1000)

  startTrack: (record) =>
    models.Track.fromURI record.uri, (spotifyTrack) =>
      console.log('spotifyTrack: ', spotifyTrack.data)

      template = ->
        div class: 'album', ->
          div class: 'album-artwork', ->
            img src: @spotifyTrack.data.album.cover, width: 180
          div class: 'album-info', ->
            h1 @spotifyTrack.data.name
            h2 @spotifyTrack.data.artists[0].name

      $("#tracks").prepend CoffeeKup.render template, spotifyTrack:spotifyTrack

  endTrack: (record) =>
    models.Track.fromURI record.uri, (spotifyTrack) =>
      console.log "end - #{spotifyTrack.data.uri}"


  hide: () =>
    @el.hide()

exports.MainView = MainView
########################################################################################################################
