<template lang="pug">
#game
  ClockInput(v-model="inputTime")
  button#addPlayer(@click="addPlayer") プレイヤーを追加
  #player-wrapper
    Player(v-for="player in players" :key="player.id" playerID="player.id" :setTime="inputTime")
</template>
<script lang="coffee">
import Player from './Player'
import ClockInput from './ClockInput'
# TODO:0 # 新規作成ボタンを作成
# ### createNewGameRoom:
#   - [ ] socketioでルーム作成して自身をプレイヤーとして追加
#   - [ ] サーバサイドの設計も必要
# TODO:20 # ゲームに参加ボタンを作成
# ### joinGame:
#   - [ ] すでにあるゲームに参加する
#   - [ ] プライベートなゲームにはid指定で参加
#   - [ ] パブリックなゲームには一覧から選択して参加
# TODO:10 # プレイヤー追加ボタンを作成
# ### addPlayer:
#   - サーバーに emit("addPlayerEvent")を送信
#   - サーバーの on("addPlayerEvent")でプレイヤー追加してemit("addPlayerEvent")
#   - アプリの on("addPlayerEvent")でplayersリストを更新
export default {
  props: [
    'gameID'
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
  components: {
    ClockInput
    Player
  }
  sockets:
    addPlayer: (id)->
      console.log 'NEW PLAYER! id: ' + id
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
