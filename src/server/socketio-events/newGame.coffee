eventName = 'newGame'
hashkey = "mcc-room"

module.exports = (socket) ->
  ## redisClient
  redisClient = socket.db

  console.log "#{eventName}:
    redisClient.connection_id: #{redisClient.connection_id}"

  socket.on eventName, () ->
    console.log "#{eventName} called!"
    #socketID を取得してキーに設定
    id = socket.id
    room =
      id: "room-" + id
      players:[]

    socket.join room.id

    player =
      id: "player-" + id
      name: ""
      timer: 0

    room.players.push player
    redisClient.hset(hashkey, room.id, JSON.stringify room, socket.emit(eventName, room))
