class SIT.Invoices
  constructor : ->
    @initBindings()

  initBindings : ->
    $('#filter_status').on 'change', ->
      $.ajax
        data: { filter: { status: @value } }
        dataType: 'script'
