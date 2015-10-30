import gulp from 'gulp';
import loadPlugins from 'gulp-load-plugins';
import fs from 'fs';

const plugins = loadPlugins();

gulp.task('s3', ['compress'], () => {
  const aws = JSON.parse(fs.readFileSync('./aws.json'))
  gulp.src('dist/**')
    .pipe(plugins.s3(aws));
});
