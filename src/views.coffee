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
    @el.text 'main'

  hide: () =>
    @el.hide()

exports.MainView = MainView
########################################################################################################################
