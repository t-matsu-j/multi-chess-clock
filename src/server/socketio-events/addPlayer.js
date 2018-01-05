module.exports = function(socket){
  var evename = 'addPlayer'
  console.log(evename)
  socket.on(evename, function(val){
    console.log('addPlayer called! val: '+val)
    socket.emit(evename, val)
  })
}
