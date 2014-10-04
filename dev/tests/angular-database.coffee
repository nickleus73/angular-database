'use strict'

describe 'SelfieTrip', ->
    $database = null

    beforeEach ->
        module 'ngDatabase'
        return

    beforeEach ->
        inject ($injector) ->
            $database = $injector.get '$database'
            return
        return

    it "Should be sql propertie", ->
        expect(typeof $database.sql).toBe 'object'
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

    it "Should be from method", ->
        expect(typeof $database.from).toBe 'function'
        return

    it "Should be exec method", ->
        expect(typeof $database.exec).toBe 'function'
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
    return
