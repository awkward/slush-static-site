import gulp from 'gulp';
import loadPlugins from 'gulp-load-plugins';
import browserSync from 'browser-sync';
import nodeNeat from 'node-neat';
import nodeBourbon from 'node-bourbon';
import autoprefixer from 'autoprefixer';
import mqpacker from 'css-mqpacker';

const plugins = loadPlugins();
const neat = nodeNeat.includePaths;
const bourbon = nodeBourbon.includePaths;
const reload = browserSync.reload;

gulp.task('styles', () => {

  const processors = [
    autoprefixer({browsers: ['last 2 versions']}),
    mqpacker
  ];

  gulp.src('./src/stylesheets/main.sass')
    .pipe(plugins.plumber({errorHandler: plugins.notify.onError((error) => error.message)}))
    .pipe(plugins.sourcemaps.init())
    .pipe(plugins.sass({
      includePaths: [ './node_modules' ].concat(neat, bourbon),
      sourceComments: 'normal'
    }))
    .pipe(plugins.postcss(processors))
    .pipe(plugins.sourcemaps.write())
    .pipe(gulp.dest('./build/stylesheets/'))
    .pipe(reload({stream: true}));
});
