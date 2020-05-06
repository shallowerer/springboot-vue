<template>
<div>
  <el-row style="margin: 18px 0px 0px 18px ">
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/admin/dashboard' }">管理中心</el-breadcrumb-item>
      <el-breadcrumb-item>个人管理</el-breadcrumb-item>
      <el-breadcrumb-item>个人信息</el-breadcrumb-item>
    </el-breadcrumb>
  </el-row>
  <el-form v-model="selectedUser" style="text-align: left" ref="dataForm">
      <el-form-item label="用户名" label-width="120px" prop="username">
        <label>{{selectedUser.username}}</label>
      </el-form-item>
      <el-form-item label="真实姓名" label-width="120px" prop="name">
        <el-input v-model="selectedUser.truename" autocomplete="off"></el-input>
      </el-form-item>
      <el-form-item label="手机号" label-width="120px" prop="phone">
        <el-input v-model="selectedUser.phone" autocomplete="off"></el-input>
      </el-form-item>
      <el-form-item label="邮箱" label-width="120px" prop="email">
        <el-input v-model="selectedUser.email" autocomplete="off"></el-input>
      </el-form-item>
      <el-form-item label="密码" label-width="120px" prop="password">
        <el-button type="warning" @click="resetPassword(selectedUser.username)">重置密码</el-button>
      </el-form-item>
      <el-form-item label="角色分配" label-width="120px" prop="roles">
        <el-checkbox-group v-model="selectedRolesIds">
            <el-checkbox v-for="(role,i) in roles" :key="i" :label="role.id">{{role.nameZh}}</el-checkbox>
        </el-checkbox-group>
      </el-form-item>
    </el-form>
    <div slot="footer" class="dialog-footer">
      <el-button @click="dialogFormVisible = false">取 消</el-button>
      <el-button type="primary" @click="onSubmit(selectedUser)">确 定</el-button>
    </div>  
  </div>
</template>

<script>
export default {
  data() {
    const item = {
      date: '2016-05-02',
      name: '王小虎',
      address: '上海市普陀区金沙江路 1518 弄'
    };
    return {
      tableData: Array(20).fill(item)
    }
  },
  methods: {
    listUsers () {
          var _this = this
          this.$axios.get('/admin/user').then(resp => {
            if (resp && resp.status === 200) {
              _this.users = resp.data
            }
          })
        },
    editUser (user) {
      // this.dialogFormVisible = true
      this.selectedUser = user
      let roleIds = []
      for (let i = 0; i < user.roles.length; i++) {
        roleIds.push(user.roles[i].id)
      }
      this.selectedRolesIds = roleIds
    },
  }
}
</script>

<style>
  
</style>