class OMG.Views.TodosListView extends OMG.Views.BaseView

  el: "#todos"

  initialize: ->
    @collection.on "reset", @render
    @collection.on "add", @renderTodo
    @collection.fetch()

  render: =>
    $(@el).html("")
    @collection.forEach (todo) =>
      @renderTodo(todo)

  renderTodo: (todo) =>
    view = new OMG.Views.TodoView(model: todo, collection: @collection)
    $(@el).prepend(view.el)