gulp          = require 'gulp'
uglify        = require 'gulp-uglify'
imagemin      = require 'gulp-imagemin'
pngcrush      = require 'imagemin-pngcrush'
minifyCSS     = require 'gulp-minify-css'
minifyHTML    = require 'gulp-minify-html'
autoprefixer  = require 'gulp-autoprefixer'
merge         = require 'merge-stream'

gulp.task 'uglify', ['build'], ->

  js = gulp.src('build/**/*.js')
    .pipe(uglify())
    .pipe(gulp.dest('dist'))

  css = gulp.src('build/**/*.css')
    .pipe(autoprefixer(
      browsers: ['last 2 versions'],
      cascade: false
    ))
    .pipe(minifyCSS())
    .pipe(gulp.dest('dist'))

  html = gulp.src('build/**/*.html')
    .pipe(minifyHTML())
    .pipe(gulp.dest('dist'))

  images = gulp.src('./build/assets/images/**')
    .pipe(imagemin(
      progressive: true
      svgoPlugins: [{removeViewBox: false}]
      use: [pngcrush()]
    ))
    .pipe(gulp.dest('./dist/assets/images/'))

  fonts = gulp.src('./build/assets/fonts/**')
    .pipe(gulp.dest('./dist/assets/fonts/'))

  merge(js, css, html, images, fonts)
