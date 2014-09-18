class @SIT.Common
  constructor : ->
    @initBindings()

  initBindings : ->
    $('.dp').datepicker
      dateFormat: 'dd MM yy'

  @addError: (id, msg) ->
    $(id).parent().addClass('error').after("<small class='error'>#{msg}</small>")

  @clearFormErrors: ->
    $('label.error').removeClass('error')
    $('small.error').remove()
