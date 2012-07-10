class OMG.Views.TodoFormView extends OMG.Views.BaseView

  el: '#todo_form'
  template: JST['todos/_form']

  events:
    'click .save': 'save'
    'click .cancel': 'cancel'

  initialize: ->
    @$('#todo_body').focus()
    @render()

  render: =>
    $(@el).html(@template())

  save: (e)=>
    e?.preventDefault()
    model = new OMG.Models.Todo(body: @$('#todo_body').val())
    model.save {},
      success: =>
        @collection.add(model)
        Flash.message("notice", "Your todo has been saved.")
        @cancel()
      error: (model, response)=> 
        @_handleErrors(JSON.parse(response.responseText), @el)

  cancel: (e)=>
    e?.preventDefault()
    @_clearErrors()
    @el.reset()
