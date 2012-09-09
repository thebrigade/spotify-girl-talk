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
      div id: 'girltalk', ->
        img src: 'girltalk.png', width: '100%'
      # h1 id: "time", style: 'color: white;', "0:00"
      div id: "tracks"
      div id: "played_tracks"

    @el.append CoffeeKup.render template

  showPosition: (millis) =>
    $('#time').text (millis / 1000)

  startTrack: (record) =>
    models.Track.fromURI record.uri, (spotifyTrack) =>
      template = ->
        div class: 'album animated bounceIn', id: 'album_' + @record.id, ->
          div class: 'album-artwork', ->
            img src: @spotifyTrack.data.album.cover, width: 180
          div class: 'album-info', ->
            h1 @spotifyTrack.data.name
            h2 @spotifyTrack.data.artists[0].name

      $("#tracks").prepend CoffeeKup.render template, spotifyTrack:spotifyTrack, record:record

  endTrack: (record) =>
    models.Track.fromURI record.uri, (spotifyTrack) =>
      console.log "end - #{spotifyTrack.data.uri}"
      console.log 'record.id: ', record.id
      $('#tracks #album_' + record.id).removeClass('bounceIn').addClass('fadeOutDownBig')

      setTimeout (->
        $('#tracks #album_' + record.id).remove()
      ), 500

      template = ->
        div class: 'album', ->
          div class: 'album-artwork', ->
            img src: @spotifyTrack.data.album.cover, width: 64

      $("#played_tracks").prepend CoffeeKup.render template, spotifyTrack:spotifyTrack, record:record

  hide: () =>
    @el.hide()

exports.MainView = MainView
########################################################################################################################
