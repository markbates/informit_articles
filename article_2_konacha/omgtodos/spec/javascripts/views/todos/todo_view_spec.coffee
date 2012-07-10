#= require spec_helper

describe "OMG.Views.TodoView", ->
  
  beforeEach ->
    @collection = new OMG.Collections.Todos()
    @model = new OMG.Models.Todo(id: 1, body: "Do something!", completed: false)
    @view = new OMG.Views.TodoView(model: @model, collection: @collection)
    page.html(@view.el)

  describe "model bindings", ->
    
    it "re-renders on change", ->
      $('.todo-body').should.have.text("Do something!")
      @model.set(body: "Do something else!")
      $('.todo-body').should.have.text("Do something else!")

  describe "displaying of todos", ->
    
    it "contains the body of the todo", ->
      $('.todo-body').should.have.text("Do something!")

    it "is not marked as completed", ->
      $('[name=completed]').should.not.be.checked
      $('.todo-body').should.not.have.class("completed")

    describe "completed todos", ->
      
      beforeEach ->
        @model.set(completed: true)

      it "is marked as completed", ->
        $('[name=completed]').should.be.checked
        $('.todo-body').should.have.class("completed")

  describe "checking the completed checkbox", ->
    
    beforeEach ->
      $('[name=completed]').should.not.be.checked
      $('[name=completed]').click()

    it "marks it as completed", ->
      $('[name=completed]').should.be.checked
      $('.todo-body').should.have.class("completed")

  describe "unchecking the completed checkbox", ->

    beforeEach ->
      @model.set(completed: true)
      $('[name=completed]').should.be.checked
      $('[name=completed]').click()
    
    it "marks it as not completed", ->
      $('[name=completed]').should.not.be.checked
      $('.todo-body').should.not.have.class("completed")


  describe "clicking the delete button", ->

    describe "if confirmed", ->

      beforeEach ->
        @confirmStub = sinon.stub(window, "confirm")
        @confirmStub.returns(true)

      afterEach ->
        @confirmStub.restore()
      
      it "will remove the todo from the page", ->
        page.html().should.contain($(@view.el).html())
        $(".delete").click()
        page.html().should.not.contain($(@view.el).html())

    describe "if not confirmed", ->

      beforeEach ->
        @confirmStub = sinon.stub(window, "confirm")
        @confirmStub.returns(false)

      afterEach ->
        @confirmStub.restore()
      
      it "will not remove the todo from the page", ->
        page.html().should.contain($(@view.el).html())
        $(".delete").click()
        page.html().should.contain($(@view.el).html())

