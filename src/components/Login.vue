<template>
  <body id="paper">
    <el-form :model="loginForm" :rules="rules" class="login-container" label-position="left"
             label-width="0px" v-loading="loading">
      <h3 class="login_title">门店后台管理系统登录</h3>
      <el-form-item prop="username">
        <el-input type="text" v-model="loginForm.username"
                  auto-complete="off" placeholder="账号"></el-input>
      </el-form-item>
      <el-form-item prop="password">
        <el-input type="password" v-model="loginForm.password"
                  auto-complete="off" placeholder="密码"></el-input>
      </el-form-item>


      <!-- 验证码 -->
      <el-form-item prop="verifyCode" class="verifyCodeItemCss">
        <el-input class="verify_css" placeholder="请输入4位验证码" v-model="loginForm.verifyCode" @keyup.enter.native="login"></el-input>
        <!--关键 ↓-->
        <div id="v_container"></div>
      </el-form-item>



      <el-checkbox class="login_remember" v-model="checked"
                   label-position="left"><span style="color: #505458">记住密码</span></el-checkbox>
      <el-form-item style="width: 100%">
        <el-button type="primary" style="width: 40%;background: #505458;border: none;margin-right:30px" v-on:click="login"  >登录</el-button>
        <router-link to="register"><el-button type="primary" style="width: 40%;background: #505458;border: none">注册</el-button></router-link>
      </el-form-item>
    </el-form>
  </body>
</template>
<script>
  import { GVerify } from '../static/js/verifyCode'
  export default{
    data () {
      return {
        rules: {
          username: [{required: true, message: '用户名不能为空', trigger: 'blur'}],
          password: [{required: true, message: '密码不能为空', trigger: 'blur'}],
          verifyCode: [{ required: true, message: '请输入验证码', trigger: 'blur' }]
        },
        verifyCode: null,
        checked: true,
        loginForm: {
          username: '',
          password: '',
          verifyCode: ''

        },
        loading: false
      }
    },
    mounted () {
      
      this.verifyCode = new GVerify('v_container')
      console.log(this.verifyCode);
    },
    methods: {

      //验证码方法
      validate(){
        var that = this
        // 获取验证码
        var verifyCode = this.loginForm.verifyCode
        console.log(verifyCode);
        
        var verifyFlag = this.verifyCode.validate(verifyCode)
        console.log(verifyFlag);
        
        if (!verifyFlag) {
          that.$notify.error({
          title: '系统提示',
          message: '验证码输入错误'
          })
          return false;
        } else {
          // that.$notify({
          // title: '系统提示',
          // message: '验证码输入正确',
          // type: 'success'
          // })
          return true;
        }
      },


      login () {     
        var _this = this
        if(this.validate()){
            this.$axios.post('/login', {
              username: this.loginForm.username,
              password: this.loginForm.password
            })
            .then(resp => {
              if (resp.data.code === 200) {
                var data = resp.data.data
                _this.$store.commit('login', data)
                var path = _this.$route.query.redirect
                _this.$router.replace({path: path === '/' || path === undefined ? '/admin/dashboard' : path})
              } else {
                // console.log(resp.data.message);
                this.$alert( resp.data.message, '提示', {
                  confirmButtonText: '确定'
                })
              }
            })
            .catch(failResponse => {})
          }
        }

   
      }
    }
</script>
<style>
   #paper {
    background:url("../assets/img/bg/bgc.jpg") no-repeat;
    /* background-color: #87CEFA; */
    background-position: center;
    height: 100%;
    width: 100%;
    background-size: cover;
    position: fixed;
  }
   body{
     margin: -5px 0px;
   }
  .login-container {
    border-radius: 15px;
    background-clip: padding-box;
    margin: 90px auto;
    width: 350px;
    padding: 35px 35px 15px 35px;
    background: #ddd;
    border: 1px solid #eaeaea;
    box-shadow: 0 0 25px #cac6c6;
  }
  .login_title {
    margin: 0px auto 40px auto;
    text-align: center;
    color: #505458;
  }
  .login_remember {
    margin: 0px 0px 35px 0px;
    text-align: left;
  }
  /*.login_button {*/
    /*background: #505458;*/
  /*}*/
  /*el_checkbox {*/
    /*background: #505458;*/
  /*}*/
</style>
