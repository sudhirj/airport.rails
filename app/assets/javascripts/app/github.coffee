_ = require 'underscore'
auth = require './auth'

GITHUB_API_ENPOINT = "https://api.github.com"

jsonRequest = (opts) ->
    opts.type ?= 'GET'
    opts.dataType ?= 'json'
    opts.headers ?= {}
    opts.headers['Accept'] ?= 'application/vnd.github.full+json, application/json'
    $.ajax opts

githubRequest = (opts) ->
    if auth.isLoggedIn()
        opts.data ?= {}
        opts.data.access_token = auth.getToken()
    opts.url = "#{GITHUB_API_ENPOINT}#{opts.url}"
    jsonRequest opts

exports.user = (user) -> githubRequest {url: "/users/#{user}"}
exports.repo = (user, repo) -> githubRequest {url: "/repos/#{user}/#{repo}"}
exports.issue = (user, repo, number) -> githubRequest {url: "/repos/#{user}/#{repo}/issues/#{number}"}
exports.issueComments = (user, repo, number) -> githubRequest {url: "/repos/#{user}/#{repo}/issues/#{number}/comments"}
exports.issueEvents = (user, repo, number) -> githubRequest {url: "/repos/#{user}/#{repo}/issues/#{number}/events"}
exports.repos = (user) -> githubRequest {url: (if auth.isCurrentUser(user) then "/user/repos" else "/users/#{user}/repos"), data: {sort: 'updated', direction: 'desc'}}
exports.activities = (user) -> githubRequest {url: "/users/#{user}/events"}
userEvents = (user, repo) -> githubRequest {url: "/users/#{user}/received_events"}
repoEvents = (user, repo) -> githubRequest {url: "/repos/#{user}/#{repo}/events"}
exports.events = (user, repo) -> (if not repo then userEvents else repoEvents)(user, repo)
exports.members = (org) -> githubRequest {url: "/orgs/#{org}/members"}
exports.issues = (user, repo) -> githubRequest {url: "/repos/#{user}/#{repo}/issues"}
    