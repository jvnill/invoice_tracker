class @SIT.Common
  @addError: (id, msg) ->
    $(id).parent().addClass('error').after("<small class='error'>#{msg}</small>")

  @clearFormErrors: ->
    $('label.error').removeClass('error')
    $('small.error').remove()

  @init: ->
    $('.dp').datepicker
      dateFormat: 'dd MM yy'

    $('#invoice_no_quantity').trigger('change')
