class GoogleTracker
  constructor: (trackingCode, userId, appVersion) ->
    window._gaq = if _gaq? then _gaq else []
    window._gaq.push [ '_setAccount', trackingCode ]
    window._gaq.push ['_setCustomVar', 1, 'userId', userId, 1]
    window._gaq.push ['_setCustomVar', 2, 'version', appVersion, 3]
    do ->
      ga = document.createElement 'script'
      ga.type = 'text/javascript'
      ga.async = true
      ga.src = (if 'https:' is document.location.protocol then 'https://ssl' else 'http://www') + '.google-analytics.com/ga.js'
      s = document.getElementsByTagName('script')[0]
      s.parentNode.insertBefore ga, s
  track: (page) =>
    window._gaq.push ['_trackPageview', page]
  event: (category, action, label, value) =>
    if value?
      window._gaq.push ['_trackEvent', category, action, label, value]
    else
      window._gaq.push ['_trackEvent', category, action, label]

exports.GoogleTracker = GoogleTracker
