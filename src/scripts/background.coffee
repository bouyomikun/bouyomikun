'use strict';

chrome.app.runtime.onLaunched.addListener ->
  chrome.app.window.create 'index.html',
    outerBounds:
      width: 400
      height: 500
