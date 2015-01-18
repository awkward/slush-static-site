gulp   = require 'gulp'
clean  = require 'gulp-clean'
merge  = require 'merge-stream'

gulp.task 'clean', ->
  build = gulp.src('build', read: false)
    .pipe(clean())

  dist = gulp.src('dist', read: false)
    .pipe(clean())

  merge(build, dist)