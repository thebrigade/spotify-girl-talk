csv = require 'ya-csv'
moment = require 'moment'

model = []

reader = csv.createCsvFileReader "data.csv",
  separator: ','
  quote: '"'
  escape: '"'
  comment: ''


###
[ '4',
  'What It\'s All About',
  '0:04:15',
  'The Cure',
  'Close To Me',
  '1985',
  '0:00:40',
  '16%',
  'Y',
  'spotify:track:0L31hObKkJgFW0S4a125Ie',
  '' ]
###
millisecondsFromText = (text) ->
  chunks = text.split ':'
  chunks.pop()
  sec = parseInt chunks.pop()
  min = parseInt chunks.pop()
  return (min * 60 * 1000) + (sec * 1000)

started = false
reader.addListener "data", (data) ->
  if not started
    started = true
    return
  track = parseInt data[0]
  return if track isnt 4
  record =
    track: track
    start: millisecondsFromText data[6]
    end: millisecondsFromText data[10]
    uri: data[9]
  model.push record

reader.addListener "end", () ->
  console.log JSON.stringify model
