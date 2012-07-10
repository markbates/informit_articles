class OMG.Views.TodosApp extends OMG.Views.BaseView

  el: '#main'

  initialize: ->
    @collection = new OMG.Collections.Todos()
    OMG.collection = @collection
    new OMG.Views.TodosListView(collection: @collection)
    new OMG.Views.TodoFormView(collection: @collection)