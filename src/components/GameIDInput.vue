<template lang="pug">
#game-id-input
  input(:value="value" @input="formatID($event.target.value)")
</template>
<script lang="coffee">
export default {
  props: [
    'value'
  ]
  name: "GameIDInput",
  data: ->
    {}
  methods:
    formatID: (strID) ->
      @$emit('input', strID)
}
</script>
<style lang="stylus" scoped>
#game-id-input
  background-color:inherit;
</style>
