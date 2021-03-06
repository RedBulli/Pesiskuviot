requirejs = require('requirejs')
requirejs.config({
  nodeRequire: require
})

requirejs(['node-static', 'http', 'socket.io', './app.js'], 
  (staticServer, http, io, application) ->
    file = new (staticServer.Server)('./public', {cache: 1})
    httpServer = http.createServer((request, response) ->
      file.serve(request, response).addListener 'error', (err) ->
        file.serveFile './404.html', 404, {}, request, response

      request.addListener 'end', ->
        file.serve request, response

    )
    httpServer.address = '0.0.0.0'
    httpServer.listen 4000

    exports.socketio = io.listen(httpServer)
    application.initialize(exports.socketio)  
)
