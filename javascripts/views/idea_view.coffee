$ ->
  window.IdeaView = Backbone.View.extend
    tagName: "li"

    events:
      "click .hot": "resetHotness"

    className: "idea"

    template: _.template $("#idea-template").html()

    render: ->
      $(this.el).html(this.template(this.model.toJSON()))
      this.updateHotness()
      this

    updateHotness: ->
      hotness = this.model.get("hotness")
      $(".hotness .value", this.el).css {width: hotness + "%"}
      opacity = if hotness < 10
        0.1
      else
        hotness / 100.0
      $(this.el).css {opacity: opacity}

    resetHotness: ->
      this.model.resetHotness()
      this.updateHotness()

    setModel: (model) ->
      this.model = model
      this.model.bind "change", this.updateHotness, this
      this.ideaId = this.model.ideaId

