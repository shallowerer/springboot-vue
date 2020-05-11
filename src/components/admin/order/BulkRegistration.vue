<template>
  <div style="text-align: left">
    <el-button class="add-button" type="success" @click="dialogFormVisible = true">批量添加订单</el-button>
    
    <el-dialog
      title="添加订单"
      :visible.sync="dialogFormVisible"
      @close="clear"
      width="25%">
      <el-form :model="loginForm" :rules="rules" label-position="left"
               label-width="0px">
        <el-form-item prop="memberno">
          <el-input type="text" v-model="loginForm.memberno"
                    auto-complete="off" placeholder="编号"></el-input>
        </el-form-item>
        <el-form-item prop="membername">
          <el-input type="text" v-model="loginForm.membername"
                    auto-complete="off" placeholder="昵称"></el-input>
        </el-form-item>
        <el-form-item>
          <el-input type="text" v-model="loginForm.truename"
                    auto-complete="off" placeholder="真实姓名"></el-input>
        </el-form-item>
        <el-form-item>
          <el-input type="text" v-model="loginForm.phone"
                    auto-complete="off" placeholder="电话号码"></el-input>
        </el-form-item>
        <el-form-item>
          <el-input type="text" v-model="loginForm.email"
                    auto-complete="off" placeholder="邮箱"></el-input>
        </el-form-item>
         <el-form-item>
          <el-input type="text" v-model="loginForm.memberaddr"
                    auto-complete="off" placeholder="地址"></el-input>
        </el-form-item>
        <el-form-item style="width: 100%">
          <el-button type="primary" style="width: 40%;background: #505458;border: none" v-on:click="addMember">添加</el-button>
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
            truename: [{required: true, message: '真实姓名不能为空', trigger: 'blur'}],
            phone: [{required: true, message: '电话号码不能为空', trigger: 'blur'}],
            memberaddr: [{required: true, message: '地址不能为空', trigger: 'blur'}]
          },
          loginForm: {
            memberno: '',
            membername: '',
            truename: '',
            phone: '',
            email: '',
            memberaddr: ''
          }
        }
      },
      methods: {
        clear () {
          this.loginForm = {
            memberno: '',
            membername: '',
            truename: '',
            phone: '',
            email: '',
            memberaddr: ''
          }
        },
        addMember () {
          this.$axios
            .post('/addMember', {
              memberno: this.loginForm.memberno,
              membername: this.loginForm.membername,
              truename: this.loginForm.truename,
              phone: this.loginForm.phone,
              email: this.loginForm.email,
              memberaddr: this.loginForm.memberaddr,
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
