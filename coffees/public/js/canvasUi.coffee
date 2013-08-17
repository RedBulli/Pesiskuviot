define([], () ->
  class CanvasUi
    constructor: (@config, @canvas) ->
      @p_x = 10000
      @p_y = 10000
      @canvas.on('vmousedown', @mousedown)
      @canvas.on('vmouseup', @mouseup)
      @canvas.on('vmousemove', @mousemove)
    initialize: (@players) ->
      @player = null
    setSize: (@sizeFactor) ->
    mousedown: (event) =>
      @player = @players.getPlayer(@getRelativeMousePoint(event))
    mouseup: (event) =>
      if @player
        @player = null
        #@getRelativeMousePoint(event)
    mousemove: (event) =>
      if @player
        @player.setPosition(@getRelativeMousePoint(event))
    getRelativeMousePoint: (event) ->
      canvasOffset = @canvas.offset()
      x = (event.pageX - canvasOffset.left) / @config.scale
      y = (event.pageY - canvasOffset.top) / @config.scale
      #Palauta eri kohta jos on kaannetty kentta
      return {x:x, y:y}
)
