class SQLAdapter
    db: null

    stmt: null

    constructor: ->
        @db = new SQL.Database()
        return

    openDatabase: ->
        return

    exec: (sql) ->
        @db.run sql
        @

    prepare: (sql) ->
        @stmt = @db.prepare sql
        @

    getResult: ->
        rows = []

        while (@stmt.step())
            rows.push @stmt.getAsObject()

        rows
