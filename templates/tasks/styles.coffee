gulp    = require 'gulp'
sass    = require 'gulp-sass'
reload  = require('browser-sync').reload
gutil   = require 'gulp-util'
plumber = require 'gulp-plumber'
notify  = require 'gulp-notify'

<% if (projectCss === 'bourbon/neat') { %>
neat    = require('node-neat').includePaths


gulp.task 'styles', ->
  gulp.src('./src/stylesheets/main.sass')
    .pipe(plumber({errorHandler: notify.onError((error) -> error.message)}))
    .pipe(sass(
      includePaths: [ './src/vendor' ].concat(neat)
      sourceComments: 'normal'
    ))
    .pipe(gulp.dest('./build/stylesheets/'))
    .pipe(reload(stream: true))

<% } else if (projectCss === 'bootstrap') { %>

gulp.task 'styles', ->
  gulp.src('./src/stylesheets/main.sass')
    .pipe(plumber({errorHandler: notify.onError((error) -> error.message)}))
    .pipe(sass(
      includePaths: [ './src/vendor', './src/vendor/bootstrap-sass/assets/stylesheets' ]
      sourceComments: 'normal'
    ))
    .pipe(gulp.dest('./build/stylesheets/'))
    .pipe(reload(stream: true))

<% } else { %>

<% } %>
