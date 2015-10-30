import gulp from 'gulp';
import loadPlugins from 'gulp-load-plugins';
import browserify from 'browserify';
import browserSync from 'browser-sync';
import source from 'vinyl-source-stream';
import watchify from 'watchify';

const plugins = loadPlugins();
const reload = browserSync.reload;

gulp.task('browserify', () => {

  const browserifyThis = (() => {
    let bundler = browserify({
      cache: {}, packageCache: {}, fullPaths: true,
      entries: './src/scripts/main.js',
      extensions: ['.js'],
      debug: true
    });

    const bundle = () => {
      return bundler.bundle()
        .on('error', () => {
          const args = Array.prototype.slice.call(arguments);
          return plugins.notify.onError((error) => error.message).apply(this, args);
        })
        .pipe(source('main.js'))
        .pipe(gulp.dest('./build/scripts'))
        .pipe(reload({stream: true}));
    }

    bundler = watchify(bundler);
    bundler.on('update', bundle);

    return bundle();
  })();


});
