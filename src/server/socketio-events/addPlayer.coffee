module.exports = (socket) ->
  evename = 'addPlayer'
  console.log evename
  socket.on evename, (val) ->
    console.log 'addPlayer called! val: ' + val
    socket.emit evename, val
