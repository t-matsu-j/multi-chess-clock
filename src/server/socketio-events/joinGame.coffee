eventName = 'joinGame'
hashkey = "mcc-room"

module.exports = (socket) ->
  ## redisClient
  redisClient = socket.db

  console.log "#{eventName}: redisClient.connection_id:
     #{redisClient.connection_id}"

  socket.on eventName, (value) ->
    console.log "#{eventName} called! value: #{value}"

    room_id = value
    socket.join room_id, ->
      redisClient.watch room_id
      redisClient.hget hashkey, room_id, (err, data)->
        room = JSON.parse data
        room.players.push
          id: "player-" + socket.id
          name: ""
          time: 0

        multi = redisClient.multi()
        multi.hset hashkey, room_id, JSON.stringify room
        multi.exec()

        socket.to(room.id).emit eventName, room
        socket.emit eventName, room
