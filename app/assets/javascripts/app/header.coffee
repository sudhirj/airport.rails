base = require './base'
Hb = require './templates'

exports.HeaderPathElementView = class HeaderPathElementView extends base.BaseView    
    constructor: (@text, @anchor) ->
        super        

    _render: =>
        @rendering.done =>
            @setElement(Hb.header.path.element.render(name: @text, anchor: @anchor))
        


exports.HeaderPathView = class HeaderPathView extends base.BaseView    
    constructor: (@bus) ->        
        super
        @elements = [
            new HeaderPathElementView('airport', '/')            
        ]        

        @bus.on 'show:home show:login', (user) => @renderPath()
        @bus.on 'show:user', (user) => @renderPath user
        @bus.on 'show:repo', (repo) => @renderPath repo.owner, repo.name
        @bus.on 'show:issue', (issue) => @renderPath issue.owner, issue.name, 'issues', issue.number

    renderPath: (elements...) =>        
        @rendering.done =>                          
            collector = elements.reduce (collector, element) ->                
                collector.anchor += '/' + element
                collector.views.push(new HeaderPathElementView(element, collector.anchor))                
                collector
            , {views: [], anchor: ''}

            @elements.splice 1, @elements.length, collector.views...                    
            @$el.empty()
            @$el.append element.render().el for element in @elements

    _render: =>        
        @setElement(Hb.header.path.render())        



exports.HeaderView = class HeaderView extends base.BaseView    
    constructor: (@bus) ->        
        super
        @pathView = new HeaderPathView(@bus)

        $.when(@rendering).done =>                        
            # @$el.find('.links').append Hb.header.links.render @auth.attributes



    _render: => 
        @setElement(Hb.header.holder.render())
        @$el.append @pathView.render().el        
