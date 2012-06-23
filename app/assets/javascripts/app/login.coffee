base = require './base'
Hb = require './templates'

exports.LoginView = class LoginView extends base.BaseView
    constructor: () -> 
        super
        @setElement Hb.login.credentials.render()
    
exports.LoginInfoView = class LoginInfoView extends base.BaseView
    constructor: () ->
        super
        @setElement Hb.login.info.render()