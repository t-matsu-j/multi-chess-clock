<template lang="pug">
#player
  input(v-model="playerName" placeholder="Input name")
  Clock(:setTime="setTime")
</template>
<script lang="coffee">
import Clock from './Clock'
export default {
  name: "Player"
  props: [
    'playerID'
    'setTime'
  ]
  data: ->
    playerName: ''
  watch:
    setTime: ->
      console.log @setTime
  components: {
    Clock
  }
}
</script>
<style lang="stylus" scoped>
#player
  float: left
  margin:auto 0;
  height: 198px
  width: 300px
  border: 1px solid grey
  border-radius: 20px
  background-color: inherit

  input
    border: none
    width: auto
    text-align: center
</style>
