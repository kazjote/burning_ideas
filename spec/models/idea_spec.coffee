describe "Idea", ->
  it "should have default hotness", ->
    hotness = (new Idea()).get('hotness')
    expect(hotness).toEqual 100.0

  describe "resetHotness", ->
    it "should reset hotness value", ->
      collection = {url: "/ideas"}
      idea = new Idea {hotness: 10.0}
      idea.collection = collection
      idea.resetHotness()
      expect(idea.get("hotness")).toEqual 100.0
