every    = (interval, callback) -> setInterval callback, interval
after    = (delay, callback) -> setTimeout callback, delay
pollInterval = 20

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
    @startPollingTrack()

  unbind: () =>
    @view.hide()

  playerChange: (playerChange) =>
    console.log "got player change"
    console.log playerChange
    @startPollingTrack()

  startPollingTrack: () =>
    if @poller?
      clearInterval @poller
    @poller = every pollInterval, () =>
      @view.showPosition models.player.position

exports.MainPresenter = MainPresenter
########################################################################################################################
