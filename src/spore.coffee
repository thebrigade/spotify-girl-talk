class Spore
  constructor: (@spotify, @trace, @appName, @tracker) ->
    @trace = @trace? and @trace
    @map = {}
    @activeToken = null
    @models = @spotify.require 'sp://import/scripts/api/models'
    @models.application.observe @models.EVENT.ARGUMENTSCHANGED, @handleArgs
    @models.application.observe @models.EVENT.LINKSCHANGED,     @handleLinks
    @models.player.observe      @models.EVENT.CHANGE,           @handlePlayerChange
    @models.session.observe     @models.EVENT.STATECHANGED,     @handleSessionChange

  register: (token, presenter) =>
    @map[token] = presenter
    presenter.spore = @

  handleArgs: () =>
    @_handleArgs @models.application.arguments
  _handleArgs: (args) =>
    if @trace then console.log "Spore.handleArgs(#{args})"

    token = args[0]
    presenter = @map[token]
    @tracker.track "#{@appName}/#{token}"

    if token != @activeToken
      if @activeToken?
        @map[@activeToken].unbind()
      @activeToken = null

    # check offline mode
    if @isOffline()
      @offline = true
      $("body").addClass('loading')
      $("#offline").show()
      $("#overlay").show()
      return
    else
      @offline = false
      $("body").removeClass('loading')
      $("#offline").hide()
      $("#overlay").hide()

    if presenter?
      if not @activeToken?
        presenter.bind()
      @activeToken = token
      presenter.show args.splice(1, args.length - 1)
    else
      throw new Error "no presenter bound for token '#{token}'"

  handleLinks: () =>
    @_handleLinks @models.application.links
  _handleLinks: (links) =>
    if @trace then console.log "Spore.handleLinks([#{links}])"
    if @activeToken? then @map[@activeToken].links links

  handlePlayerChange: (playerChange) =>
    if @trace then console.log "Spore.handlePlayerChange(#{JSON.stringify playerChange.data})"
    if @activeToken? and playerChange.data.playstate
      @map[@activeToken].playerChange playerChange

  isOffline: () =>
    state = models.session.state
    return state is 2 or state is 3

  handleSessionChange: () =>
    stillOffline = @isOffline()
    if @offline
      if not @isOffline()
        @offline = false
        $("body").removeClass('loading')
        $("#offline").hide()
        $("#overlay").hide()
        @handleArgs()
    else
      if @isOffline()
        @offline = true
        $("body").addClass('loading')
        $("#offline").show()
        $("#overlay").show()

  go: =>
    @handleLinks()
    @handleArgs()

class DebugTracker
  track: (page) =>
    console.log "---------track(#{page})------------"

class Presenter
  constructor: (@view) ->

  bind: () =>
    # bind event listeners, etc

  unbind: () =>
    # unbind event listenters

  show: (params) =>
    # update view based on params

  links: (links) =>
    # handle incoming link

  drop: (uri) =>
    # handle a dropped spotify uri

  playerChange: (playerChange) =>
    # handle player change


class View
  clear: () =>

class Fetcher
  on: (type, callback) =>
    if !@listeners?
      @listeners = {}
    if !@listeners[type]?
      @listeners[type] = []
    @listeners[type].push callback
  kill: =>
    #todo: cancel in-flight requests if any
    @listeners.length = 0
  fire: (type, a, b, c, d, e) =>
    for listener in @listeners[type]
      listener a, b, c, d, e
  go: =>

exports.Spore     = Spore
exports.Presenter = Presenter
exports.View      = View
exports.Fetcher   = Fetcher
exports.DebugTracker = DebugTracker

exports.createAddAsPlaylistFunction = (trackSource) ->
  return (e) ->
    e.preventDefault()
    $(e.currentTarget).unbind()
    $(e.currentTarget).hide()
    if trackSource.data?.type is 'album'
      name = "#{trackSource.data?.artist?.name} - #{trackSource.data?.name}"
    else
      name = trackSource.data?.name
    newPlaylist = new models.Playlist name.decodeForText()
    for track in trackSource.tracks
      newPlaylist.add track.uri

exports.fixPlaylist = (listViewNode) ->
  el = $(listViewNode)
  $('.sp-list').css({height: 100})
  el.children('div').height 1000
  scrollFix = ->
    el.scrollTop 10
    el.scrollTop 0
    $('.sp-list').removeAttr('style')
  setTimeout scrollFix, 100

exports.createShareFunction = (source) ->
  return (e) ->
    e.preventDefault()
    models.application.showSharePopup e.target, source.data.uri
