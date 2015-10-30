import gulp from 'gulp';

gulp.task('copy', () => {

  const src = ['./src/assets/fonts/**', './src/assets/images/**'];
  gulp.src(src, { base: './src' })
    .pipe(gulp.dest('./build/'));

});
