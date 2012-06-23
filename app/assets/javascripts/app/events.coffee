base = require './base'
github = require './github'
_ = require 'underscore'
Hb = require './templates'
moment = require 'moment'

default_images = {
    org: 'https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-orgs.png'
    actor: 'https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-140.png'
}

exports.Event = class Event extends base.BaseModel
    billboardFor: (user) =>
        is_owned = @get('actor')['id'] is user?.get('id')
        org_is_available = @get('org') and @get('org')['id']
        type = if is_owned and org_is_available then 'org' else 'actor'
        _.extend @get(type), {default_image: default_images[type]}

    commitText: -> if @get('payload').size > 1 then "commits" else "commit"

    fromNow: -> moment(@get('created_at')).fromNow()

    issueUrl: => base.airportize @attributes.payload.issue?.html_url


exports.EventList = class EventList extends base.BaseCollection
    model: Event    


exports.CurrentEventList = class CurrentEventList extends EventList
    constructor: (@bus) ->
        super
        @bus.on 'show:user', => @startLoading()
        @bus.on 'loaded:user', (user) => @load github.events(user).done (events) => @reset events
        @bus.on 'show:repo', (repo) => @load github.events(repo.owner, repo.name).done (events) => @reset events

exports.CurrentActivityList = class CurrentActivityList extends EventList
    constructor: (@bus) ->
        super
        @bus.on 'show:user', => @startLoading()
        @bus.on 'loaded:user', (user) => @load github.activities(user).done (activities) => @reset(activities)
        @bus.on 'loaded:organization', (org) => @load github.activities(org).done (activities) => @reset(activities)
                

exports.EventView = class EventView extends base.BaseView
    constructor: (@event, @user) ->
        super {}

    _render: =>        
        data = {         
            billboard: @event.billboardFor(@user)
            actor: @event.get('actor')
            repo: @event.get('repo')    
            org: @event.get('org')   
            payload: @event.get('payload')  
            commitText: @event.commitText()
            timeAgo: @event.fromNow()              
            issueUrl: => @event.issueUrl()
                
        }
        data.copy = Hb.event[@event.get('type')].render(data, {'event.repo.url': Hb.event.repo.url._t})
        @setElement Hb.event.render(data)
        

exports.EventListView = class EventListView extends base.BaseView
    constructor: (@eventList, @user) ->        
        super {}
        @setElement(Hb.event.list.render({}))
        @eventList.on 'reset', =>            
            @$el.empty()            
            @eventList.forEach (event) =>   
                if Hb.event[event.get('type')]              
                    @$el.append(new EventView(event, @user).render().el)
                else 
                    base.log 'Not showing event:', event.get('type'), event.attributes            
        @holdFor @eventList
        @showEmptyMessage @eventList, "No activity here."
