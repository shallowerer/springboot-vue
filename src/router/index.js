import Vue from 'vue'
import VueRouter from 'vue-router'
import Home from '../views/Home'
import AppIndex from '../components/home/AppIndex'
import Login from '@/components/Login'
import Register from '@/components/Register'
import User from '../views/User'


// import Container from '../components/admin/Container'
// import Header from '../components/common/Header'
Vue.use(VueRouter)


export default new VueRouter({
  mode: 'history',
  routes: [

    {
      // home作为其他组件父组件，本身不会被访问（访问也会被重定向）
      path: '/',
      name: 'Default',
      redirect:'/home',
      component: Home
    },
    {
      path: '/login',
      name: 'Login',
      component: Login
    },
    {
      path: '/register',
      name: 'Register',
      component: Register
    },
    {
      path: '/home',
      name: 'Home',
      redirect:'/index',
      component: Home,
      children: [
        {
          path: '/index',
          name: 'AppIndex',
          component: AppIndex,
        },
        
        {
          path: '/shopindex',
          name: 'ShopIndex',
          component: () => import( '../components/shop/ShopIndex.vue')
        },
        {
          path: '/commodityindex',
          name: 'CommodityIndex',
          component: () => import( '../components/commodity/CommodityIndex.vue')
        },
        // {
        //   path: '/shopcart',
        //   name: 'Shopcart',
        //   component: Shopcart
        // },
        // {
        //   path: '/bought',
        //   name: 'Bought',
        //   component: Bought
        // },
        // {
        //   path: '/admin',
        //   name: 'AppIndex',
        //   component: AppIndex
        // },
      ]
    },
    {
      path: '/user',
      name: 'User',
      component: User
    },
    {
      path: '/about',
      name: 'About',
      // route level code-splitting
      // this generates a separate chunk (about.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import(/* webpackChunkName: "about" */ '../views/About.vue')
    },
    {
      path: '/admin',
      name: 'Admin',
      component: () => import( '../components/admin/AdminIndex.vue'),
      meta: {
        requireAuth: true
      },
      children: [
        {
          path: '/admin/dashboard',
          name: 'dashboard',
          component: () => import( '../components/admin/dashboard/admin/index.vue'),
          meta: {
            requireAuth: true
          }
        }
      ]
    }
  ] 
})
  

// const router = new VueRouter({
//   mode: 'history',
//   base: process.env.BASE_URL,
//   routes
// })

// export default router
export const createRouter = routes => new Router({
  mode: 'history',
  routes: [
    {
      // home作为其他组件父组件，本身不会被访问（访问也会被重定向）
      path: '/',
      name: 'Default',
      redirect:'/home',
      component: Home
    },
    {
      path: '/login',
      name: 'Login',
      component: Login
    },
    {
      path: '/register',
      name: 'Register',
      component: Register
    },
    {
      path: '/home',
      name: 'Home',
      redirect:'/index',
      component: Home,
      children: [
        {
          path: '/index',
          name: 'AppIndex',
          component: AppIndex,

        },
        
        {
          path: '/shopindex',
          name: 'ShopIndex',
          component: () => import( '../components/shop/ShopIndex.vue')
        },
        {
          path: '/commodityindex',
          name: 'CommodityIndex',
          component: () => import( '../components/commodity/CommodityIndex.vue')
        },
        // {
        //   path: '/shopcart',
        //   name: 'Shopcart',
        //   component: Shopcart
        // },
        // {
        //   path: '/bought',
        //   name: 'Bought',
        //   component: Bought
        // },
        // {
        //   path: '/admin',
        //   name: 'AppIndex',
        //   component: AppIndex
        // },
      ]
    },
    {
      path: '/user',
      name: 'User',
      component: User
    },
    {
      path: '/about',
      name: 'About',
      // route level code-splitting
      // this generates a separate chunk (about.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import(/* webpackChunkName: "about" */ '../views/About.vue')
    },
    {
      path: '/admin',
      name: 'Admin',
      component: () => import( '../components/admin/AdminIndex.vue'),
      meta: {
        requireAuth: true
      },
      children: [
        {
          path: '/admin/dashboard',
          name: 'dashboard',
          component: () => import( '../components/admin/dashboard/admin/index.vue'),
          meta: {
            requireAuth: true
          }
        }
      ]
    }
  ]
})