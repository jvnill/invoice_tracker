class SIT.InvoiceDetail
  constructor : ->
    @defaultScripts()

  defaultScripts : ->
    $('.pricing-table .status').on 'hover', ->
      wrapper = $(this).find('.bullet-item')

      unless wrapper.find('select').length
        wrapper.html(HandlebarsTemplates['invoices/status']())
