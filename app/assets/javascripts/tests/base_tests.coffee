assert = require 'assert'
base = require '../app/base'
deferred = require 'simply-deferred'

describe 'URL Airportizer', ->
    it 'should make aiport URLs out of Github HTML URLs', ->
        matches = 
            'https://github.com/sudhirj/metroman/issues/1': '/sudhirj/metroman/issues/1'
            'https://github.com/sudhirj/schock': '/sudhirj/schock'                    

        for ghUrl, airportUrl of matches            
            assert.equal airportUrl, base.airportize(ghUrl)

        assert.equal '', base.airportize null
        assert.equal '', base.airportize undefined
        assert.equal '', base.airportize '  '

describe 'BaseModel', ->
    it 'should provide a loading promise based on external loads', ->
        externalLoader = new deferred.Deferred()
        model = new base.BaseModel        
        model.load externalLoader        
        assert.equal "pending", model.loader().state()

        externalLoader.resolve()
        assert.equal "resolved", model.loader().state()

    it 'should provide a loading promise on creation', ->        
        model = new base.BaseModel()
        assert.equal "pending", model.loader().state()
        model.set {'login': 'something'}
        assert.equal "resolved", model.loader().state()

    it 'should show pre-filled models as resolved', ->
        model = new base.BaseModel({name: 'sudhir', age: 42})
        assert.equal "resolved", model.loader().state()        

    it 'should provide a matching airport URL for all Github URLs', ->
        urls = [
            'https://github.com/sudhirj/metroman/issues/1'
            'https://github.com/sudhirj/schock'
        ]
        for ghUrl in urls
            model = new base.BaseModel {html_url : ghUrl}
            assert.equal base.airportize(ghUrl), model.airportUrl()

describe 'BaseCollection', ->
    it 'should provide a loader', ->        
        externalLoader = new deferred.Deferred()
        collection = new base.BaseCollection()

        collection.load externalLoader
        assert.equal 'pending', collection.loader().state()
        externalLoader.resolve()
        assert.equal 'resolved', collection.loader().state()

    it 'should provide a way to trigger a laoding indicator', ->
        eventChecker = new deferred.Deferred()
        collection = new base.BaseCollection()
        collection.on 'load:started', -> eventChecker.resolve()
        assert.equal 'pending', eventChecker.state()
        collection.startLoading()
        assert.equal 'resolved', eventChecker.state()







