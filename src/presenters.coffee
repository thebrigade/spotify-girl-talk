########################################################################################################################
##### Tab1Presenter ###############################################################################################
class Tab1Presenter extends spore.Presenter
  constructor: (@view) ->
  bind: () =>
  show: (params) =>
    @view.setLoading true
    @view.hide()
    @view.clear()

    after 1000, =>
      @view.display()
      @view.show()

  unbind: () =>
    @view.hide()

exports.Tab1Presenter = Tab1Presenter
########################################################################################################################


########################################################################################################################
##### Tab2Presenter ###############################################################################################
class Tab2Presenter extends spore.Presenter
  constructor: (@view) ->
  bind: () =>
  show: (params) =>
    @view.setLoading true
    @view.hide()
    @view.clear()

    after 1000, =>
      @view.display()
      @view.show()

  unbind: () =>
    @view.hide()

exports.Tab2Presenter = Tab2Presenter
########################################################################################################################
