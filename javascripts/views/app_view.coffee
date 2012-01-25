$ ->
  window.AppView = Backbone.View.extend
    el: $("#burning_ideas")

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
      Ideas.each this.addOne

    addOne: (idea) ->
      view = new IdeaView {model: idea}
      idea.bind "change:hotness", (idea, newHotness) =>
        App.reorder idea, newHotness, view
      this.$("#ideas").prepend view.render().el

    reorder: (idea, newHotness, view) ->
      if idea.previous("hotness") < newHotness
        element = $(view.el).remove()
        $("#ideas").prepend(element)

    initialize: ->
      console.log "Initializing app view"

      Ideas.bind "reset", this.addAll, this
      Ideas.bind "add", this.addOne, this

      Ideas.fetch()

  window.App = new AppView

