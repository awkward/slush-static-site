#
# * slush-static-site
# * https://github.com/jchn/slush-static-site
# *
# * Copyright (c) 2015, John van de Water
# * Licensed under the MIT license.
# 

"use strict"

gulp      = require("gulp")
install   = require("gulp-install")
conflict  = require("gulp-conflict")
template  = require("gulp-template")
rename    = require("gulp-rename")
_         = require("underscore.string")
inquirer  = require("inquirer")
merge     = require("merge-stream")

format = (string) ->
  username = string.toLowerCase()
  username.replace /\s/g, ""


defaults = (->
  homeDir         = process.env.HOME or process.env.HOMEPATH or process.env.USERPROFILE
  workingDirName  = process.cwd().split("/").pop().split("\\").pop()
  osUserName      = homeDir and homeDir.split("/").pop() or "root"
  configFile      = homeDir + "/.gitconfig"
  user            = {}
  user            = require("iniparser").parseSync(configFile).user  if require("fs").existsSync(configFile)
  projectName:    workingDirName
  userName:       format(user.name) or osUserName
  authorEmail:    user.email or ""
  license:        'MIT'
)()


gulp.task "copy", ->

gulp.task "default", (done) ->
  prompts = [
    {
      name: "projectName"
      message: "What is the name of your project?"
      default: defaults.projectName
    }
    {
      name: "projectDescription"
      message: "What is the description?"
    }
    {
      name: "projectVersion"
      message: "What is the version of your project?"
      default: "0.1.0"
    }
    {
      name: "authorName"
      message: "What is the author name?"
    }
    {
      name: "authorEmail"
      message: "What is the author email?"
      default: defaults.authorEmail
    }
    {
      name: "userName"
      message: "What is the github username?"
      default: defaults.userName
    }
    {
      name: "license"
      message: "What is the license?"
      default: defaults.license
    }
    {
      type: "confirm"
      name: "moveon"
      message: "Continue?"
    }
  ]
  
  #Ask
  inquirer.prompt prompts, (answers) ->

    return done()  unless answers.moveon

    answers.projectNameSlug = _.slugify(answers.projectName)
    gulp.src([__dirname + "/templates/**"])
    .pipe(template(answers)).pipe(rename((file) ->
      file.basename = "." + file.basename.slice(1)  if file.basename[0] is "_" and file.basename[1] isnt "_"
      file.basename = "_" + file.basename.slice(2)  if file.basename[0] is "_" and file.basename[1] is "_"
      return
    )).pipe(conflict("./")).pipe(gulp.dest("./")).pipe(install()).on "end", done


