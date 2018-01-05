<template lang="pug">
#clock-input
  input(:value="value" @input="formatTime($event.target.value)")
</template>
<script lang="coffee">
export default {
  props: [
    'value'
  ]
  name: "ClockInput",
  data: ->
    {}
  methods:
    formatTime: (strTime)->
      @$emit('input', Number(strTime))
}
</script>
<style lang="stylus" scoped>
#clock-input
  background-color:inherit
</style>
