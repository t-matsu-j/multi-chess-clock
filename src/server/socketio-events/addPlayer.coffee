eventName = 'addPlayer'

module.exports = (socket) ->
  redisClient = socket.db
  console.log "#{eventName}: redis_client.connection_id: #{redisClient.connection_id}"

  socket.on eventName, (value) ->
    key = value.key
    val = value.val
    redisClient.set(key, val, console.log(val))

    socket.emit eventName, val
