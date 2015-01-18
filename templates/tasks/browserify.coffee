gulp          = require 'gulp'
browserify    = require 'browserify'
reload        = require('browser-sync').reload
source        = require 'vinyl-source-stream'
watchify      = require 'watchify'
gutil         = require 'gulp-util'
plumber       = require 'gulp-plumber'
notify        = require 'gulp-notify'

gulp.task 'browserify', ->

  browserifyThis = do ->
    bundler = browserify
      cache: {}, packageCache: {}, fullPaths: true,
      entries: './src/scripts/main.coffee',
      extensions: ['.coffee', '.jade'],
      debug: true
    bundle = ->
      return bundler.bundle()
        .on('error', ->
          args = Array.prototype.slice.call arguments
          notify.onError((error) -> error.message
          ).apply(@, args)
        )
        .pipe(source('main.js'))
        .pipe(gulp.dest('./build/scripts/'))
        .pipe(reload(stream: true))

    bundler = watchify(bundler)
    bundler.on('update', bundle)

    return bundle()
