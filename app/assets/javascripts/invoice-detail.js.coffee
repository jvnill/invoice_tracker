class SIT.InvoiceDetail
  constructor : ->
    @initBindings()
    @defaultScripts()

  defaultScripts : ->
    $('.pricing-table .status').on 'hover', ->
      wrapper = $(this).find('.bullet-item')

      unless wrapper.find('select').length
        wrapper.html(HandlebarsTemplates['invoices/status']())

  initBindings : ->
    $('.pricing-table.status .bullet-item')
      .css('cursor', 'pointer')
      .on 'click', ->
        $.ajax
          url: "#{window.location.pathname}/cycle_status"
          type: 'PATCH'
          dataType: 'json'
          success: (json) -> $('.pricing-table.status .bullet-item').text(json.status)

