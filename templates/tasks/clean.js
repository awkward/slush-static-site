import gulp from 'gulp';
import del from 'del';

gulp.task('clean', (cb) => del(['./build', './dist'], cb));
