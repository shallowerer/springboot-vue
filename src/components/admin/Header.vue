<template>
  <el-card class="admin-header">
    <a href="/index">
      <img src="../../assets/mylogo/logo/nvwa.png" alt="" width="55px" style="float: left;margin-top: -5px;">
    </a>
    <span style="font-size: 32px;font-weight: bold;position:absolute;left: 100px">后台管理</span>
    <i class="el-icon-switch-button" v-on:click="logout" style="font-size: 40px;float: right"></i>
  </el-card>
</template>

<script>
  import {createRouter} from '../../router/index'

  export default {
    name: 'Header',
    methods: {
      logout () {
        var _this = this
        this.$axios.get('/logout').then(resp => {
          if (resp.data.code === 200) {
            _this.$store.commit('logout')
            _this.$router.replace('/index')
            // console.log('退出成功');
            
            // // 清空路由，防止路由重复加载
            let newRouter = createRouter()
            console.log('退出成功');
            _this.$router.matcher = newRouter.matcher
          }
        }).catch(failResponse => {
          console.log('退出错误');
        })
      }
    }
  }
</script>

<style scoped>
  .admin-header {
    height: 80px;
    opacity: 1;
    line-height: 40px;
    min-width: 900px;
  }
  .el-icon-switch-button {
    cursor: pointer;
    outline:0;
  }
</style>
