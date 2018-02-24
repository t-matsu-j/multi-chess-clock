<template lang="pug">
#clock
  #display {{ hour }}:{{ minute }}:{{ second }}.{{ milisecond }}
  button#1(@click="toggle") {{ss}}
  button#2(@click="clear") CLEAR
</template>
<script lang="coffee">
export default {
  props: [
    'setTime'
  ]

  name: "Clock"

  data: ->
    ss: "START"
    counting: no
    intervalID: ""
    remainTime: 0
    fromTime: 0

  methods:
    toggle: ->
      console.log 'Toggling'
      if @counting
        @counting = no
        @stop()
        @ss = "START"
      else
        @counting = yes
        @fromTime = Date.now()
        @start()
        @ss = "STOP"
    start: ->
      @intervalID = setInterval () =>
        currentTime = Date.now()
        @remainTime -=( currentTime - @fromTime)
        @fromTime = currentTime
      , 100
      console.log @intervalID
    stop: ->
      clearInterval @intervalID

    clear: ->
      if @counting then @stop()
      @remainTime = @setTime

  watch:
    setTime: ->
      @remainTime = @setTime unless @counting
  computed:
    hour: ->
      num = Math.floor(@remainTime % (24 * 3600000) / 3600000)
      return ('00' + num).slice -2

    minute: ->
      num = Math.floor(@remainTime % 3600000 / 60000)
      return ('00' + num).slice -2

    second: ->
      num = Math.floor(@remainTime % 60000 / 1000)
      return ('00' + num).slice -2

    milisecond: ->
      num = Math.floor(@remainTime % 1000)
      return ('000' + num).slice -3

}
</script>
<style lang="stylus" scoped>
#clock
  background-color:inherit
</style>
