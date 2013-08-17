define([], () ->
  class Config
    constructor: () ->
      #DEFAULTS
      @flip = -1
      @scale = 10
      @fs = @flip*@scale
)