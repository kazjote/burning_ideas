$ ->
  window.Idea = Backbone.Model.extend
    defaults: -> {
      hotness: 100.0
      lastUpdate: (new Date).getTime() }

    updateHotness: ->
      currentTime = (new Date).getTime()
      timeDiff = currentTime - this.get("lastUpdate")
      newHotness = this.get("hotness") - timeDiff / (1000.0 * 1)
      newHotness = 0 if newHotness < 0
      if newHotness != this.get("hotness")
        this.save
          hotness: newHotness
          lastUpdate: currentTime

    resetHotness: ->
      this.save
        hotness: 100.0
        lastUpdate: (new Date).getTime()

  window.IdeaList = Backbone.Collection.extend
    model: Idea

    localStorage: new Store("burning_ideas")

    updateHotness: ->
      this.each (idea) -> idea.updateHotness()

    comparator: (idea) ->
      idea.get "hotness"

    initialize: ->
      ideas = this
      setInterval ( -> ideas.updateHotness()), 2000

  window.Ideas = new IdeaList

