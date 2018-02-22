<template lang="pug">
#game
  ClockInput(v-model="inputTime")
  //- button#addPlayer(@click="addPlayer") プレイヤーを追加
  button#newGame(@click="newGame") 新規ゲームを開始
  //- GameIDInput(v-model="gameID")
  #room-list-wrapper
    RoomList(v-model="players")
  #player-wrapper
    Player(v-for="player in players", :key="player.id", :playerID="player.id", :setTime="inputTime")
</template>
<script lang="coffee">
import Player from './Player'
import ClockInput from './ClockInput'
import GameIDInput from './GameIDInput'
import RoomList from './RoomList'
# TODO:20 # 新規作成ボタンを作成
# ### createNewGameRoom:
#   - [ ] socketioでルーム作成して自身をプレイヤーとして追加
#   - [ ] サーバサイドの設計も必要
# TODO:60 # ゲームに参加ボタンを作成
# ### joinGame:
#   - [ ] すでにあるゲームに参加する
#   - [ ] プライベートなゲームにはid指定で参加
#   - [ ] パブリックなゲームには一覧から選択して参加
# TODO:50 # プレイヤー追加ボタンを作成
# ### addPlayer:
#   - サーバーに emit("addPlayerEvent")を送信
#   - サーバーの on("addPlayerEvent")でプレイヤー追加してemit("addPlayerEvent")
#   - アプリの on("addPlayerEvent")でplayersリストを更新
export default {
  props: [
    'GM'
  ]

  name: 'Game'

  # created: ->
  #   @addPlayer()
  #   @addPlayer()

  data: ->
    incrementalID: 0
    inputTime: 0
    players: []

  methods:
    addPlayer: ->
      @players.push
        id: @incrementalID
      @$socket.emit('addPlayer', @incrementalID)
      @incrementalID++
      return

    newGame: ->
      @$socket.emit('newGame')

  components: {
    ClockInput
    Player
    GameIDInput
    RoomList
  }
  sockets:
    addPlayer: (id)->
      console.log 'NEW PLAYER! id: ' + id
    newGame: (room) ->
      console.log room
      @players = room.players
}
</script>
<style lang="stylus" scoped>
#game
  background-color:inherit

#player-wrapper
  position: relative;
  height:200px;
  overflow: hidden;
  width:100%;
</style>
