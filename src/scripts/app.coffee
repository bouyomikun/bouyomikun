'use strict';

app = document.querySelector '#app'

app.volume = 1.00
app.rate = 1.00
app.pitch = 1.00

app.addEventListener 'dom-change', ->
  chrome.tts.getVoices (voices) ->
    app.voices = voices

app.onPlay = ->
  voice = app.voices[app.voiceIndex]
  options = onEvent: (event) ->
    switch event.type
      when 'error'
        do app.$.toastErrorPlay.show
  for k in ['rate', 'pitch', 'volume']
    options[k] = app[k]
  for k in ['voiceName', 'extensionId', 'lang', 'gender']
    options[k] = voice[k]
  chrome.tts.speak app.text, options
