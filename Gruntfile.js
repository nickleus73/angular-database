module.exports = function(grunt) {
    require('load-grunt-tasks')(grunt);

    grunt.initConfig({
        coffee: {
            compile: {
                options: {
                    bare: true
                },
                files: {
                    'dist/angular-database.js': 'dev/angular-database.coffee',
                    'dist/adapters/sqljs.js': 'dev/adapters/sqljs.coffee'
                }
            },
            tests: {
                options: {
                    bare: true
                },
                files: {
                    'tests/angular-database.js': 'dev/tests/angular-database.coffee',
                    'tests/angular-database-model.js': 'dev/tests/angular-database-model.coffee',
                    'tests/adapters/sqljs.js': 'dev/tests/adapters/sqljs.coffee'
                }
            }
        },

        uglify: {
            options: {
                mangle: false
            },
            dist: {
                files: {
                    'dist/angular-datbase.min.js': ['dist/angular-database.js'],
                    'dist/adapters/sqljs-min.js': ['dist/adapters/sqljs.js']
                }
            }
        },

        flo: {
            serve: {
                options: {
                    dir: './',
                    glob: [
                        'dev/*',
                        'dev/test/*'
                    ],
                    resolvers: [{
                        files: [
                            'dev/*.coffee',
                            'dev/**/*.coffee',
                            'dev/tests/*.coffee',
                            'dev/tests/**/*.coffee'
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
