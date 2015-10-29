import gulp from 'gulp';
import browserSync from 'browser-sync';

gulp.task('serve', () => {
  browserSync({
    server: {
      baseDir: 'build/'
    },
    open: true
  });
});
