class SIT.Invoice
  constructor : ->
    @initBindings()
    @defaultScripts()

  initBindings : ->
    $('.new-invoice-item-link').on 'click', (event) ->
      event.preventDefault()

      idx = Math.max.apply(Math, $('.invoice-item-container input').map(-> parseInt(this.name.slice(34)))) + 1
      $('#invoice_invoice_items').append "<div class='row invoice-item-container'><div class='small-12 medium-6 column name'><input type='text' placeholder='Item name' name='invoice[invoice_items_attributes][#{idx}][name]'></div><div class='small-4 medium-2 column quantity'><input type='text' placeholder='Qty' name='invoice[invoice_items_attributes][#{idx}][quantity]'></div><div class='small-8 medium-4 column amt'><input type='text' placeholder='Unit Amt' name='invoice[invoice_items_attributes][#{idx}][unit_amount]'></input></div></div>"

      $('#invoice_no_quantity').trigger('change')

    $('#invoice_invoice_items').on 'click', '.fi-x', (event) ->
      event.preventDefault()

      container = $(this).parent()

      if container.next().attr('type') == 'hidden'
        container.hide()
        container.append("<input type='hidden' value='1' name='invoice[invoice_items_attributes][#{parseInt(container.next().attr('name').slice(34))}][_destroy]'></input>")

      else
        container.remove()

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

  defaultScripts : ->
    $('#invoice_no_quantity').trigger('change')
