import gulp from 'gulp';

gulp.task('watch', () => {

  gulp.watch(['./src/**/*.js'], ['browserify']);
  gulp.watch(['./src/**/*.jade'], ['templates']);
  gulp.watch(['./src/**/*.sass'], ['styles']);

});
