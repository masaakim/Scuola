module.exports = (grunt) ->
  grunt.initConfig
    sass:
      dist:
        files:
          "build/scuola.css": "scss/scuola.scss"

    styleguide:
      styledocco:
        options:
          name: "Project Name"
          framework:
            name: "styledocco"
            options:
              preprocessor: "sass"

          template:
            include: ["_previews.js"]

        src: ["scss/*.scss"]
        dest: "docs"

    clean:
      styleguide: ["<%= styleguide.styledocco.dest %>"]

    connect:
      app:
        options:
          port: 2020
          base: "build/"
          open: "http://localhost:2020"

      doc:
        options:
          port: 2021
          base: "build/"
          open: "http://localhost:2021"

    csscomb:
      dist:
        options:
          config: ".csscombrc"

        files:
          "build/scuola.css": ["build/scuola.css"]

    csslint:
      dist:
        options:
          csslintrc: ".csslintrc"

      src: ["build/scuola.css"]

    watch:
      options:
        livereload: true

      stylesheets:
        files: ["scss/*.scss"]
        tasks: ["stylesheet"]

  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-contrib-sass"
  grunt.loadNpmTasks "grunt-contrib-compass"
  grunt.loadNpmTasks "grunt-styleguide"
  grunt.loadNpmTasks "grunt-contrib-clean"
  grunt.loadNpmTasks "grunt-contrib-csslint"
  grunt.loadNpmTasks "grunt-csscomb"
  grunt.loadNpmTasks "grunt-contrib-connect"

  grunt.registerTask "default", ["develop"]
  grunt.registerTask "develop", [
    "connect:app"
    "watch"
  ]
  grunt.registerTask "stylesheet", [
    "sass"
    "csslint"
    "csscomb"
  ]
  grunt.registerTask "publish", [
    "stylesheet"
    "clean"
    "styleguide"
    "connect:doc"
    "watch"
  ]
  return
