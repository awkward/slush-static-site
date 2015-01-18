gulp = require 'gulp'

gulp.task 'watch', ->
  gulp.watch ['./src/**/*.coffee'], ['browserify']
  gulp.watch ['./src/**/*.jade'], ['templates']
  gulp.watch ['./src/**/*.sass'], ['styles']
