exports.tracker = tracker = if config.debug then new spore.DebugTracker() else new googletracker.GoogleTracker config.analyticsKey, models.session.anonymousUserID, config.appVersion

exports.init = =>
  trace 'main.init()'
  window.onerror = (e) ->
    console.error "encountered an unexpected error: #{e}"

  # create views and model objects
  tab1View = new views.Tab1View()
  tab2View = new views.Tab2View()

  app = new spore.Spore sp, config.trace, config.appName, tracker

  # register presenters
  app.register 'tab1',     new presenters.Tab1Presenter tab1View
  app.register 'tab2',     new presenters.Tab2Presenter tab2View

  # prevent image dragging on all img tags
  $('img').live 'dragstart', (event) -> event.preventDefault()

  # start
  app.go()
