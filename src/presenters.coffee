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

  unbind: () =>
    @view.hide()

exports.MainPresenter = MainPresenter
########################################################################################################################
