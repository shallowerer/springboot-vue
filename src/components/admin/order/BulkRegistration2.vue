<template>
  <div style="text-align: left">
    <el-button class="add-button" type="success" @click="dialogFormVisible = true">添加订单</el-button>
    
    <el-dialog
      title="添加订单"
      :visible.sync="dialogFormVisible"
      @close="clear"
      width="25%">
      <el-form :model="loginForm" :rules="rules" label-position="left"
               label-width="0px">
        <el-form-item prop="memberno">
          <el-input type="text" v-model="loginForm.orderNo"
                    auto-complete="off" placeholder="编号"></el-input>
        </el-form-item>
        <el-form-item prop="membername">
          <el-input type="text" v-model="loginForm.mid"
                    auto-complete="off" placeholder="会员id"></el-input>
        </el-form-item>
        <el-form-item>
          <el-input type="text" v-model="loginForm.totalPrice"
                    auto-complete="off" placeholder="总价"></el-input>
        </el-form-item>
        <el-form-item>
          <el-input type="text" v-model="loginForm.uid"
                    auto-complete="off" placeholder="管理员id"></el-input>
        </el-form-item>
         <el-form-item>
          <el-input type="text" v-model="loginForm.address"
                    auto-complete="off" placeholder="地址"></el-input>
        </el-form-item>
         <el-form-item>
          <el-input type="text" v-model="loginForm.payStatus"
                    auto-complete="off" placeholder="支付状态"></el-input>
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
            mid: [{required: true, message: '会员id不能为空', trigger: 'blur'}],
            totalPrice: [{required: true, message: '总价不能为空', trigger: 'blur'}],
            address: [{required: true, message: '地址不能为空', trigger: 'blur'}]
          },
          loginForm: {
            orderNo: '',
            mid: '',
            totalPrice: '',
            uid: '',
            address: '',
            payStatus: ''
          }
        }
      },
      methods: {
        clear () {
          this.loginForm = {
            orderNo: '',
            mid: '',
            totalPrice: '',
            uid: '',
            address: '',
            payStatus: ''
          }
        },
        addMember () {
          this.$axios
            .post('/addCommodityOrder', {
              orderNo: this.loginForm.orderNo,
              mid: this.loginForm.mid,
              totalPrice: this.loginForm.totalPrice,
              uid: this.loginForm.uid,
              address: this.loginForm.address,
              payStatus: this.loginForm.payStatus,
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
