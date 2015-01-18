gulp    = require 'gulp'
jade    = require 'gulp-jade'
reload  = require('browser-sync').reload
gutil   = require 'gulp-util'
plumber = require 'gulp-plumber'
notify  = require 'gulp-notify'

gulp.task 'templates', ->
  gulp.src('./src/*.jade')
    .pipe(plumber({errorHandler: notify.onError((error)-> error.message)}))
    .pipe(jade(
      pretty: true
    ))
    .pipe(gulp.dest('./build/'))
    .pipe(reload(stream: true))
