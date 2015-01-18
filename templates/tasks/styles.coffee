gulp    = require 'gulp'
sass    = require 'gulp-sass'
reload  = require('browser-sync').reload
neat    = require('node-neat').includePaths
gutil   = require 'gulp-util'
plumber = require 'gulp-plumber'
notify  = require 'gulp-notify'

gulp.task 'styles', ->
  gulp.src('./src/stylesheets/main.sass')
    .pipe(plumber({errorHandler: notify.onError((error) -> error.message)}))
    .pipe(sass(
      includePaths: [ './src/vendor' ].concat(neat)
      sourceComments: 'normal'
    ))
    .pipe(gulp.dest('./build/stylesheets/'))
    .pipe(reload(stream: true))
