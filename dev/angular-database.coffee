database = angular.module 'ngDatabase', Array

database.factory '$database', Array ->
    new class Database
        sql: null

        createTable: ->
            return

        select: ->
            return

        insert: ->
            return

        update: ->
            return

        where: ->
            return
