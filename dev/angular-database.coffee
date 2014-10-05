database = angular.module 'ngDatabase', Array

database.factory '$database', Array ->
    new class Database
        sql: {}

        req: null

        order_command: [
            'INSERT',
            'UPDATE',
            'SELECT',
            'FROM',
            'WHERE',
            'AND WHERE',
            'OR WHERE'
        ]

        adapter: {}

        setAdapter: (adapter) ->
            @adapter = adapter
            return

        createTable: ->
            return

        select: (param) ->
            if typeof param is 'undefined'
                param = ['*']

            @sql['SELECT'] = param

            @

        insert: (table, cols, values) ->
            @sql['INSERT'] = {
                'TABLE': table,
                'PARAMS': {
                    'COLS': cols,
                    'VALUES': values
                }
            }

            @

        update: (table, params) ->
            array = []

            for param in params
                for field, value of param
                    array.push field + ' = \'' + value + '\''

            @sql['UPDATE'] = {
                'TABLE': table,
                'PARAMS': array
            }

            @

        where: (field, value, operator) ->
            if typeof operator is 'undefined'
                operator = '='

            @sql['WHERE'] = field + ' ' + operator + ' \'' + value + '\''

            @

        andWhere: (field, value, operator) ->
            if typeof operator is 'undefined'
                operator = '='

            if typeof @sql['AND WHERE'] is 'undefined'
                @sql['AND WHERE'] = []

            @sql['AND WHERE'].push(field + ' ' + operator + ' \'' + value + '\'')

            @

        orWhere: (field, value, operator) ->
            if typeof operator is 'undefined'
                operator = '='

            if typeof @sql['OR WHERE'] is 'undefined'
                @sql['OR WHERE'] = []

            @sql['OR WHERE'].push(field + ' ' + operator + ' \'' + value + '\'')

            @

        from: (param) ->
            @sql['FROM'] = param

            @

        exec: ->
            @req = ''

            for order in @order_command
                switch order
                    when 'SELECT' then @_select()
                    when 'FROM' then @_from()
                    when 'WHERE' then @_where()
                    when 'INSERT' then @_insert()
                    when 'UPDATE' then @_update()

            @req += ';'

            return

        _select: ->
            if typeof @sql['SELECT'] is 'undefined'
                return

            @req = ''
            @req = 'SELECT ' + @sql['SELECT'].join ', '
            return

        _from: ->
            if typeof @sql['FROM'] is 'undefined'
                return

            @req += ' FROM `' + @sql['FROM'] + '`'
            return

        _where: ->
            if typeof @sql['WHERE'] is 'undefined'
                return

            @req += ' WHERE ' + @sql['WHERE']
            return

        _insert: ->
            if typeof @sql['INSERT'] is 'undefined'
                return

            insert = @sql['INSERT']

            fields = insert['PARAMS']['COLS'].join ', '

            for val, i in insert['PARAMS']['VALUES']
                insert['PARAMS']['VALUES'][i] = "'" + val + "'"

            values = insert['PARAMS']['VALUES'].join ', '

            @req += "INSERT INTO `" + insert['TABLE'] + "` (" + fields + ") VALUES (" + values + ")"

            return

        _update: ->
            if typeof @sql['UPDATE'] is 'undefined'
                return

            update = @sql['UPDATE']

            params = update['PARAMS'].join ', '

            @req += "UPDATE `" + update['TABLE'] + "` SET " + params
            return

database.factory '$model', Array '$database', ->
    new class Model
        findAll: ->

        find: ->

        save: ->
