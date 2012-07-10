#= require spec_helper

describe "OMG.Views.TodosListView", ->
  
  beforeEach ->
    page.html("<ul id='todos'></ul>")
    @collection = new OMG.Collections.Todos()
    @view = new OMG.Views.TodosListView(collection: @collection)
    MockServer.respond()
  
  it "fetches the collection", ->
    @collection.should.have.length(2)

  it "renders the todos from the collection", ->
    el = $(@view.el).html()
    el.should.match(/Do something!/)
    el.should.match(/Do something else!/)

  it "renders new todos added to the collection", ->
    @collection.add(new OMG.Models.Todo(body: "Do another thing!"))
    el = $(@view.el).html()
    el.should.match(/Do another thing!/)
  