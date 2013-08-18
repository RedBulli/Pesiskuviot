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
      if not @player
        @player = @lockPlayer(event)
        if @player
          if @config.clickMove
            @player.firstClick = true
      else
        if @config.clickMove
          @movePlayer(event)
    mouseup: (event) =>
      if @player
        if @player.firstClick
          @player.firstClick = false
        else
          @releasePlayer()
    mousemove: (event) =>
      if @player
        @movePlayer(event, true)
    movePlayer: (event, silent) ->
      @player.setPosition(@getRelativeMousePoint(event), silent)
    lockPlayer: (event) ->
      @player = @players.getPlayer(@getRelativeMousePoint(event))
      if @player
        @player.setLock()
    releasePlayer: () ->
      @player.releaseLock()
      @player = null
    getRelativeMousePoint: (event) ->
      canvasOffset = @canvas.offset()
      x = (event.pageX - canvasOffset.left) / @config.scale
      y = (event.pageY - canvasOffset.top) / @config.scale
      #Palauta eri kohta jos on kaannetty kentta
      return {x:x, y:y}
)
