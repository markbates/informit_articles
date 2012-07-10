class OMG.Views.BaseView extends Backbone.View

  _clearErrors: =>
    @$(".control-group").removeClass("error")
    @$(".help-inline").remove()

  _handleErrors: (errors, form) =>
    errors = errors['errors'] if errors['errors']?
    for key, messages of errors
      mess = _.flatten([messages])
      el = $("[name=#{key}]", form)
      if el.html()?
        el.closest(".control-group").addClass("error")
        for message in mess
          el.after("<span class='help-inline'>#{message}</span>")
      else
        for message in mess
          Flash.message("alert", "#{key} #{message}")