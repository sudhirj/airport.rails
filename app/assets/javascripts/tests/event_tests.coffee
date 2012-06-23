events = require '../app/events'
users = require '../app/users'
assert = require 'assert'
samples = require './json_samples'
moment = require 'moment'

describe 'Events', ->
    it 'should give the relevant billboard image', ->
        event1 = new events.Event samples.json_samples.event
        user1 = new users.User samples.json_samples.event['actor']

        assert.equal event1.get('org'), event1.billboardFor(user1)

        event2_without_org = new events.Event samples.json_samples.event_without_org
        user2 = new users.User samples.json_samples.event_without_org['actor']

        assert.equal event2_without_org.get('actor'), event2_without_org.billboardFor(user2)

        assert.equal event1.get('actor'), event1.billboardFor(user2)

    it 'should generate the time ago for the creation date', ->
        event = new events.Event samples.json_samples.event
        assert.equal moment(event.get('created_at')).fromNow(), event.fromNow()


