base = require './base'
_ = require 'underscore'
Hb = require './templates'
metroman = require 'metroman'

exports.MetroView = class MetroView extends base.BaseView
    constructor: (@bus, @views) ->
        @setElement Hb.content.holder.render()
        @metroman = new metroman.MetroMan(@$el)
        configs = 
            'show:user': 
                grid: { rows: 7, columns: 5, margin: 1.618 }
                elements: [
                    { view: @views.userInfo.$el, height: 1, width: 1, position: { x: 0, y: 0 } }
                    { view: @views.activities.$el, height: 7, width: 1, position: { x: 1, y: 0 } }                                        
                    { view: @views.repoList.$el, height: 6, width: 1, position: { x: 0, y: 1 } }                    
                ]            

            'loaded:user': 
                grid: { rows: 7, columns: 5, margin: 1.618 }
                elements: [
                    { view: @views.userInfo.$el, height: 1, width: 1, position: { x: 0, y: 0 } }
                    { view: @views.activities.$el, height: 7, width: 1, position: { x: 1, y: 0 } }                    
                    { view: @views.events.$el, height: 7, width: 1, position: { x: 2, y: 0 } }                    
                    { view: @views.repoList.$el, height: 6, width: 1, position: { x: 0, y: 1 } }                    
                ]            

            'loaded:organization': 
                grid: { rows: 7, columns: 5, margin: 1.618}
                elements: [
                    { view: @views.userInfo.$el, height: 1, width: 1, position: { x: 0, y: 0 } }                    
                    { view: @views.activities.$el, height: 7, width: 1, position: { x: 1, y: 0 } }
                    { view: @views.members.$el, height: 7, width: 1, position: { x: 2, y: 0 } }                    
                    { view: @views.repoList.$el, height: 6, width: 1, position: { x: 0, y: 1 } }
                ]

            'show:repo': 
                grid: { rows: 7, columns: 5, margin: 1.618 }
                elements: [
                    { view: @views.userInfo.$el, height: 1, width: 1, position: { x: 0, y: 0 } }
                    { view: @views.repoInfo.$el, height: 2, width: 1, position: { x: 0, y: 1 } }
                    { view: @views.events.$el, height: 7, width: 1, position: {x: 1, y: 0 } }                    
                    { view: @views.repoList.$el, height: 4, width: 1, position: { x: 0, y: 3 } }
                    { view: @views.issues.$el, height: 7, width: 2, position: { x: 2, y: 0} }
                    { view: @views.chat.$el, height: 7, width: 1, position: { x: 4, y: 0} }
                ]
            'show:issue':
                grid: { rows: 7, columns: 7, margin: 1.618 }
                elements: [
                    { view: @views.issueInfo.$el, height: 3, width: 1, position: { x: 0, y: 0 } }                 
                    { view: @views.issueSummary.$el, height: 3, width: 3, position: { x: 1, y: 0 } }
                    { view: @views.issueComments.$el, height: 7, width: 3, position: { x: 4, y: 0 } }
                    { view: @views.issueEvents.$el, height: 4, width: 1, position: { x: 0, y: 3 } }
                    { view: @views.chat.$el, height: 4, width: 2, position: { x: 2, y: 3} }
                ]

            'show:login':
                grid: { rows: 7, columns: 7, margin: 1.618 }
                elements: [
                    { view: @views.loginInfo.$el, height: 5, width: 3, position: { x:1, y: 1 }}
                    { view: @views.login.$el, height: 3, width: 2, position: { x:4, y: 2 }}
                ]

            'show:home':
                grid: { rows: 7, columns: 7, margin: 1.618 }
                elements: [
                    { view: @views.userInfo.$el, height: 5, width: 3, position: { x:1, y: 1 }}
                    
                ]


        _.each _.keys(configs), (key) =>
            @bus.on key, => @bus.done 'global:render', => 
                console.log 'Loading view configuration for', key
                @metroman.load configs[key]

        super

