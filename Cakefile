{exec} = require 'child_process'
appName = 'app-template'

execCallback = (err, stdout, stderr) ->
  throw err if err
  console.log stdout + stderr

task 'build', 'Build project from src/*.coffee to lib/*.js', ->
  console.log 'building...'
  exec 'coffee --compile --output lib/ src/', execCallback

task 'open', 'Open the app in the spotify client (mac only)', ->
  console.log 'opening app in spotify client...'
  exec "open spotify:app:#{appName}", execCallback

task 'release', 'Zip up the spotify app assets for release and place it in the release directory.', ->
  console.log 'releasing...'
  # make sure the build is up to date
  exec 'coffee --compile --output lib/ src/', (err, stdout, stderr) ->
    throw err if err

    # make sure 'release' dir exists
    exec 'mkdir release', (err, stdout, stderr) ->

      # create zip
      exec "zip -r release/#{appName} . -x src/* src/ release/* *.iml .idea *.iml .git* README.md Cakefile", (err, stdout, stderr) ->
        throw err if err
        console.log "created release/#{appName}.zip"
