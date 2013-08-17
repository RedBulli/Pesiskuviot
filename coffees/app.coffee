define(['./public/js/models.js'], (Models) ->
  players = new Models.Players()
  players.add({x: 38, y: 12, position: '2K'})
  players.add({x: 12, y: 12, position: '3K'})
  players.add({x: 38, y: 42, position: '2P'})
  players.add({x: 12, y: 42, position: '3P'})
  players.add({x: 6, y: 60, position: '3V'})
  players.add({x: 44, y: 60, position: '2V'})
  players.add({x: 24, y: 52, position: '1V'})
  players.add({x: 33, y: 70, position: 'S'})
  connections = 0

  { initialize: (socketio) ->
    socketio.sockets.on('connection', (socket)  ->
      connections++
      socket.emit('players', players)
      socket.set('nickname', connections.toString(), () ->
        socketio.sockets.emit('textModel', {date: new Date(), nickname: null, text: 'New user: ' + connections.toString()})
      )
      socket.on('msg', (text) ->
        socket.get('nickname', (err, name) ->
          textModel = new Models.TextModel({date: new Date(), nickname: name, text: text})
          texts.add(textModel)
          socketio.sockets.emit('textModel', textModel)
        )
      )
      socket.on('object', (model) ->
        player = players.findWhere({position: model.model.position})
        player.set(model.model)
        socketio.sockets.emit('object', player)
      )
    )
  }
)
