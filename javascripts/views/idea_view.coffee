$ ->
  window.IdeaView = Backbone.View.extend
    tagName: "li"

    events:
      "click .hot": "resetHotness"

    className: "idea"

    template: _.template $("#idea-template").html()

    render: ->
      $(this.el).html(this.template(this.model.toJSON()))
      this

    updateHotness: ->
      $(".hotness", this.el).text(this.model.get("hotness"))

    resetHotness: ->
      this.model.resetHotness()

    initialize: ->
      this.model.bind "change", this.updateHotness, this

