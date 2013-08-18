requirejs.config({
  paths: {
    'jquery': '/js/lib/jquery/jquery',
    'underscore': '/js/lib/underscore-amd/underscore',
    'backbone': '/js/lib/backbone-amd/backbone',
    #TODO bowerin kautta mieluusti
    'jquerymobilecustom': '/jquerymobilecustom',
  }
})
requirejs(['jquery', 'jquerymobilecustom', './js/models.js', './js/views.js', './js/field.js', './js/canvasUi.js', './js/config.js'],
  ($, jquerymobilecustom, Models, Views, Field, CanvasUi, Config) ->
    socketio = io.connect(window.location.origin)
    window.socketio = socketio
    players = null
    socketio.on('players', (players) ->
      players = new Models.Players(players)
      $.ready(
        config = new Config()
        document.getElementById('kentta').height = config.height
        document.getElementById('kentta').width = config.width
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
