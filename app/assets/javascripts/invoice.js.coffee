class SIT.Invoice
  constructor : ->
    @initBindings()
    @defaultScripts()

  initBindings : ->
    $('.new-invoice-item-link').on 'click', (event) ->
      event.preventDefault()

      indexes = $.map($('.invoice-item-container input'), (input) -> parseInt(input.name.slice(34)))
      indexes.push(-1)

      idx = Math.max.apply(Math, indexes) + 1

      $('#invoice_invoice_items').append "<div class='row invoice-item-container'><div class='small-12 medium-6 column name'><input type='text' placeholder='Item name' name='invoice[invoice_items_attributes][#{idx}][name]'></div><div class='small-4 medium-2 column quantity'><input type='text' placeholder='Qty' name='invoice[invoice_items_attributes][#{idx}][quantity]'></div><div class='small-8 medium-4 column amt'><input type='text' placeholder='Unit Amt' name='invoice[invoice_items_attributes][#{idx}][unit_amount]'></input><div><i class='fi-minus-circle'></i></div></div></div>"

      $('#invoice_no_quantity').trigger('change')

    $('#invoice_invoice_items').on 'click', '.fi-minus-circle', (event) ->
      event.preventDefault()

      container = $(this).closest('.invoice-item-container')

      if container.next().attr('type') == 'hidden'
        container
          .hide()
          .addClass('deleted')
          .append("<input type='hidden' value='1' name='invoice[invoice_items_attributes][#{parseInt(container.next().attr('name').slice(34))}][_destroy]'></input>")

      else
        container.remove()

      SIT.Invoice.updateTotal()

    $('#invoice_no_quantity').on 'change', ->
      $('#invoice_invoice_items .name').removeClass('medium-6 medium-8')
      $('#invoice_invoice_items .amt').removeClass('small-12 small-8')

      if $(this).prop('checked')
        $('#invoice_invoice_items .name').addClass('medium-8')
        $('#invoice_invoice_items .amt').addClass('small-12')
        $('form .quantity').hide()

      else
        $('#invoice_invoice_items .name').addClass('medium-6')
        $('#invoice_invoice_items .amt').addClass('small-8')
        $('form .quantity').show()

    $('#invoice_project_id').on 'change', ->
      if @value
        $.ajax
          url: '/invoices/next_invoice_number'
          data: { project_id: @value }
          type: 'GET'
          success: (response) ->
            $('#invoice_number').val(response) if response.length

    $('#invoice_invoice_items').on 'keydown', '.quantity :input, .amt :input', ->
      SIT.Invoice.updateTotal()

  defaultScripts : ->
    $('#invoice_no_quantity').trigger('change')
    SIT.Invoice.updateTotal()

  @updateTotal : ->
    total = 0
    noQuantity = $('#invoice_no_quantity').is(':checked')

    $('#invoice_invoice_items .row:not(".deleted")').each (index, row) ->
      quantity = if noQuantity then 1 else $(row).find('.quantity :input').val()
      amt = $(row).find('.amt :input').val()

      total += quantity * amt if quantity && amt

    $('#total strong').text("Total: #{$('#invoice_currency').val()} #{total.toFixed(2)}")
