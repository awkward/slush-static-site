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
  s3Key:          'AKIAI3Z7CUAFHG53DMJA'
  s3Secret:       'acYxWRu5RRa6CwzQuhdXEfTpbQA+1XQJ7Z1bGTCx'
  s3Bucket:       'dev.example.com'
  s3Region:       'us-east-1'
)()


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
      type: "list"
      name: "projectStyles"
      message: "What do you want to use as a base for styling?"
      choices: ['bourbon/neat', 'bootstrap']
      default: 'bourbon/neat'
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
      type: "confirm"
      name: "useS3"
      message: "do you want to enter your s3 credentials for deployment?"
    }
    {
      type: "input"
      name: "s3Key"
      message: "What is your s3 key?"
      when: (answers) -> return answers.useS3
    }
    {
      type: "input"
      name: "s3Secret"
      message: "What is your s3 secret key?"
      when: (answers) -> return answers.useS3
    }
    {
      type: "input"
      name: "s3Bucket"
      message: "What is the name of your s3 bucket?"
      when: (answers) -> return answers.useS3
    }
    {
      type: "input"
      name: "s3Region"
      message: "What is the bucket's region? (e.g. us-east-1)"
      when: (answers) -> return answers.useS3
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


