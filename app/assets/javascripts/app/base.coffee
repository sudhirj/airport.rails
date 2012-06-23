Hb = require './templates'
_ = require 'underscore'
Backbone = require 'backbone'
deferred = require 'simply-deferred'

exports.log = log = -> console.log.apply console, arguments
exports.airportize = airportize = (url) -> if url and url.trim() then url.replace('https://github.com', '') else ''

exports.BaseCollection = class BaseCollection extends Backbone.Collection
    constructor: ->
        super {}
        @_resetLoader()                

    _resetLoader: -> @_loader = deferred.Deferred()

    load: (promise) ->
        @reset()
        @startLoading()
        promise.always => 
            @trigger 'load:finished'
            @_loader.resolve()
        promise.done (data) => if _.isEmpty(data) then @trigger 'data:empty'
        promise.fail => @trigger 'data:unavailable'    

    startLoading: -> 
        @reset()
        @trigger 'load:started'

    loader: -> @_loader.promise()

exports.BaseModel = class BaseModel extends Backbone.Model
    constructor: (data) ->
        super data
        @_resetLoader()                
        if data then @_loader.resolve() else @on 'change', => @_loader.resolve()
        
    _resetLoader: -> @_loader = deferred.Deferred()
                
    loader: -> @_loader.promise()

    clearAndSet: (data) =>
        @clear()
        @set data

    startLoading: ->
        @clear()
        @_resetLoader()
        @trigger 'load:started'

    finishLoading: ->
        @_loader.resolve()
        @trigger 'load:finished'

    load: (promise) ->     
        @clear()   
        @startLoading()
        promise.done => @finishLoading()

    airportUrl: -> airportize @get('html_url')


exports.BaseView = class BaseView extends Backbone.View
    constructor: ->
        super {}
        @rendering = deferred.Deferred()
        @spinner = new Spinner(
            lines: 40
            length: 25
            width: 3
            radius: 50
            rotate: 10 * Math.random()
            color: '#ccc'
            opacity: 0.05
            speed: 2
            trail: 50            
            top: '-50%'
            left: '-50%'
        )

    _render: ->        

    render: ->
        @_render()
        @rendering.resolve()
        @

    showSpinner: => @spinner.spin(@el)

    holdFor: (model) ->
        model.on 'load:started', => @showSpinner()
        model.on 'reset', => @spinner.stop()
        model.on 'change', => @spinner.stop()
        model.on 'load:finished', => @spinner.stop()

    showEmptyMessage: (model, message) ->
        model.on 'data:empty data:unavailable', => @$el.empty().append Hb.empty.render message: message        

exports.Bus = class Bus        
    promises = {}
    ensure = (promise) -> 
        if not _.has(promises, promise) 
            promises[promise] = new deferred.Deferred() 
        else promises[promise]
    constructor: () -> @bus = _.clone(Backbone.Events)
    on: (event, handler) -> @bus.on(event, handler)

    trigger: (event, args...) ->
        log 'trigger', arguments
        @bus.trigger event, args...

    done: (promise, handler) ->
        (ensure promise).done handler        

    resolve: (promise, args...) ->
        (ensure promise).resolve args...


exports.AirportView = class AirportView extends BaseView            
    constructor: (@headerView, @contentView) ->
        super
        @setElement('<div></div>')
        
    _render: ->         
        @$el.append @headerView.render().el         
        @$el.append @contentView.render().el    

exports.Authentication = class Authentication extends BaseModel
    constructor: (@bus) ->
        super
        @deferred = deferred.Deferred()
        @deferred.promise @

    load: -> @deferred.resolve()
        