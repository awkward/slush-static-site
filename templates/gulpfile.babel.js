import gulp from 'gulp';
import requireDir from 'require-dir';

requireDir('./tasks');

gulp.task('build', ['templates', 'styles', 'copy']);
gulp.task('default', ['build', 'serve', 'browserify','watch']);
gulp.task('compress', ['build', 'uglify']);
gulp.task('deploy', ['compress', 's3']);
