class @CommonFunctions
  @addError: (id, msg) ->
    $(id).parent().append("<p class='inline-error'><span class='icon-error'></span>#{msg}</p>")

  @clearFormErrors: ->
    $('p.inline-error').remove()

  @init: ->
    $('.dp').datepicker
      dateFormat: 'dd MM yy'

    $('#invoice_no_quantity').trigger('change')

$ -> CommonFunctions.init()

$(document).on 'click', '.new-project-dialog', (event) ->
  event.preventDefault()

  $('#project-dialog').dialog
    autoOpen: false
    width: 500
    title: 'Create a new project'

  $.ajax
    url: '/projects/new'
    type: 'GET'
    dataType: 'script'
    complete: ->
      $('#project-dialog')
        .dialog('open')
        .find('h3').remove().end()
        .find('form').append('<input type="hidden" value="1" name="dialog"></input>')

$(document).on 'click', '.new-client-dialog', (event) ->
  event.preventDefault()

  $('#client-dialog').dialog
    autoOpen: false
    width: 500
    title: 'Create a new client'

  $.ajax
    url: '/clients/new'
    type: 'GET'
    dataType: 'script'
    complete: ->
      $('#client-dialog')
        .dialog('open')
        .find('h3').remove().end()
        .find('form').append('<input type="hidden" value="1" name="dialog"></input>')

$(document).on 'click', '.new-invoice-item-link', (event) ->
  event.preventDefault()

  idx = Math.max.apply(Math, $('.invoice-item-container input').map(-> parseInt(this.name.slice(34)))) + 1
  $('#invoice_invoice_items').parent().append "<div class='invoice-item-container'><div class='name'><input type='text' placeholder='Item name' name='invoice[invoice_items_attributes][#{idx}][name]' class='simple no-error'></div><div class='quantity'><input type='text' placeholder='Qty' name='invoice[invoice_items_attributes][#{idx}][quantity]' class='simple no-error'></div><div class='amt'><input type='text' placeholder='Unit Amt' name='invoice[invoice_items_attributes][#{idx}][unit_amount]' class='simple no-error'></div><div class='icon-error icon-only delete-invoice-item' title='Delete Invoice item'></div><div class='clearfix'></div></div>"

  $('#invoice_no_quantity').trigger('change')

$(document).on 'click', '.delete-invoice-item', (event) ->
  event.preventDefault()

  container = $(this).parent()

  if container.next().attr('type') == 'hidden'
    container.hide()
    container.append("<input type='hidden' value='1' name='invoice[invoice_items_attributes][#{parseInt(container.next().attr('name').slice(34))}][_destroy]'></input>")

  else
    container.remove()

$(document).on 'change', '#invoice_no_quantity', ->
  if $(this).prop('checked')
    $('form .name').addClass('no-qty')
    $('form .quantity').hide()

  else
    $('form .name').removeClass('no-qty')
    $('form .quantity').show()
