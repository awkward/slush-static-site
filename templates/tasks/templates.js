import gulp from 'gulp';
import loadPlugins from 'gulp-load-plugins';
import browserSync from 'browser-sync';

const plugins = loadPlugins();
const reload = browserSync.reload;

gulp.task('templates', () => {

  gulp.src(['./src/*.jade', './src/**/*.jade'])
    .pipe(plugins.plumber({errorHandler: plugins.notify.onError((error) => error.message)}))
    .pipe(plugins.jade({
      pretty: true
    }))
    .pipe(gulp.dest('./build/'))
    .pipe(reload({stream: true}));
});
