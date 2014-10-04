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

    it "Should have sql propertie", ->
        expect(typeof $database.sql).toBe 'object'
        expect($database.sql).toEqual null
        return

    it "Should have create table method", ->
        expect(typeof $database.createTable).toBe 'function'
        return

    it "Should have select method", ->
        expect(typeof $database.select).toBe 'function'
        return

    it "Should have insert method", ->
        expect(typeof $database.insert).toBe 'function'
        return

    it "Should have update method", ->
        expect(typeof $database.update).toBe 'function'
        return

    it "Should have where method", ->
        expect(typeof $database.where).toBe 'function'
        return
    return
