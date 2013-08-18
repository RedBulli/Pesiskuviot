define(['jquery'], ($) ->
  class Config
    constructor: () ->
      #DEFAULTS
      @height = $(window).height() #1030
      @height = @height - 30
      @width = @height / 2
      @flip = -1
      @scale = @height * 10 / 1030
      @fs = @flip*@scale
      @clickMove = true
)