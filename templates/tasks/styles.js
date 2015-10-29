import gulp from 'gulp';
import loadPlugins from 'gulp-load-plugins';
import browserSync from 'browser-sync';
import nodeNeat from 'node-neat';
import nodeBourbon from 'node-bourbon';

const plugins = loadPlugins();
const neat = nodeNeat.includePaths;
const bourbon = nodeBourbon.includePaths;
const reload = browserSync.reload;

gulp.task('styles', () => {

  gulp.src('./src/stylesheets/main.sass')
    .pipe(plugins.plumber({errorHandler: plugins.notify.onError((error) => error.message)}))
    .pipe(plugins.sass({
      includePaths: [ './src/vendor' ].concat(neat, bourbon),
      sourceComments: 'normal'
    }))
    .pipe(gulp.dest('./build/stylesheets/'))
    .pipe(reload({stream: true}));
});
