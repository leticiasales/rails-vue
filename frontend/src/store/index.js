import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'
import router from '@/router'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    status: '',
    token: localStorage.getItem('token') || '',
    user : {}
  },
  mutations: {
    request(state){
      state.status = 'loading'
    },
    auth_success(state, token, user){
      state.status = 'success'
      state.token = token
      state.user = user
    },
    logout(state){
      state.status = ''
      state.token = ''
    },
    success(state, id){
      state.status = 'success'
    },
    error(state){
      state.status = 'error'
    }
  },
  actions: {
    login({commit}, user){
      return new Promise((resolve, reject) => {
        commit('request')
        axios({
          url: 'http://localhost:3000/auth/login', data: user, method: 'POST'
        }).then(resp => {
          const token = resp.data.token
          const user = resp.data.user
          localStorage.setItem('token', token)
          axios.defaults.headers.common['Authorization'] = token
          commit('auth_success', token, user)
          resolve(resp)
        }).catch(err => {
          commit('error', err)
          localStorage.removeItem('token')
          reject(err)
        })
      })
    },
    register({commit}, user){
      return new Promise((resolve, reject) => {
        commit('request')
        axios({url: 'http://localhost:3000/register', data: user, method: 'POST' })
        .then(resp => {
          const token = resp.data.token
          const user = resp.data.user
          localStorage.setItem('token', token)
          axios.defaults.headers.common['Authorization'] = token
          commit('auth_success', token, user)
          resolve(resp)
        })
        .catch(err => {
          commit('error', err)
          localStorage.removeItem('token')
          reject(err)
        })
      })
    },
    logout({commit}){
      return new Promise((resolve, reject) => {
        commit('logout')
        localStorage.removeItem('token')
        delete axios.defaults.headers.common['Authorization']
        resolve()
      })
    },
    get_employees({commit}){
      commit('request')
      return new Promise((resolve, reject) => {
      axios({url: 'http://localhost:3000/employees', method: 'GET' })
      .then(resp => {
        commit('success')
        const employees = resp.data
        resolve(resp)
      })
      .catch(err => {
          commit('error', err)
          reject(err)
        })
      })
    },
    get_employee_by_id({commit}, id){
      commit('request')
      return new Promise((resolve, reject) => {
      axios({url: 'http://localhost:3000/employees/' + id, method: 'GET' })
      .then(resp => {
        commit('success')
        resolve(resp)
      })
      .catch(err => {
        commit('error', err)
        reject(err)
        })
      })
    },
    new_employee({commit}, employee){
      commit('request')
      return new Promise((resolve, reject) => {
        commit('request')
        axios({
          url: 'http://localhost:3000/employees', data: employee, method: 'POST'
        }).then(resp => {
          commit('success')
          resolve(resp)
        }).catch(err => {
          commit('error', err)
          reject(err)
        })
      })
    },
    get_positions({commit}){
      commit('request')
      return new Promise((resolve, reject) => {
      axios({url: 'http://localhost:3000/positions', method: 'GET' })
      .then(resp => {
        commit('success')
        const employees = resp.data
        resolve(resp)
      })
      .catch(err => {
          commit('error', err)
          reject(err)
        })
      })
    },
    get_position_by_id({commit}, id){
      commit('request')
      return new Promise((resolve, reject) => {
      axios({url: 'http://localhost:3000/positions/' + id, method: 'GET' })
      .then(resp => {
        commit('success')
        const position = resp.data.position
        resolve(resp)
      })
      .catch(err => {
          commit('error', err)
          reject(err)
        })
      })
    }
  },
  getters : {
    isLoggedIn: state => !!state.token,
    authStatus: state => state.status,
  }
})