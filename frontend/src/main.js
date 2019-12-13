import Vue from 'vue'
import App from './App.vue'
import Axios from 'axios'
import VueCurrencyInput from 'vue-currency-input'
import VueMaterial from 'vue-material'
import 'vue-material/dist/vue-material.min.css'

import router from './router'
import store from './store'

import "@/assets/style.scss"

Vue.prototype.$http = Axios;
const token = localStorage.getItem('token')
if (token) {
  Vue.prototype.$http.defaults.headers.common['Authorization'] = token
}

Vue.config.productionTip = false

const pluginOptions = {
  globalOptions: { currency: 'BRL' }
}

Vue.filter('toCurrency', function (value) {
    if (typeof value !== "number") {
        return value;
    }
    var formatter = new Intl.NumberFormat('en-US', {
        style: 'currency',
        currency: 'USD',
        minimumFractionDigits: 0
    });
    return formatter.format(value);
});

Vue.use(VueCurrencyInput, pluginOptions)
Vue.use(VueMaterial)

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app');