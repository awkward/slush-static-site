gulp        = require 'gulp'
requireDir  = require 'require-dir'
dir         = requireDir './tasks'

# TODO: make browserify watch optional and add it to build task
gulp.task 'build', ['templates', 'styles', 'copy']
gulp.task 'default', ['build', 'serve', 'browserify','watch']
gulp.task 'compress', ['build', 'uglify']
gulp.task 'deploy', ['compress', 's3']
