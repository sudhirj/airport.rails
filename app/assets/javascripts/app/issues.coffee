github = require './github'
base = require './base'
Hb = require './templates'
_ = require 'underscore'
moment = require 'moment'

exports.Issue = class Issue extends base.BaseModel
    timeAgo: ->  moment(@.attributes.created_at).fromNow()

class IssueComment extends base.BaseModel
    timeAgo: ->  moment(@.attributes.created_at).fromNow()

class IssueEvent extends base.BaseModel
    timeAgo: ->  moment(@.attributes.created_at).fromNow()
    shortCommit: -> if @.attributes.commit_id then @.attributes.commit_id.substring(0,5) else ''


exports.CurrentIssue = class CurrentIssue extends Issue
    constructor: (@bus) ->
        super

        @bus.on 'show:issue', (issue) => 
            @load github.issue(issue.owner, issue.name, issue.number).done @clearAndSet

exports.CurrentIssueComments = class CurrentIssueComments extends base.BaseCollection
    model: IssueComment

    constructor: (@bus) ->
        super {}
        @bus.on 'show:issue', (issue) =>
            @load github.issueComments(issue.owner, issue.name, issue.number).done (data) => @reset data

exports.CurrentIssueEvents = class CurrentIssueEvents extends base.BaseCollection
    model: IssueEvent

    constructor: (@bus) ->
        super {}
        @bus.on 'show:issue', (issue) =>
            @load github.issueEvents(issue.owner, issue.name, issue.number).done (data) => @reset data


exports.CurrentRepoIssueList = class CurrentRepoIssueList extends base.BaseCollection
    model: Issue

    constructor: (@bus) ->
        super {}
        @bus.on 'show:repo', (repo) =>
            @load github.issues(repo.owner, repo.name).done (data) => @reset data


class IssueView extends base.BaseView
    constructor: (@issue) -> super
    _render: => @setElement Hb.issue.render _.extend({
            timeOpened: @issue.timeAgo()
            airportUrl: @issue.airportUrl()
        }, @issue.attributes)
    
class CommentView extends base.BaseView
    constructor: (@comment) -> super
    _render: => @setElement Hb.issues.comment.render _.extend({
            timeOpened: @comment.timeAgo()        
        }, @comment.attributes)

class EventView extends base.BaseView
    constructor: (@event) -> super

    _render: =>         
        copy = Hb.issues.events[@event.attributes.event].render _.extend({
            shortCommit: @event.shortCommit()            
        }, @event.attributes)
        @setElement Hb.issues.event.render _.extend({
            timeOpened: @event.timeAgo()        
            copy: copy
        }, @event.attributes)


exports.IssueInfoView = class IssueInfoView extends base.BaseView
    constructor: (@issue) -> 
        super

        @issue.on 'change', =>
            @$el.empty()
            @$el.append Hb.issue.info.render _.extend({
                timeOpened: @issue.timeAgo()
                airportUrl: @issue.airportUrl()
            }, @issue.attributes) if not _.isEmpty @issue.attributes

        @holdFor @issue

exports.IssueSummaryView = class IssueSummaryView extends base.BaseView
    constructor: (@issue) -> 
        super

        @issue.on 'change', =>
            @$el.empty()
            @$el.append Hb.issue.summary.render _.extend({
                timeOpened: @issue.timeAgo()
                airportUrl: @issue.airportUrl()
            }, @issue.attributes) if not _.isEmpty @issue.attributes

        @holdFor @issue

exports.IssueCommentsView = class IssueCommentsView extends base.BaseView
    constructor: (@comments) ->
        super {}
        @setElement Hb.issues.comments.render {}
        @holdFor @comments
        @comments.on 'reset', =>
            @$el.empty()
            @comments.forEach (comment) =>
                @$el.append new CommentView(comment).render().el
        @showEmptyMessage @comments, "No comment?"

exports.IssueEventsView = class IssueEventsView extends base.BaseView
    # Wanted to call this events, but it clashes with Backbone's `events` variable
    constructor: (@issueEvents) ->
        super {}
        @setElement Hb.issues.events.render {}
        @holdFor @issueEvents
        @issueEvents.on 'reset', =>
            @$el.empty()
            @issueEvents.forEach (event) =>
                @$el.append new EventView(event).render().el
               

exports.IssueListView = class IssueListView extends base.BaseView
    constructor: (@issueList) ->
        super {}
        @setElement Hb.issues.render({})
        @holdFor @issueList
        @issueList.on 'reset', =>            
            @$el.empty()
            @issueList.forEach (issue) =>
                @$el.append new IssueView(issue).render().el
        @showEmptyMessage @issueList, "No issues?"
