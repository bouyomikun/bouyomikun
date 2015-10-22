'use strict'

gulp = require 'gulp'
$ = do require 'gulp-load-plugins'

gulp.task 'elements', ->
  gulp.src 'src/elements/elements.html'
    .pipe $.vulcanize
      stripComments: true
      inlineCss: true
      inlineScripts: true
    .pipe do $.crisper
    .pipe $.replace /coffee\/(.*)\.coffee/, 'scripts/$1.js'
    .pipe gulp.dest 'dev/elements'
    .pipe $.size title: 'elements'

gulp.task 'html', ->
  gulp.src 'src/*.html'
    .pipe $.replace /coffee\/(.*)\.coffee/, 'scripts/$1.js'
    .pipe gulp.dest 'dev'
    .pipe $.size title: 'html'

gulp.task 'manifest', ->
  gulp.src 'src/manifest.yaml'
    .pipe do $.yaml
    .pipe $.replace /coffee\/(.*)\.coffee/, 'scripts/$1.js'
    .pipe gulp.dest 'dev'
    .pipe $.size title: 'manifest'

gulp.task 'script', ->
  gulp.src 'src/coffee/*.coffee'
    .pipe do $.coffee
    .pipe $.replace /coffee\/(.*)\.coffee/, 'scripts/$1.js'
    .pipe gulp.dest 'dev/scripts'
    .pipe $.size title: 'script'

gulp.task 'watch', ['elements', 'html', 'manifest', 'script'], ->
  gulp.watch 'src/elements/*', ['elements']
  gulp.watch 'src/*.html', ['html']
  gulp.watch 'src/manifest.json', ['manifest']
  gulp.watch 'src/coffee/*.coffee', ['script']
  return
