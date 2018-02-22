socketio = require 'socket.io'

## require all with require.context for webpack dependency
events = require.context './socketio-events/', false, /\.coffee$/

## share redisClient in server
rc = require('redis').createClient()

console.log "events.keys: #{events.keys()}"
debugger

io = (server) ->
  io = socketio(server)

  io.use (socket, next) ->
    socket['db'] = rc
    next()
    return

  io.on 'connect', (socket) ->
    for key in events.keys()
      console.log "key: #{key}"
      events(key)(socket)
    return

  return

module.exports = io
