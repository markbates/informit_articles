class OMG.Models.Todo extends Backbone.Model

  urlRoot: '/todos'

  upCaseBody: ->
    @get("body")?.toUpperCase()
