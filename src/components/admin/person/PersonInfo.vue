<template>
  <div>
    <el-row style="margin: 18px 0px 0px 18px ">
      <el-breadcrumb separator-class="el-icon-arrow-right">
        <el-breadcrumb-item :to="{ path: '/admin/dashboard' }">管理中心</el-breadcrumb-item>
        <el-breadcrumb-item>个人管理</el-breadcrumb-item>
        <el-breadcrumb-item>个人信息</el-breadcrumb-item>
      </el-breadcrumb>
    </el-row>

    <el-dialog
      title="修改个人信息"
      :visible.sync="dialogFormVisible">
        <el-card style="">
          <el-form v-model="form" style="text-align: left" ref="form">
            <el-form-item label="唯一标识:" label-width="120px" prop="id">{{personalInfo.id}}
              <!-- <el-input v-model="form.title" autocomplete="off" placeholder=""></el-input> -->
            </el-form-item>
            <el-form-item label="账户类型:" label-width="120px" prop="truename">{{personalInfo.truename}}
              <!-- <el-input v-model="form.date" autocomplete="off"></el-input> -->
            </el-form-item>
            <el-form-item label="账号名称:" label-width="120px" prop="username">
              <el-input v-model="personalInfo.username" autocomplete="off"></el-input>
            </el-form-item>
            <el-form-item label="联系电话:" label-width="120px" prop="phone">
              <el-input v-model="personalInfo.phone" autocomplete="off"></el-input>
            </el-form-item>
            <el-form-item label="联系邮箱:" label-width="120px" prop="email">
              <el-input v-model="personalInfo.email" autocomplete="off" placeholder="图片 URL"></el-input>
            </el-form-item>
            <el-form-item label="其他:" label-width="120px" prop="cover">
              更为详细信息修改请联系超级管理员admin
              <!-- <el-input typr="password" v-model="form.cover" autocomplete="off" placeholder="图片 URL"></el-input> -->
            </el-form-item>
           
            <!-- <el-form-item prop="id:" style="height: 0">
              <el-input type="hidden" v-model="form.id" autocomplete="off"></el-input>
            </el-form-item> -->
          </el-form>
        </el-card>
      <div slot="footer" class="dialog-footer">
        <el-button  style="margin:0 20px" @click="dialogFormVisible = false">取消</el-button>
        <el-button type="primary" style="margin:0 20px" @click="editSubmit()">确定</el-button>
      </div>
    </el-dialog> 



    <el-dialog
      title="修改个人信息"
      :visible.sync="dialogFormforPassword">
        <el-card style="">
          <el-form v-model="form" style="text-align: left" ref="form">
            <el-form-item label="唯一标识:" label-width="120px" prop="id">{{personalInfo.id}}
              <!-- <el-input v-model="form.title" autocomplete="off" placeholder=""></el-input> -->
            </el-form-item>
            <el-form-item label="账号名称:" label-width="120px" prop="username">{{personalInfo.username}}
              <!-- <el-input v-model="personalInfo.username" autocomplete="off"></el-input> -->
            </el-form-item>
            <el-form-item label="密码设置:" label-width="120px" prop="username">
              <el-input v-model="passwordEdit" autocomplete="off"></el-input>
            </el-form-item>
          </el-form>
        </el-card>
      <div slot="footer" class="dialog-footer">
        <el-button  style="margin:0 20px" @click="dialogFormforPassword=false;passwordEdit=''">取消</el-button>
        <el-button type="primary" style="margin:0 20px" @click="passwordSubmit()">确定</el-button>
      </div>
    </el-dialog> 
      
    <el-card style="width: 600px; margin:55px auto;">
      <el-form  style="text-align: left" >
        <el-form-item label="唯一标识:" label-width="120px" prop="title">{{personalInfo.id}}</el-form-item>
        <el-form-item label="账号名称:" label-width="120px" prop="cno">{{personalInfo.username}}</el-form-item>
        <el-form-item label="账户类型:" label-width="120px" prop="date">{{personalInfo.truename}}</el-form-item>
        <el-form-item label="联系电话:" label-width="120px" prop="sellPrice">{{personalInfo.phone}}</el-form-item>
        <el-form-item label="联系邮箱:" label-width="120px" prop="cover">{{personalInfo.email}}</el-form-item>
        <el-form-item label="注册日期:" label-width="120px" prop="abs">2020-02-02</el-form-item>
        <el-form-item prop="id:" style="height: 0"></el-form-item>
      </el-form>
    </el-card>
    <div slot="footer" class="dialog-footer">
      <el-button  style="margin:0 20px">退出账号</el-button>
      <el-button type="warning"  @click="setPassword()" style="margin:0 20px">修改密码</el-button>
      <el-button type="primary"  @click="editInfo()" style="margin:0 20px">修改信息</el-button>
    </div>
  </div> 
</template>

<script>
export default {
  data(){
    return{
      form: {
        id: '',
        username: '',
        truename: '',
        phone: '',
        email: ''
      },
      passwordEdit: '',
      personalInfo: {},
      dialogFormVisible: false,
      dialogFormforPassword: false,
      dataForm:{
        nickName: '超级管理员',
        phone: '173567777777',
        homeUrl: 'http://www.baidu.com'
      }
    }
  },
  mounted () {
    this.getPersonalInfo()
    // this.listRoles()
  },
  methods: {
    getPersonalInfo (){
      var _this = this
      this.$axios.get('/personalInfo').then(resp => {
        if (resp && resp.status === 200) {
          _this.personalInfo = resp.data.personalInfo
          console.dir(_this.personalInfo);
          
          // console.log( _this.members); 
        }
      })
    },
    setPassword(){
      this.dialogFormforPassword = true
    },
    editInfo () {
      this.dialogFormVisible = true
    },
    passwordSubmit(){
      this.$confirm('确定修改？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.$axios.put('/personal/setPassword',{
        id: this.personalInfo.id,
        username: this.personalInfo.username,
        password: this.passwordEdit
        }).then(resp => {
          if (resp && resp.status === 200) {
            this.$alert('修改成功，请重新登陆，否则部分功能将无法正常使用！')
            this.passwordEdit = ''
            this.dialogFormforPassword = false
          }
        }).catch((failResponse) => {
          this.$alert('发生错误', '提示', {
            confirmButtonText: '确定'
          })
        })
      })
    },
    editSubmit(){
      console.log(this.personalInfo.username);
      this.$axios.put('/personal/setSimpleInfo',{
        id: this.personalInfo.id,
        truename: this.personalInfo.truename,
        username: this.personalInfo.username,
        phone: this.personalInfo.phone,
        email: this.personalInfo.email
      }).then(resp => {
        if (resp && resp.status === 200) {
          this.$alert('用户信息修改成功')
          this.dialogFormVisible = false
        }
      }).catch((failResponse) => {
        this.$alert('发生错误', '提示', {
          confirmButtonText: '确定'
        })
      })
    }
     
  }

}
</script>

<style>

 
</style>