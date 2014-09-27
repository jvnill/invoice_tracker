@SIT = {}

class SITRoute
  # See http://haithembelhaj.github.io/RouterJs/
  constructor : ->
    @router = new Router()

  draw : ->
    @router.route '.*', ->
      new SIT.Common()

    @router.route '/invoices/new', ->
      new SIT.Invoice()

    @router.route '/invoices/:id', ->
      new SIT.InvoiceDetail()

    @router.route '/invoices/:id/edit', ->
      new SIT.Invoice()

    @router.start()

$ ->
  SIT.router = new SITRoute()
  SIT.router.draw()
