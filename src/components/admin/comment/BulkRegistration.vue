<template>
  <div style="text-align: left">
    <el-button class="add-button" type="success" @click="dialogFormVisible = true">批量添加</el-button>
    
    <el-dialog
      title="添加"
      :visible.sync="dialogFormVisible"
      @close="clear"
      width="25%">
      <el-form :model="loginForm" :rules="rules" label-position="left"
               label-width="0px">
        <el-form-item prop="memberno">
          <el-input type="text" v-model="loginForm.no"
                    auto-complete="off" placeholder="编号"></el-input>
        </el-form-item>
        <el-form-item prop="membername">
          <el-input type="text" v-model="loginForm.name"
                    auto-complete="off" placeholder="评论人"></el-input>
        </el-form-item>

        <!-- <el-form-item>
          <el-input type="text" v-model="loginForm.givetime"
                    auto-complete="off" placeholder="评价时间"></el-input>
        </el-form-item> -->
        <el-form-item>
          <el-input type="number"  :max="5" :min="1" v-model="loginForm.servicestar"
                    auto-complete="off" placeholder="服务得分"></el-input>
        </el-form-item>
        <el-form-item>
          <el-input type="number"  :max="5" :min="1" v-model="loginForm.costar"
                    auto-complete="off" placeholder="商品得分"></el-input>
        </el-form-item>
        <el-form-item>
          <el-input type="number"  :max="5" :min="1" v-model="loginForm.roomstar"
                    auto-complete="off" placeholder="环境得分"></el-input>
        </el-form-item>
        <el-form-item>
          <el-input type="text" v-model="loginForm.givecontent"
                    auto-complete="off" placeholder="评论内容"></el-input>
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
            name: [{required: true, message: '评论人不能为空', trigger: 'blur'}],
            givecontent: [{required: true, message: '评论内容不能为空', trigger: 'blur'}]
          },
          loginForm: {
            no: '',
            name: '',
            givetime: '',
            servicestar: '',
            costar: '',
            roomstar: '',
            givecontent: ''
          }
        }
      },
      methods: {
        clear () {
          this.loginForm = {
            no: '',
            name: '',
            givetime: '',
            servicestar: '',
            costar: '',
            roomstar: '',
            givecontent: ''
          }
        },
        addMember () {
          this.$axios
            .post('/addComment', {
              no: this.loginForm.no,
              name: this.loginForm.name,
              givetime: this.loginForm.givetime,
              servicestar: this.loginForm.servicestar,
              costar: this.loginForm.costar,
              roomstar: this.loginForm.roomstar,
              givecontent: this.loginForm.givecontent,
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
