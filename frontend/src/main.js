import Vue from 'vue'
import App from './App.vue'
import Axios from 'axios'
import VueCurrencyInput from 'vue-currency-input'

import router from './router'
import store from './store'

Vue.prototype.$http = Axios;
const token = localStorage.getItem('token')
if (token) {
  Vue.prototype.$http.defaults.headers.common['Authorization'] = token
}

Vue.config.productionTip = false

const pluginOptions = {
  globalOptions: { currency: 'BRL' }
}

Vue.use(VueCurrencyInput, pluginOptions)

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app');