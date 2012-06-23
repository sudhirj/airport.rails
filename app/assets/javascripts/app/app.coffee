require './zepto'
require './spin'

base = require './base'
users = require './users'
repos = require './repo'
events = require './events'
issues = require './issues'
header = require './header'
chat = require './chat'
dashboard = require './dashboard'
routes = require './routes'
Backbone = require 'backbone'
hogan = require 'hogan.js'
github = require './github'
login = require './login'
deferred = require 'simply-deferred'
_s = require 'underscore.string'

deferred.installInto($)
Backbone.setDomLibrary($)

bus = new base.Bus
currentUser = new users.CurrentUser bus    
currentRepo = new repos.CurrentRepo bus
currentIssue = new issues.CurrentIssue bus
currentIssueComments = new issues.CurrentIssueComments bus
currentIssueEvents = new issues.CurrentIssueEvents bus
currentRepoList = new repos.CurrentUserRepoList bus
currentActivities = new events.CurrentActivityList bus
currentEvents = new events.CurrentEventList bus
currentMembers = new users.CurrentOrgMemberList bus
currentIssues = new issues.CurrentRepoIssueList bus


headerView = new header.HeaderView bus

userInfoView = new users.UserInfoView currentUser
repoInfoView = new repos.RepoInfoView currentRepo
repoListView = new repos.RepoListView currentRepoList

activitiesView = new events.EventListView currentActivities, currentUser
eventsView = new events.EventListView currentEvents, currentUser
membersView = new users.MembersView currentMembers

issueInfoView = new issues.IssueInfoView currentIssue
issueSummaryView = new issues.IssueSummaryView currentIssue
issueCommentsView = new issues.IssueCommentsView currentIssueComments
issueEventsView = new issues.IssueEventsView currentIssueEvents
issueListView = new issues.IssueListView currentIssues

chatView = new chat.ChatView bus    

loginView = new login.LoginView 
loginInfoView = new login.LoginInfoView

metroView = new dashboard.MetroView bus, {        
    userInfo: userInfoView
    repoInfo: repoInfoView
    repoList: repoListView
    activities: activitiesView
    events: eventsView
    members: membersView
    issues: issueListView
    login: loginView
    loginInfo: loginInfoView
    issueInfo: issueInfoView
    issueSummary: issueSummaryView
    issueComments: issueCommentsView
    issueEvents: issueEventsView
    chat: chatView
}

airportView = new base.AirportView(headerView, metroView)
router = new routes.AirportRouter(bus)
Backbone.history.start({pushState: true})

$ -> 
    $('body').append airportView.render().el
    bus.resolve 'global:render'

$(window).on 'click', 'a', (event) -> 
    anchor = $(event.currentTarget)
    link = anchor.attr('href')
    isExternal = _s.startsWith(link, 'http')        
    if not isExternal then router.navigate link, trigger: true    
    return isExternal            


