<template lang="pug">
#room-list
  ul
    li(v-for="room in rooms", @click='selected') {{room}}
  button#joinGame(@click="joinGame") ゲームに参加
</template>

<script lang="coffee">
export default {
  name: "RoomList"

  data: ->
    rooms: {}
    gameID: ""

  methods:
    selected: (e)->
      console.log e
      srcEl = e.target
      parent = srcEl.parentElement
      # removeClass 'selected'
      for child in parent.childNodes
        child.classList.remove 'selected'

      # addClass 'selected'
      srcEl.classList.add 'selected'
      @gameID = srcEl.innerHTML

    joinGame: ->
      if @gameID
        @$socket.emit('joinGame', @gameID)

  sockets:
    roomList: (rooms) ->
      console.log rooms
      @rooms = rooms

    joinGame: (room) ->
      console.log room
      @$emit 'input', room.players

  mounted: ->
    @$socket.emit 'roomList'
}
</script>
<style lang="stylus" scoped>
#room-list
  background-color: inherit;

.selected
  background-color: #cccccc
</style>
