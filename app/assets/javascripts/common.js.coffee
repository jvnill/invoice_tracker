class @SIT.Common
  constructor : ->
    @initBindings()

  initBindings : ->
    $('.dp').datepicker
      dateFormat: 'dd MM yy'

  @addError : (id, msg) ->
    $(id).parent().addClass('error').after("<small class='error'>#{msg}</small>")

  @clearFormErrors : ->
    $('label.error').removeClass('error')
    $('small.error').remove()

  @bindPaymentDetailSelect : ->
    $('#payment_detail').on 'change', ->
      if @value.length
        $.ajax
          url: "/payment_details/#{@value}"
          type: 'GET'

      else
        $.ajax
          url: '/payment_details/new'
          type: 'GET'
