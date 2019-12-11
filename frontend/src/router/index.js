import Vue from 'vue'
import Router from 'vue-router'
import store from '../store'
import Home from '../views/Home.vue'
import Login from '../components/Login.vue'
import Register from '../components/Register.vue'
import EmployeesView from '../components/employees/View.vue'
import EmployeesIndex from '../components/employees/Index.vue'
import Positions from '../components/Positions.vue'
import Position from '../components/Position.vue'

Vue.use(Router)

let router = new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      name: 'home',
      component: Home,
      meta: { 
        requiresAuth: true
      }
    },
    {
      path: '/login',
      name: 'login',
      component: Login
    },
    {
      path: '/register',
      name: 'register',
      component: Register
    },
    {
      path: '/employees',
      name: 'employees',
      component: EmployeesIndex,
      meta: { 
        requiresAuth: true
      }
    },
    {
      path: '/employees/:id',
      name: 'employee_id',
      component: EmployeesView,
      meta: { 
        requiresAuth: true
      }
    },
    {
      path: '/positions',
      name: 'positions',
      component: Positions,
      meta: { 
        requiresAuth: true
      }
    },
    {
      path: '/positions/:id',
      name: 'position_id',
      component: Position,
      meta: { 
        requiresAuth: true
      }
    }
  ]
})

router.beforeEach((to, from, next) => {
  if(to.matched.some(record => record.meta.requiresAuth)) {
    if (store.getters.isLoggedIn) {
      next()
      return
    }
    next('/login') 
  } else {
    next() 
  }
})

export default router