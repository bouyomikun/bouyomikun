'use strict'

gulp = require 'gulp'
$ = do require 'gulp-load-plugins'
jeditor = require 'gulp-json-editor'
reload = $.livereload.reload

gulp.task 'elements', ->
  gulp.src 'src/elements/elements.html'
    .pipe $.vulcanize
      stripComments: true
      inlineCss: true
      inlineScripts: true
    .pipe do $.crisper
    .pipe gulp.dest 'dev/elements'
    .pipe $.size title: 'elements'

gulp.task 'html', ->
  gulp.src 'src/*.html'
    .pipe $.replace /<\/body>/,
      '<script src="dev/chromereload.js"></script></body>'
    .pipe gulp.dest 'dev'
    .pipe $.size title: 'html'

gulp.task 'manifest', ->
  gulp.src 'src/manifest.yaml'
    .pipe do $.yaml
    .pipe jeditor (json) ->
      json.permissions.push '*://localhost/*'
      return json
    .pipe gulp.dest 'dev'
    .pipe $.size title: 'manifest'

gulp.task 'script', ->
  gulp.src 'src/scripts/*.coffee'
    .pipe do $.coffee
    .pipe gulp.dest 'dev/scripts'
    .pipe $.size title: 'script'

gulp.task 'styles', ->
  gulp.src 'src/styles/*.sass'
    .pipe do $.sass
    .pipe gulp.dest 'dev/styles'

gulp.task 'watch', ['elements', 'html', 'manifest', 'script', 'styles'], ->
  do $.livereload.listen

  gulp.watch 'src/elements/*', ['elements', reload]
  gulp.watch 'src/*.html', ['html', reload]
  gulp.watch 'src/manifest.json', ['manifest']
  gulp.watch 'src/scripts/*.coffee', ['script', reload]
  gulp.watch 'src/styles/*.sass', ['styles', reload]
  return
