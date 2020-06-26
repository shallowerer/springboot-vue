<template>
  <div style="text-align: left">
    <el-button class="add-button" type="success" @click="dialogFormVisible = true">添加明细</el-button>
    
    <el-dialog
      title="添加明细"
      :visible.sync="dialogFormVisible"
      @close="clear"
      width="25%">
      <el-form :model="loginForm" :rules="rules" label-position="left"
               label-width="0px">
        <el-form-item>
          <el-input type="text" v-model="loginForm.orderNo"
                    auto-complete="off" placeholder="订单编号"></el-input>
        </el-form-item>
        <el-form-item>
          <el-input type="text" v-model="loginForm.commodityId"
                    auto-complete="off" placeholder="商品id"></el-input>
        </el-form-item>
        <el-form-item>
          <el-input type="text" v-model="loginForm.commodityName"
                    auto-complete="off" placeholder="商品名称"></el-input>
        </el-form-item>
        <el-form-item>
          <el-input type="text" v-model="loginForm.price"
                    auto-complete="off" placeholder="价格"></el-input>
        </el-form-item>
        <el-form-item>
          <el-input type="text" v-model="loginForm.amount"
                    auto-complete="off" placeholder="数量"></el-input>
        </el-form-item>
        <el-form-item>
          <el-input type="text" v-model="loginForm.lttAccount"
                    auto-complete="off" placeholder="小计"></el-input>
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
            orderNo: '',
            commodityId: '',
            commodityName: '',
            amount: '',
            price: '',
            lttAccount: ''
          }
        }
      },
      methods: {
        clear () {
          this.loginForm = {
            orderNo: '',
            commodityId: '',
            commodityName: '',
            amount: '',
            price: '',
            lttAccount: ''
          }
        },
        addMember () {
          this.$axios
            .post('/addOrderItem', {
              orderId: this.loginForm.orderNo,
              commodityId: this.loginForm.commodityId,
              commodityName: this.loginForm.commodityName,
              amount: this.loginForm.amount,
              price: this.loginForm.price,
              lttAccount: this.loginForm.lttAccount,
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
