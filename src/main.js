import Vue from 'vue'
import './plugins/axios'
import App from './App.vue'
import router from './router'
import store from './store'
import ElementUI from 'element-ui' //element-ui的全部组件
import 'element-ui/lib/theme-chalk/index.css'//element-ui的css

Vue.use(ElementUI) //使用elementUI
Vue.config.productionTip = false

var axios = require('axios')
axios.defaults.baseURL = 'http://localhost:8899/api'
axios.defaults.withCredentials = true

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
