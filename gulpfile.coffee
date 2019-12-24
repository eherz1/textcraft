gulp        = require 'gulp'
nodemon     = require 'gulp-nodemon'

gulp.task 'default', [ 'nodemon' ]

gulp.task 'nodemon', ->
  nodemon script: 'src/coffee/main.coffee', ext: 'coffee'

