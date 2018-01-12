socketio = require 'socket.io'
events = require './socketio-events'
import redis from 'redis'
client = redis.createClient()

console.log events
io = (server) ->
  socketio(server).on 'connect', (socket) ->
    for own key of events
      console.log(key)
      events[key](socket, client)

module.exports = io
