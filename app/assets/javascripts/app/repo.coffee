base = require './base'
github = require './github'
Hb = require './templates'
_ = require 'underscore'


exports.Repo = class Repo extends base.BaseModel

exports.CurrentRepo = class CurrentRepo extends Repo
    constructor: (@bus) ->
        super 
        
        @bus.on 'show:user', => @startLoading()
        @bus.on 'show:repo', (repo) =>            
            @load github.repo(repo.owner, repo.name).done (data) =>
                @clear()
                @set data

exports.RepoInfoView = class RepoInfoView extends base.BaseView
    constructor: (@repo) ->
        super   
        @holdFor @repo

        @repo.on 'change', =>             
            @$el.empty()
            if not _.isEmpty @repo.attributes
                @$el.append Hb.repo.info.render @repo.attributes

    _render: =>
        @setElement(Hb.repo.info.render({}))
        

exports.CurrentUserRepoList = class CurrentUserRepoList extends base.BaseCollection    
    model: Repo

    constructor: (@bus) ->        
        super

        loadReposForUser = (user) =>
            if user isnt @currentUser
                @load github.repos(user).done (data) =>
                    @reset data
                    @currentUser = user

        @bus.on 'show:user', (user) => loadReposForUser user
        @bus.on 'show:repo', (repo) => loadReposForUser repo.owner
        
            

exports.RepoListItemView = class RepoListItemView extends base.BaseView
    constructor: (@repo) ->
        super 
        @holdFor @repo

    _render: =>                
        @setElement Hb.repo.list.item.render {
            name: @repo.get('name')
            owner: @repo.get('owner').login
        }

exports.RepoListView = class RepoListView extends base.BaseView
    constructor: (@repoList) ->        
        super 
        @holdFor @repoList
        @setElement(Hb.repo.list.render({}))
        @repoList.on 'reset', =>
            @$el.empty()
            @repoList.forEach (repo) =>                 
                @$el.append(new RepoListItemView(repo).render().el).show()
            
            
    
        
        