$ ->
  window.AppView = Backbone.View.extend
    el: $("#burning_ideas")

    allIdeaViews: []

    initialized: false

    events:
      "submit #new_idea": "create_idea"

    input: $("#new_idea_description")

    create_idea: (e) ->
      description = this.input.val()
      Ideas.create({description: description}) if description
      this.input.val("")
      e.preventDefault()
      false

    addAll: ->
      if not this.initialized
        Ideas.each this.addOne
        this.initialized = true

    addOne: (idea) ->
      view = new IdeaView
      view.setModel idea
      App.allIdeaViews.push view
      idea.bind "change:hotness", (idea, newHotness) =>
        App.reorder idea, newHotness, view
      this.$("#ideas").prepend view.render().el

    reorder: (idea, newHotness, view) ->
      if idea.previous("hotness") < newHotness
        element = $(view.el)
        element.fadeOut "fast", ->
          $("#ideas").prepend(element)
          view.updateHotness()
          element.fadeIn("fast")
          element.effect("highlight")

    initialize: ->
      Ideas.bind "reset", this.addAll, this
      Ideas.bind "add", this.addOne, this

      Ideas.fetch()

  window.App = new AppView

