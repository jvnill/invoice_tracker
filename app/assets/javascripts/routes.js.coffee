@SIT = {}

class SITRoute
  # See http://haithembelhaj.github.io/RouterJs/
  constructor : ->
    @router = new Router()

  draw : ->
    @router.route '.*', ->
      new SIT.Common()

    @router.start()

$ ->
  SIT.router = new SITRoute()
  SIT.router.draw()
