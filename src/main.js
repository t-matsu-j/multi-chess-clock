// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import vio from 'vue-socket.io'

Vue.use(vio, 'http://192.168.10.11:8080')

Vue.config.productionTip = false

/* eslint-disable no-new */
new Vue({
  sockets:{
    connect: () => {
      console.log('socketio connected!')
    }
  },
  el: '#app',
  template: '<App/>',
  components: { App }
})
