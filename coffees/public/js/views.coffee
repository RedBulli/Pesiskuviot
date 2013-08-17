define(['backbone', './field.js'], (Backbone, Field) ->
  class Views
  class Views.PlayersView extends Backbone.View
    initialize: (options) ->
      _.bindAll(this, 'render');
      @collection.on('add', @render)
      @canvas = @el
      @context = @el.getContext('2d')
      @config = options.config
      @collection.on('change', @render)
    render: () ->
      @clear()
      for player in @collection.models
        @drawPlayer(player)
        
    getRelativePosition: (player) ->
      x = player.get('x') * @config.scale
      y = player.get('y') * @config.scale
      if @config.flip == 1
        x = @canvas.width - x
        y = @canvas.height - y
      return {x: x, y: y}
    clear: () ->
      @context.clearRect(0,0, @canvas.width, @canvas.height)
    drawPlayer: (player) ->
      @context.font = @config.scale + 'pt Calibri';
      @context.fillStyle = 'black';
      disp = @config.scale * 0.4
      if player.get('position') && player.get('position').length > 1
        disp = @config.scale * 0.8
      playerPosition = @getRelativePosition(player)
      @context.fillText(player.get('position'), playerPosition.x - disp, playerPosition.y + @config.scale*0.5)
      @context.beginPath()
      @context.arc(playerPosition.x, playerPosition.y, @config.scale, 0, 2 * Math.PI, false)
      @context.stroke()

  Views
)
