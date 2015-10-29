import gulp from 'gulp';
import loadPlugins from 'gulp-load-plugins';
import pngcrush from 'imagemin-pngcrush';
import merge from 'merge-stream';
import csswring from 'csswring';

const plugins = loadPlugins({
  rename: {
    "gulp-minify-css": "minifyCSS",
    "gulp-minify-html": "minifyHTML"
  }
});

gulp.task('uglify', () => {

  const js = gulp.src('build/**/*/.js')
    .pipe(plugins.uglify())
    .pipe(gulp.dest('dist'));

  const css = gulp.src('build/**/*.css')
    .pipe(plugins.postcss([csswring]))
    .pipe(gulp.dest('dist'));

  const html = gulp.src('build/**/*.html')
    .pipe(plugins.minifyHTML())
    .pipe(gulp.dest('dist'));

  const images = gulp.src('./build/assets/images/**')
    .pipe(plugins.imagemin({
      progressive: true,
      svgoPlugins: [{removeViewBox: false}],
      use: [pngcrush()]
    }))
    .pipe(gulp.dest('./dist/assets/images/'));

  const fonts = gulp.src('./build/assets/fonts/**')
    .pipe(gulp.dest('./dist/assets/fonts/'));

  return merge(js, css, html, images, fonts);

});
