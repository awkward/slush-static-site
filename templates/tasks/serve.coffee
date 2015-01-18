gulp        = require 'gulp'
browserSync = require 'browser-sync'

gulp.task 'serve', ->
  browserSync
    server:
      baseDir: 'build/'
    open: true