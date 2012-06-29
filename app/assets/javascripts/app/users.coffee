base = require './base'
github = require './github'
Hb = require './templates'
_ = require 'underscore'

exports.User = class User extends base.BaseModel

exports.CurrentUser = class CurrentUser extends User
    constructor: (@bus) ->                
        super {}

        triggerUserLoad = (login, type) =>
            # This trigger happens in the show:user event handler loop. Call it after the loop is finished.
            _.defer => @bus.trigger "loaded:#{type.toLowerCase()}", login

        setUser = (user) =>
            @clear()
            @set user
            [@currentUser, @currentType] = [user.login, user.type]            

        loadUser = (user, announce) =>
            if user isnt @currentUser
                @load github.user(user).done (userData) => 
                    setUser userData
                    triggerUserLoad userData.login, userData.type if announce
            else triggerUserLoad @currentUser, @currentType if announce
        
        @bus.on 'show:user', (user) -> loadUser user, true
        @bus.on 'show:repo', (repo) -> loadUser repo.owner, false

exports.UserList = class UserList extends base.BaseCollection
    model: User

exports.CurrentOrgMemberList = class CurrentOrgMemberList extends UserList
    constructor: (@bus) ->
        super {}
        @bus.on 'show:user', => @startLoading()
        @bus.on 'loaded:organization', (org) =>
            @load github.members(org).done (members) =>
                @reset(members)


exports.UserInfoView = class UserInfoView extends base.BaseView
    constructor: (@user) ->
        super        
        @user.on 'change', =>                   
            @$el.empty().append Hb.user.info.render
                name: @user.get('name')
                login: @user.get('login')
                avatar: @user.get('avatar_url')
                html_url: @user.get('html_url')
        
        @holdFor @user
                        
exports.MemberView = class MemberView extends base.BaseView
    constructor: (@user) ->
        super

    _render: =>
        @setElement Hb.member.render @user.attributes            

        
exports.MembersView = class MembersView extends base.BaseView
    constructor: (@members) ->
        super
        @setElement(Hb.members.list.render({}))
        @holdFor @members
        @members.on 'reset', => 
            @$el.empty()
            @members.forEach (member) =>
                @$el.append(new MemberView(member).render().el)

    
        