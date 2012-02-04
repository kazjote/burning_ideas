$ ->
  window.Idea = Backbone.Model.extend
    defaults: -> {
      hotness: 100.0 }

    resetHotness: ->
      this.save
        hotness: 100.0

  window.IdeaList = Backbone.Collection.extend
    model: Idea

    url: "/ideas"

    comparator: (idea) ->
      idea.get "hotness"

    refresh: ->
      ideas = this
      $.get "/ideas", (data) ->
        ideasData = eval data
        newIdeas = []
        while ideaData = ideasData.pop()
          idea = ideas.get ideaData.id
          if idea
            idea.set ideaData
          else
            newIdeas.push ideaData

        _.each newIdeas, (newIdea) ->
          ideas.add newIdea

