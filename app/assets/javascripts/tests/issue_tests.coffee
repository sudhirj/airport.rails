issues = require '../app/issues'
assert = require 'assert'
samples = require './json_samples'
moment = require 'moment'

describe 'Issues', ->
    it 'should calcualte the last updated time', ->
        issue =  new issues.Issue samples.json_samples.issue
        assert.equal moment(issue.attributes.updated_at).fromNow(), issue.timeAgo()    