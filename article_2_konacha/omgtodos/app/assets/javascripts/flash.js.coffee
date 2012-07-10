class @Flash

  @message: (name, msg) ->
    $("#flash_#{name}").remove()
    style = "success"
    if name is "alert"
      style = "error"
    $('#flash_messages').append("<div id='flash_#{name}' class='alert alert-#{style}' data-fadeout='7000'>#{msg}<a class='close' data-dismiss='alert' href='#'>&times;</a></div>")
    @setFadeOuts()
    
  @setFadeOuts: ->
    $(".alert").alert()
    $('[data-fadeout]').each ->
      $(this).delay($(this).attr('data-fadeout')).fadeOut()

$ ->
  Flash.setFadeOuts()