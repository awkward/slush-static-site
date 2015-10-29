/*
  slush-static-site
  https://github.com/awkward/slush-static-site

  Copyright (c) 2015, Awkward
  Licensed under the MIT license.
*/

"use strict"

const gulp      = require("gulp")
const install   = require("gulp-install")
const conflict  = require("gulp-conflict")
const template  = require("gulp-template")
const rename    = require("gulp-rename")
const _string   = require("underscore.string")
const _         = require("lodash")
const inquirer  = require("inquirer")
const merge     = require("merge-stream")

const format = (string) => string.toLowerCase().replace(/\s/g, "");

const defaults = (() => {

  const homeDir         = process.env.HOME || process.env.HOMEPATH || process.env.USERPROFILE;
  const workingDirName  = process.cwd().split("/").pop().split("\\").pop();
  const osUserName      = homeDir && homeDir.split("/").pop() || "root";
  const configFile      = homeDir + "/.gitconfig";
  const user            = (() => {
    if(require("fs").existsSync(configFile)) {
      return require("iniparser").parseSync(configFile).user;
    } else {
      return {name: "", email: ""};
    }
  })();

  return {
    projectName:    workingDirName,
    userName:       user.name,
    authorEmail:    user.email,
    license:        'MIT',
    s3Key:          'YOUR_S3_KEY',
    s3Secret:       'YOUR_S3_SECRET',
    s3Bucket:       'dev.example.com',
    s3Region:       'us-east-1',
    projectCss:     'bourbon/neat'
  }

})();

const prompts = ((defaults) => {

  return [
    {
      name: "projectName",
      message: "What is the name of your project?",
      default: defaults.projectName
    },
    {
      name: "projectDescription",
      message: "What is the description?"
    },
    {
      name: "projectVersion",
      message: "What is the version of your project?",
      default: "0.1.0"
    },
    {
      type: "list",
      name: "projectCss",
      message: "What do you want to use as a base for styling?",
      choices: ['bourbon/neat', 'bootstrap'],
      default: defaults.projectCss
    },
    {
      name: "authorName",
      message: "What is the author name?",
      default: defaults.userName
    },
    {
      name: "authorEmail",
      message: "What is the author email?",
      default: defaults.authorEmail
    },
    {
      name: "userName",
      message: "What is the github username?",
      default: defaults.userName
    },
    {
      type: "confirm",
      name: "useS3",
      message: "do you want to enter your s3 credentials for deployment?"
    },
    {
      type: "input",
      name: "s3Key",
      message: "What is your s3 key?",
      default: defaults.s3Key,
      when: (answers) => answers.useS3
    },
    {
      type: "input",
      name: "s3Secret",
      message: "What is your s3 secret key?",
      default: defaults.s3Secret,
      when: (answers) => answers.useS3
    },
    {
      type: "input",
      name: "s3Bucket",
      message: "What is the name of your s3 bucket?",
      default: defaults.s3Bucket,
      when: (answers) => answers.useS3
    },
    {
      type: "input",
      name: "s3Region",
      message: "What is the bucket's region?",
      default: defaults.s3Region,
      when: (answers) => answers.useS3
    },
    {
      name: "license",
      message: "What is the license?",
      default: defaults.license
    },
    {
      type: "confirm",
      name: "moveon",
      message: "Continue?"
    }
  ];

});

gulp.task("default", (done) => {

  // Ask
  inquirer.prompt(prompts(defaults), (answers) => {

    if (!answers.moveon) return done();

    let answers_and_defaults = _.extend(defaults, answers);
    answers_and_defaults.projectNameSlug = _string.slugify(answers_and_defaults.projectName);

    gulp.src([__dirname + "/templates/**"])
      .pipe(template(answers_and_defaults))
      .pipe(rename((file) => {

        if(file.basename[0] === "_" && file.dirname === ".") file.basename = "." + file.basename.slice(1)
        if(file.basename[0] === "_" && file.basename[1] === "_") file.basename = "_" + file.basename.slice(2)

      }))
      .pipe(conflict("./"))
      .pipe(gulp.dest("./"))
      .pipe(install())
      .on("end", done);
  });

});
