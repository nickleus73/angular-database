'use strict'

describe 'ngDatabase model', ->
    $model = null

    beforeEach ->
        module 'ngDatabase'
        return

    beforeEach ->
        inject ($injector) ->
            $model = $injector.get '$model'
            return
        return

    it 'Should have findAll method', ->
        expect(typeof $model.findAll).toBe 'function'
        return

    it 'Should have find method', ->
        expect(typeof $model.find).toBe 'function'
        return

    it 'Should have save method', ->
        expect(typeof $model.save).toBe 'function'
        return
    return
