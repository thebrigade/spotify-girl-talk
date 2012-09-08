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
##### Tab1View ########################################################################################################
class Tab1View extends BaseView
  constructor: () ->
    @el = $ '#tab1'

  show: () =>
    @el.show()
    window.scrollTo(0,0)
    @setLoading false

  clear: () =>
    @el.empty()

  display: () =>
    @el.text 'hey, tab1'

  hide: () =>
    @el.hide()

exports.Tab1View = Tab1View
########################################################################################################################


########################################################################################################################
##### Tab2View ########################################################################################################
class Tab2View extends BaseView
  constructor: () ->
    @el = $ '#tab2'

  show: () =>
    @el.show()
    window.scrollTo(0,0)
    @setLoading false

  clear: () =>
    @el.empty()

  display: () =>
    template = ->
      h1 'Hey There'
      h3 "Welcome to #{@arg}"
    @el.append CoffeeKup.render template, arg: 'tab2'

  hide: () =>
    @el.hide()

exports.Tab2View = Tab2View
########################################################################################################################
