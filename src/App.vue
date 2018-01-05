<template lang='pug'>
#app
  Game
</template>
<script lang='coffee'>
import HelloWorld from './components/HelloWorld'
import Game from './components/Game'
export default {
  name: 'app',
  components: {
    Game
  }
}
</script>
<style lang='stylus'>
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
