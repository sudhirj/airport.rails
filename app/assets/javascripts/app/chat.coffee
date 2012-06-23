base = require './base'
templates = require './templates'

exports.ChatView = class ChatView extends base.BaseView
    constructor: ->
        super
        @setElement templates.chat.render()