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
      h1 id: "time", style: 'color: white;', "0:00"
      div id: "tracks"

    @el.append CoffeeKup.render template

  showPosition: (millis) =>
    $('#time').text (millis / 1000)

  startTrack: (record) =>
    models.Track.fromURI record.uri, (spotifyTrack) =>
      template = ->
        div class: 'album animated fadeIn', id: 'album_' + @record.id, ->
          div class: 'album-artwork', ->
            img src: @spotifyTrack.data.album.cover, width: 256
          div class: 'album-info', ->
            h1 @spotifyTrack.data.name
            h2 @spotifyTrack.data.artists[0].name

      $("#tracks").prepend CoffeeKup.render template, spotifyTrack:spotifyTrack, record:record

  endTrack: (record) =>
    models.Track.fromURI record.uri, (spotifyTrack) =>
      console.log "end - #{spotifyTrack.data.uri}"
      console.log 'record.id: ', record.id
      $('#tracks #album_' + record.id).removeClass('fadeIn').addClass('fadeOut')


  hide: () =>
    @el.hide()

exports.MainView = MainView
########################################################################################################################
