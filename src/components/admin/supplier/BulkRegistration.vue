<template>
  <div style="text-align: left">
    <el-button class="add-button" type="success" @click="dialogFormVisible = true">添加供应商</el-button>
    
    <el-dialog
      title="添加供应商"
      :visible.sync="dialogFormVisible"
      @close="clear"
      width="25%">
      <el-form :model="loginForm" :rules="rules" label-position="left"
               label-width="0px">
        <el-form-item prop="no">
          <el-input type="text" v-model="loginForm.no"
                    auto-complete="off" placeholder="编号"></el-input>
        </el-form-item>
        <el-form-item prop="name">
          <el-input type="password" v-model="loginForm.name"
                    auto-complete="off" placeholder="供应商名字"></el-input>
        </el-form-item>
        <el-form-item>
          <el-input type="text" v-model="loginForm.phone"
                    auto-complete="off" placeholder="电话号码"></el-input>
        </el-form-item>
        <el-form-item>
          <el-input type="text" v-model="loginForm.email"
                    auto-complete="off" placeholder="E-Mail"></el-input>
        </el-form-item>

        <el-form-item>
          <el-input type="text" v-model="loginForm.addr"
                    auto-complete="off" placeholder="供应商地址"></el-input>
        </el-form-item>
        <el-form-item style="width: 100%">
          <el-button type="primary" style="width: 40%;background: #505458;border: none" v-on:click="register">添加</el-button>
        </el-form-item>
      </el-form>
    </el-dialog>
  </div>
</template>

<script>
    export default {
        name: 'BulkRegistration',
      data () {
        return {
          dialogFormVisible: false,
          rules: {
            no: [{required: true, message: '用户名不能为空', trigger: 'blur'}],
            name: [{required: true, message: '密码不能为空', trigger: 'blur'}]
          },
          loginForm: {
            no: '',
            name: '',
            addr: '',
            phone: '',
            email: ''
          }
        }
      },
      methods: {
        clear () {
          this.loginForm = {
            no: '',
            name: '',
            addr: '',
            phone: '',
            email: ''
          }
        },
        register () {
          this.$axios
            .post('/addSupplier', {
              no: this.loginForm.username,
              name: this.loginForm.password,
              addr: this.loginForm.truename,
              phone: this.loginForm.phone,
              email: this.loginForm.email
            })
            .then(resp => {
              if (resp.data.code === 200) {
                this.$alert('添加成功', '提示', {
                  confirmButtonText: '确定'
                })
                this.clear()
                this.$emit('onSubmit')
              } else {
                this.$alert(resp.data.message, '提示', {
                  confirmButtonText: '确定'
                })
              }
            })
            .catch(failResponse => {})
        }
      }
    }
</script>

<style scoped>
  .add-button {
    margin: 18px 0 0 10px;
  }
</style>
