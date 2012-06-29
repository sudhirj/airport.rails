_ = require 'underscore'
auth = require './auth'

GITHUB_API_ENPOINT = "https://api.github.com"

request = (opts) ->
    opts.type ?= 'GET'
    opts.dataType ?= 'json'
    opts.headers ?= {}
    opts.data ?= {}

    if auth.isLoggedIn()    
        opts.data.access_token = auth.getToken()
    
    opts.url = "#{GITHUB_API_ENPOINT}#{opts.url}"
    opts.headers['Accept'] ?= 'application/vnd.github.full+json, application/json'
    $.ajax opts

exports.user = (user) -> request {url: "/users/#{user}"}
exports.repo = (user, repo) -> request {url: "/repos/#{user}/#{repo}"}
exports.issue = (user, repo, number) -> request {url: "/repos/#{user}/#{repo}/issues/#{number}"}
exports.issueComments = (user, repo, number) -> request {url: "/repos/#{user}/#{repo}/issues/#{number}/comments"}
exports.issueEvents = (user, repo, number) -> request {url: "/repos/#{user}/#{repo}/issues/#{number}/events"}
exports.repos = (user) -> request {url: (if auth.isCurrentUser(user) then "/user/repos" else "/users/#{user}/repos"), data: {sort: 'updated', direction: 'desc'}}
exports.activities = (user) -> request {url: "/users/#{user}/events"}
userEvents = (user, repo) -> request {url: "/users/#{user}/received_events"}
repoEvents = (user, repo) -> request {url: "/repos/#{user}/#{repo}/events"}
exports.events = (user, repo) -> (if not repo then userEvents else repoEvents)(user, repo)
exports.members = (org) -> request {url: "/orgs/#{org}/members"}
exports.issues = (user, repo) -> request {url: "/repos/#{user}/#{repo}/issues"}
    