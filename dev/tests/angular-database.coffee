'use strict'

describe 'ngDatabase', ->
    $database = null

    beforeEach ->
        module 'ngDatabase'
        return

    beforeEach ->
        inject ($injector) ->
            $database = $injector.get '$database'
            return
        return

    it "Should have sql propertie", ->
        expect(typeof $database.sql).toBe 'object'
        return

    it "Should have adapter propertie", ->
        expect(typeof $database.adapter).toBe 'object'
        return

    it "Should have set dababase adapter function", ->
        expect(typeof $database.setAdapter).toBe 'function'
        return

    it "Should be sql propertie", ->
        expect(typeof $database.req).toBe 'object'
        expect($database.req).toEqual null
        return

    it "Should be create table method", ->
        expect(typeof $database.createTable).toBe 'function'
        return

    it "Should be select method", ->
        expect(typeof $database.select).toBe 'function'
        return

    it "Should be insert method", ->
        expect(typeof $database.insert).toBe 'function'
        return

    it "Should be update method", ->
        expect(typeof $database.update).toBe 'function'
        return

    it "Should be where method", ->
        expect(typeof $database.where).toBe 'function'
        return

    it "Should be andWhere method", ->
        expect(typeof $database.andWhere).toBe 'function'
        return

    it "Should be orWhere method", ->
        expect(typeof $database.orWhere).toBe 'function'
        return

    it "Should be from method", ->
        expect(typeof $database.from).toBe 'function'
        return

    it "Should be exec method", ->
        expect(typeof $database.exec).toBe 'function'
        return

    it "Should generate an sql request object to create table", ->
        db = $database.createTable 'table', [
            'col1',
            'col2'
        ]

        expect($database.sql).toEqual {
            'CREATE': {
                'TABLE': 'table',
                'COLS': [
                    'col1',
                    'col2'
                ]
            }
        }
        return

    it "Should create a valid sql request to create a table", ->
        $database.createTable('table', ['col1', 'col2']).exec()

        expect($database.req).toEqual 'CREATE TABLE IF NOT EXISTS `table` (col1, col2);'
        return

    it "Should be equal a select object", ->
        db = $database.select()

        expect($database.sql).toEqual {
            'SELECT': [
                '*'
            ]
        }

        expect(typeof db).toBe 'object'
        return

    it "Should be equal a select object with parameters", ->
        db = $database.select([
            'id',
            'field'
        ])

        expect($database.sql).toEqual {
            'SELECT': [
                'id',
                'field'
            ]
        }

        expect(typeof db).toBe 'object'
        return

    it "Should be equal a from object", ->
        db = $database.from('table')

        expect($database.sql).toEqual {
            'FROM': 'table'
        }

        expect(typeof db).toBe 'object'
        return

    it 'Shoud be equal a where object', ->
        db = $database.where('field', 'value')

        expect($database.sql).toEqual {
            'WHERE': "field = 'value'"
        }

        expect(typeof db).toBe 'object'
        return

    it 'Shoud be equal a andWhere object', ->
        db = $database.andWhere('field', 'value')

        expect($database.sql).toEqual {
            'AND WHERE': ["field = 'value'"]
        }

        expect(typeof db).toBe 'object'
        return

    it 'Shoud be equal a andWhere object with many params', ->
        db = $database.andWhere('field', 'value').andWhere('field2', 'value2', '!=')

        expect($database.sql).toEqual {
            'AND WHERE': [
                "field = 'value'",
                "field2 != 'value2'"
            ]
        }

        expect(typeof db).toBe 'object'
        return

    it 'Shoud be equal a orWhere object', ->
        db = $database.orWhere('field', 'value')

        expect($database.sql).toEqual {
            'OR WHERE': ["field = 'value'"]
        }

        expect(typeof db).toBe 'object'
        return

    it 'Shoud be equal a orWhere object with many params', ->
        db = $database.orWhere('field', 'value').orWhere('field2', 'value2', '!=')

        expect($database.sql).toEqual {
            'OR WHERE': [
                "field = 'value'",
                "field2 != 'value2'"
            ]
        }

        expect(typeof db).toBe 'object'
        return

    it 'Shoud be equal a where object with all paramters', ->
        db = $database.where('field', 'value', '!=')

        expect($database.sql).toEqual {
            'WHERE': "field != 'value'"
        }

        expect(typeof db).toBe 'object'
        return

    it 'Should be equal a valid select sql request object', ->
        $database.select().from('table').where('field', 'value')

        expect($database.sql).toEqual {
            'SELECT': ['*'],
            'FROM': 'table',
            'WHERE': 'field = \'value\''
        }
        return

    it 'Should be equal a insert sql request object', ->
        db = $database.insert('table', ['field1', 'field2'], ['value1', 'value2'])

        expect($database.sql).toEqual {
            'INSERT': {
                'TABLE': 'table',
                'PARAMS':{
                    'COLS': ['field1', 'field2'],
                    'VALUES': ['value1', 'value2']
                }
            }
        }

        expect(typeof db).toBe 'object'
        return

    it 'Should be equal a update sql request object', ->
        db =  $database.update('table', [{'field1':'value1'}, {'field2':'value2'}])

        expect($database.sql).toEqual {
            'UPDATE': {
                'TABLE': 'table',
                'PARAMS': [
                    "field1 = 'value1'",
                    "field2 = 'value2'"
                ]
            }
        }

        expect(typeof db).toBe 'object'
        return

    it 'Should make valide select request', ->
        $database.select().from('table').where('field', 'value').exec()

        expect($database.req).toEqual "SELECT * FROM `table` WHERE field = 'value';"
        return

    it 'Should make valide insert request', ->
        $database.insert('table', ['field1', 'field2'], ['value1', 'value2']).exec()

        expect($database.req).toEqual "INSERT INTO `table` (field1, field2) VALUES ('value1', 'value2');"
        return

    it 'Should make valide update request', ->
        $database.update('table', [{'field1':'value1'}, {'field2':'value2'}]).exec()

        expect($database.req).toEqual "UPDATE `table` SET field1 = 'value1', field2 = 'value2';"
        return

    it "Should try select sql with adapter", ->
        $database.setAdapter new SQLAdapter()

        $database.createTable('test', ['col1', 'col2']).exec()

        $database.insert('test', ['col1', 'col1'], ['value1', 'value2']).exec()

        result = $database.select().from('test').exec()

        expect(typeof result[0]).toBe 'object'
        return
    return
