<template lang='pug'>
#app
  component(:is="currentComponent")
</template>
<script lang='coffee'>
import HelloWorld from './components/HelloWorld'
import Game from './components/Game'
export default {
  name: 'app',
  data: ->
    currentComponent: "Game"
  components: {
    Game
  }
}
</script>
<style lang='stylus'>
@import './assets/reset.styl'
body
  background-color: #EEE
#app
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;

</style>
