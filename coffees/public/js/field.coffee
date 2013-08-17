define([], () ->
  class Field
    #1 pikseli = 10cm oikeassa maailmassa
    setGlobals: () ->
      if @config.flip == 1
        @counterClockwise = false
      else
        @counterClockwise = true
      @brush = 1
      @baseRadius = 3 * @config.scale
      @homeBaseInnerCircle = 5 * @config.scale
      @homeBaseOuterCircle = 7 * @config.scale
    constructor: (@config, @canvas) ->
      @context = @canvas.getContext('2d')
      @color = 'black'
      @setGlobals()
      @setPoints()
    setPoints: () ->
      @cp = {x: @canvas.width / 2, y: @canvas.height-@config.scale*8}
      if @config.flip == 1
        @cp.y = @config.scale*8
      @config.fs = @config.flip*@config.scale
      @kenttaalku = {x1: @cp.x-@config.fs*1.1, x2: @cp.x+@config.fs*1.1, y: @cp.y}
      @kakkoskulma = {x: @cp.x-@config.fs*21, y: @cp.y+@config.fs*32}
      @kolmoskulma = {x: @cp.x+@config.fs*21, y: @cp.y+@config.fs*32}
      @jatke = @config.fs*60.5
      @ykkospesa = {x: @cp.x+@config.fs*(12.4-0.8), y: @cp.y + @config.fs * 16.9}
      @kakkospesa = {x: @cp.x-@config.fs*21, y: @cp.y + @config.fs * (32+3.5+3)}
      @kolmospesa = {x: @kakkospesa.x+@config.fs*42, y: @kakkospesa.y}
    flip: () ->
      @config.flip *= -1
      @setPoints()
    drawFirstBase: () ->
      @context.beginPath()
      if @config.flip == -1
        @context.arc(@ykkospesa.x, @ykkospesa.y, @baseRadius, 5.7, 4.15, @counterClockwise)
      else
        @context.arc(@ykkospesa.x, @ykkospesa.y, @baseRadius, 1, 2.58, @counterClockwise)
      @context.stroke()
    drawSecondBase: () ->
      @context.fillStyle = 'white'
      @context.beginPath()
      @context.arc(@kakkospesa.x, @kakkospesa.y, @baseRadius, Math.PI*1.5, Math.PI*0.5, @counterClockwise)
      @context.stroke()
      @context.fill()
    drawThirdBase: () ->
      @context.beginPath()
      @context.arc(@kolmospesa.x, @kolmospesa.y, @baseRadius, Math.PI*0.5, Math.PI*1.5, @counterClockwise)
      @context.stroke()
      @context.fill()
      @context.restore()
    drawPitchingPlate: () ->
      @context.fillStyle = 'black'
      @context.beginPath()
      @context.arc(@cp.x, @cp.y-@config.fs*1.3, @config.scale*0.3, 0, Math.PI*2, @counterClockwise)
      @context.stroke()
      @context.fill()
      @context.restore()
    drawOuterLines: () ->
      @context.beginPath()
      @context.moveTo(@kenttaalku.x1, @cp.y)
      @context.lineTo(@kakkoskulma.x, @kakkoskulma.y)
      @context.lineTo(@kakkoskulma.x, @kakkoskulma.y+@jatke)
      @context.lineTo(@kolmoskulma.x, @kolmoskulma.y+@jatke)
      @context.lineTo(@kolmoskulma.x, @kolmoskulma.y)
      @context.lineTo(@kenttaalku.x2, @cp.y)
      @context.stroke()
    drawRunningLines: () ->
      @context.beginPath()
      @context.moveTo(@ykkospesa.x, @ykkospesa.y)
      @context.lineTo(@kakkospesa.x, @kakkospesa.y)
      @context.lineTo(@kolmospesa.x, @kolmospesa.y)
      @context.stroke()
    drawHomeBase: () ->
      #Straight line
      @context.moveTo(@cp.x+@config.fs*7, @cp.y)
      @context.lineTo(@cp.x-@config.fs*7, @cp.y)
      @context.stroke()
      #Inner circle
      @context.beginPath()
      @context.arc(@cp.x, @cp.y, @homeBaseInnerCircle, Math.PI, 0, @counterClockwise)
      @context.stroke()
      #Outer circle
      @context.beginPath()
      @context.arc(@cp.x, @cp.y, @homeBaseOuterCircle, Math.PI, 0, @counterClockwise)
      @context.stroke()
    drawField: () ->
      @context.strokeStyle = @color
      @context.lineWidth = @brush
      @context.save()

      @drawFirstBase()
      @drawSecondBase()
      @drawThirdBase()
      @drawPitchingPlate()
      @drawOuterLines()
      @drawRunningLines()
      @drawHomeBase()
      
      base64 = @canvas.toDataURL()
      @canvas.style.backgroundImage = 'url('+base64+')'
)