every    = (interval, callback) -> setInterval callback, interval
after    = (delay, callback) -> setTimeout callback, delay
pollInterval = 20
#pollInterval = 1000

########################################################################################################################
##### MainPresenter ###############################################################################################
class MainPresenter extends spore.Presenter
  constructor: (@view) ->
  bind: () =>
  show: (params) =>
    @view.setLoading true
    @view.hide()
    @view.clear()

    @view.display()
    @view.show()

    models.Track.fromURI 'spotify:track:4fOFWrYmRUfS9sC9TyOlUb', (spotifyTrack) =>
      models.player.play spotifyTrack
      @startPollingTrack()

  unbind: () =>
    @view.hide()

  startPollingTrack: () =>
    @startQueue = JSON.parse (JSON.stringify model.model)
    @endQueue = JSON.parse (JSON.stringify model.model)

    if @poller?
      clearInterval @poller
    @poller = every pollInterval, () =>
      pos = models.player.position
      @view.showPosition pos

      if @startQueue.length > 0
        if pos >= @startQueue[0].start
          record = @startQueue.shift()
          @view.startTrack record

      if @endQueue.length > 0
        if pos >= @endQueue[0].end
          record = @endQueue.shift()
          @view.endTrack record


exports.MainPresenter = MainPresenter
########################################################################################################################
