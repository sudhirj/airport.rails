Backbone = require 'backbone'

exports.AirportRouter = class AirportRouter extends Backbone.Router
    constructor: (@bus) ->
        @route /\/?/, 'home'
        @route /([\w\-\_\.]+)\/?/, 'user'
        @route /([\w\-\_\.]+)\/([\w\-\_\.]+)\/?/, 'repo'
        @route /([\w\-\_\.]+)\/([\w\-\_\.]+)\/issues\/(\d+)\/?/, 'issue'
        
    user: (user) =>   
        @navigate "/#{user}", {replace: true}     
        @bus.trigger 'show:user', user

    repo: (user, repo) =>
        @navigate "/#{user}/#{repo}", {replace: true}
        @bus.trigger 'show:repo', {owner:user, name:repo}

    issue: (user, repo, num) =>
        @navigate "/#{user}/#{repo}/issues/#{num}", {replace: true}
        @bus.trigger 'show:issue', {owner:user, name:repo, number: num}

    home: =>
        @navigate "/", {replace: true}
        @bus.trigger 'show:home'


