database = angular.module 'ngDatabase', Array

database.factory '$database', Array ->
    new class Database
        sql: {}

        createTable: ->
            return

        select: (param) ->
            if typeof param is 'undefined'
                param = ['*']

            @sql['SELECT'] = param

            @

        insert: ->
            @

        update: ->
            @

        where: (field, value, operator) ->
            if typeof operator is 'undefined'
                operator = '='

            @sql['WHERE'] = field + ' ' + operator + ' \'' + value + '\''

            @

        from: (param) ->
            @sql['FROM'] = param

            @

        exec: ->
            return
