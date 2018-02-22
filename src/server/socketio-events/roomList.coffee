eventName = 'roomList'
hashkey = "mcc-room"

module.exports = (socket) ->
  ## redisClient
  redisClient = socket.db

  console.log "#{eventName}:
    redisClient.connection_id: #{redisClient.connection_id}"

  socket.on eventName, () ->
    console.log "#{eventName} called!"

    redisClient.hkeys hashkey, (err, replies)->
      console.log "replies: #{replies.length}"
      replies.forEach (reply, i)->
        console.log "#{i}: #{reply}"
      socket.emit eventName, replies
