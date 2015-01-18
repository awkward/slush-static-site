gulp  = require 'gulp'
s3    = require 'gulp-s3'
fs    = require 'fs'

gulp.task 's3', ['compress'], ->
  aws = JSON.parse(fs.readFileSync('./aws.json'))
  gulp.src('dist/**')
    .pipe(s3(aws))