module.exports = function(grunt) {
    require('load-grunt-tasks')(grunt);

    grunt.initConfig({
        coffee: {
            compile: {
                options: {
                    bare: true
                },
                files: {
                    'dist/angular-database.js': 'dev/angular-database.coffee'
                }
            },
            tests: {
                options: {
                    bare: true
                },
                files: {
                    'tests/angular-database.js': 'dev/tests/angular-database.coffee'
                }
            }
        },

        uglify: {
            options: {
                mangle: false
            },
            dist: {
                files: {
                    'dist/angular-datbase.min.js': ['dist/angular-database.js']
                }
            }
        },

        flo: {
            serve: {
                options: {
                    dir: './',
                    glob: [
                        'dev//*'
                    ],
                    resolvers: [{
                        files: [
                            'dev/*.coffee'
                        ],
                        tasks: ['coffee', 'uglify']
                    }]
                }
            }
        }
    });

    grunt.registerTask('default', ['flo']);

    grunt.registerTask('tasks', ['coffee:*', 'uglify']);
};
