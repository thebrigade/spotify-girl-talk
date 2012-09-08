exports.tracker = tracker = if config.debug then new spore.DebugTracker() else new googletracker.GoogleTracker config.analyticsKey, models.session.anonymousUserID, config.appVersion

exports.init = =>
  trace 'main.init()'
  window.onerror = (e) ->
    console.error "encountered an unexpected error: #{e}"

  # create views and model objects
  mainView = new views.MainView()

  app = new spore.Spore sp, config.trace, config.appName, tracker

  # register presenters
  app.register 'main', new presenters.MainPresenter mainView

  # prevent image dragging on all img tags
  $('img').live 'dragstart', (event) -> event.preventDefault()

  # start
  app.go()
