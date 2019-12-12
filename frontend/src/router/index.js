import Vue from 'vue'
import Router from 'vue-router'
import store from '../store'
import Home from '../views/Home.vue'
import Login from '../components/Login.vue'
import Register from '../components/Register.vue'
import EmployeesIndex from '../components/employees/Index.vue'
import EmployeeShow from '../components/employees/Show.vue'
import EmployeeNew from '../components/employees/New.vue'
import EmployeeEdit from '../components/employees/Edit.vue'
import PositionsIndex from '../components/positions/Index.vue'
import PositionShow from '../components/positions/Show.vue'

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
      path: '/employees/new',
      name: 'employee_new',
      component: EmployeeNew,
      meta: { 
        requiresAuth: true
      }
    },
    {
      path: '/employees/:id',
      name: 'employee_id',
      component: EmployeeShow,
      meta: { 
        requiresAuth: true
      }
    },
    {
      path: '/employees/:id/edit',
      name: 'employee_edit',
      component: EmployeeEdit,
      meta: { 
        requiresAuth: true
      }
    },
    {
      path: '/positions',
      name: 'positions',
      component: PositionsIndex,
      meta: { 
        requiresAuth: true
      }
    },
    {
      path: '/positions/:id',
      name: 'position_id',
      component: PositionShow,
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