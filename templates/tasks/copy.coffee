gulp = require 'gulp'

gulp.task 'copy', ->
  src = ['./src/assets/fonts/**', './src/assets/images/**']
  gulp.src(src, { base: './src'})
    .pipe(gulp.dest('./build/'))
