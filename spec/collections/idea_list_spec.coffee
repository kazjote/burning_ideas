describe "IdeaList", ->
  beforeEach ->
    this.ideas = new IdeaList()

  describe "comparator", ->
    beforeEach ->
      this.ideasArray = [{hotness: 10.0}, {hotness: 100.0}]

    it "should have ascending order by hotness when adding models in correct order", ->
      this.ideas.add this.ideasArray
      firstIdea = this.ideas.at 0
      expect(firstIdea.get("hotness")).toEqual 10.0

    it "should have ascending order by hotness when adding models in reverse order", ->
      this.ideas.add this.ideasArray.reverse()
      firstIdea = this.ideas.at 0
      expect(firstIdea.get("hotness")).toEqual 10.0

  describe "while refreshing", ->
    beforeEach ->
      this.changedIdea = {id: 1, hotness: 100.0, description: "blank"}
      this.newIdea = {id: 2, hotness: 30.0, description: "blank"}
      this.ideas.add {id: 1, hotness: 10.0, description: "blank"}
      this.server = sinon.fakeServer.create()

      this.server.respondWith "GET", "/ideas", [
        200,
        {"Content-Type": "application/json"},
        JSON.stringify([this.changedIdea, this.newIdea])]

      this.ideas.refresh()
      this.server.respond()

    it "should update existing ideas", ->
      idea = this.ideas.get 1
      expect(idea.get("hotness")).toEqual 100.0

    it "should add new ideas", ->
      idea = this.ideas.get 2
      expect(idea.get("hotness")).toEqual 30.0
