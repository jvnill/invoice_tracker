class @CommonFunctions
  @addError: (id, msg) ->
    $(id).parent().append("<p class='inline-error'><span class='icon-error'></span>#{msg}</p>")

  @clearFormErrors: ->
    $('p.inline-error').remove()

  @init: ->
    $('.dp').datepicker()

$ -> CommonFunctions.init()
