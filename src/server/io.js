var socketio = require('socket.io')
var events = require('./socketio-events')
console.log(events)
var io = function (server){
  socketio(server).on('connect', function(socket){
    Object.keys(events).forEach(function(func){
      console.log(func);
      events[func](socket)
    })
  })
}

module.exports = io
