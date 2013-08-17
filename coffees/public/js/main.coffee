requirejs.config({
  paths: {
    'jquery': '/js/lib/jquery/jquery',
    'underscore': '/js/lib/underscore-amd/underscore',
    'backbone': '/js/lib/backbone-amd/backbone',
    #TODO bowerin kautta mieluusti
    'jquerymobile': '/jquerymobile' 
  }
})
requirejs(['jquery', 'jquerymobile', './js/models.js', './js/views.js', './js/field.js', './js/canvasUi.js', './js/config.js'],
  ($, jquerymobile, Models, Views, Field, CanvasUi, Config) ->
    config = new Config()
    $(document).on('mobileinit', () ->
      $.mobile.linkBindingEnabled = false
      $.mobile.hashListeningEnabled = false
    )
    socketio = io.connect(window.location.origin)
    window.socketio = socketio
    players = null
    socketio.on('players', (players) ->
      players = new Models.Players(players)
      $.ready(
        field = new Field(config, document.getElementById('kentta'))
        field.drawField()
        ui = new CanvasUi(config, $('#kentta'))
        ui.initialize(players)
        playersView = new Views.PlayersView({collection: players, el: '#kentta', config: config})
        playersView.render()
        socketio.on('object', (model) =>
          player = players.findWhere({position: model.position})
          player.set(model)
          playersView.render()
        )
      )
    )
    
)
