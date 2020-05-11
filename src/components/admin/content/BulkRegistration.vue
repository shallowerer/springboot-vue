<template>
  <div style="text-align: left">
    <el-button class="add-button" type="success" @click="dialogFormVisible = true">批量添加</el-button>
    
    <el-dialog
      title="信息详情"
      :visible.sync="dialogFormVisible"
      @close="clear"
      width="25%">
      <el-form :model="loginForm" :rules="rules" label-position="left"
               label-width="0px">
        <el-form-item prop="name">
          <el-input type="text" v-model="loginForm.name"
                    auto-complete="off" placeholder="类型名"></el-input>
        </el-form-item>
       
        <el-form-item style="width: 100%">
          <el-button type="primary" style="width: 40%;background: #505458;border: none" v-on:click="addCate">添加</el-button>
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
            name: [{required: true, message: '类型名不能为空', trigger: 'blur'}],
           
          },
          loginForm: {
            name: '',
          }
        }
      },
      methods: {
        clear () {
          this.loginForm = {
            name: '',
           
          }
        },
        addCate () {
          this.$axios
            .post('/addCate', {
              name: this.loginForm.name,
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
