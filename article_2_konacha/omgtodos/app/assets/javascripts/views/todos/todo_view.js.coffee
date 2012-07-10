class OMG.Views.TodoView extends OMG.Views.BaseView

  tagName: 'li'
  template: JST['todos/_todo']

  events: 
    'change [name=completed]': 'completedChecked'
    'click .delete': 'deleteClicked'

  initialize: ->
    @model.on "change", @render
    @render()

  render: =>
    $(@el).html(@template(todo: @model))
    if @model.get("completed") is true
      @$(".todo-body").addClass("completed")
      @$("[name=completed]").attr("checked", true)
    return @

  completedChecked: (e) =>
    @model.save(completed: $(e.target).attr("checked")?)

  deleteClicked: (e) =>
    e?.preventDefault()
    if confirm("Are you sure?")
      @model.destroy()
      $(@el).remove()