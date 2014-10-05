'use strict'

describe 'ngDatabase adapter sql.js', ->
    adapter = null

    beforeEach ->
        module 'ngDatabase'
        adapter = new SQLAdapter()
        return

    beforeEach ->
        inject ($injector) ->
            $database = $injector.get '$database'
            return
        return

    it "Should have db method", ->
        expect(typeof adapter.db).toBe 'object'
        return


    it "Should have openDatabase method", ->
        expect(typeof adapter.openDatabase).toBe 'function'
        return

    it "Should have exec method", ->
        expect(typeof adapter.exec).toBe 'function'
        return

    it "Should have getResult method", ->
        expect(typeof adapter.getResult).toBe 'function'
        return

    it "Should", ->
        adapter.exec("CREATE TABLE  test (col1, col2);")
            .exec ("INSERT INTO test VALUES (1, 2);")
            .prepare ("SELECT * FROM test;")

        console.log adapter.getResult()
        return
