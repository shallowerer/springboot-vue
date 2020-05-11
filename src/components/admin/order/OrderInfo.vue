<template>
  <div>
    <!-- （编辑）修改信息弹框 -->
    <el-dialog
      title="修改订单信息"
      :visible.sync="dialogFormVisible">
      <el-form v-model="selectedMember" style="text-align: left" ref="dataForm">
        <el-form-item label="会员标识" label-width="120px" prop="id">
          <label>{{selectedMember.id}}</label>
        </el-form-item>
        <el-form-item label="会员编号" label-width="120px" prop="name">
          <el-input v-model="selectedMember.memberno" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="会员昵称" label-width="120px" prop="name">
          <el-input v-model="selectedMember.membername" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="真实姓名" label-width="120px" prop="phone">
          <el-input v-model="selectedMember.truename" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="手机号码" label-width="120px" prop="email">
          <el-input v-model="selectedMember.phone" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="邮箱" label-width="120px" prop="email">
          <el-input v-model="selectedMember.email" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="地址" label-width="120px" prop="password">
          <el-input v-model="selectedMember.memberaddr" autocomplete="off"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="onSubmit(selectedMember)">确 定</el-button>
      </div>
    </el-dialog>

    <el-row style="margin: 18px 0px 0px 18px ">
      <el-breadcrumb separator-class="el-icon-arrow-right">
        <el-breadcrumb-item :to="{ path: '/admin/dashboard' }">管理中心</el-breadcrumb-item>
        <el-breadcrumb-item>订单管理</el-breadcrumb-item>
        <el-breadcrumb-item>订单信息</el-breadcrumb-item>
      </el-breadcrumb>
    </el-row>

    <!-- 批量添加组件 -->
    <bulk-registration @onSubmit="listMembers()"></bulk-registration>
    <el-row>
    <div style="margin: 20px 0 0 -100px" class="">
      <el-input style="width:250px;margin-right:30px;" v-model="searchInfo.truename" placeholder="会员真名"></el-input>
      <el-input style="width:250px;margin-right:30px;"  v-model="searchInfo.memberno" placeholder="会员编号"></el-input>
      <el-input style="width:250px;margin-right:30px;"  v-model="searchInfo.phone" placeholder="会员手机号"></el-input>
      <el-button type="primary" icon="el-icon-search" @click="handleSearch()">模糊搜索</el-button>
      <el-button type="primary" icon="el-icon-tickets" @click="returnList()">返回列表</el-button>
    </div>
    </el-row>

    <el-card style="margin: 18px 2%;width: 95%">
      <el-table
        :data="members"
        stripe
        :default-sort = "{prop: 'id', order: 'ascending'}"
        style="width: 100%"
        :max-height="tableHeight">
        <el-table-column
          type="selection"
          width="55">
        </el-table-column>
        <el-table-column
          prop="id"
          label="id"
          sortable
          width="100">
        </el-table-column>
        <el-table-column
          prop="memberno"
          label="会员编号"
          fit>
        </el-table-column>
        <el-table-column
          prop="membername"
          label="会员昵称"
          fit>
        </el-table-column>
        <el-table-column
          prop="truename"
          label="真实姓名"
          fit>
        </el-table-column>
        <el-table-column
          prop="phone"
          label="手机号"
          fit>
        </el-table-column>
        <el-table-column
          prop="email"
          label="邮箱"
          show-overflow-tooltip
          fit>
        </el-table-column>
        <el-table-column
          prop="memberaddr"
          label="会员地址"
          fit>
        </el-table-column>
        <el-table-column
          label="状态"
          sortable
          width="100">
          <template slot-scope="scope">
            <el-switch
              v-model="scope.row.enabled"
              active-color="#13ce66"
              inactive-color="#ff4949"
              @change="(value) => commitStatusChange(value, scope.row)">
            </el-switch>
          </template>
        </el-table-column>
        
        <el-table-column
          label="操作"
          width="120">
          <template slot-scope="scope">
            <el-button
              @click="editMembers(scope.row)"
              type="text"
              size="small">
              编辑
            </el-button>
            <el-button
              @click="deleteMembers(scope.row)"
              type="text"
              size="small">
              移除
            </el-button>
          </template>
        </el-table-column>
      </el-table>
      <div style="margin: 20px 0 20px 0;float: left">
        <el-button>取消选择</el-button>
        <el-button>批量删除</el-button>
      </div>
      <el-row>
        <el-pagination 
          :disabled="disabledFlag" 
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page="currentPage"
          :page-sizes="[5, 10, 20, 50]"
          :page-size="pagesize"
          layout="total, sizes, prev, pager, next, jumper"
          :total="totalElements"
          style="margin-top:25px">
        </el-pagination>
    </el-row>
    </el-card>
  </div>
</template>

<script>
  import BulkRegistration from './BulkRegistration'
    export default {
      name: 'UserProfile',
      components: {BulkRegistration},
      data () {
          return {
            disabledFlag: false,
            currentPage: 1,   //默认页码为1
            pagesize: 5,  //默认一页显示10条
            totalElements: 0,
            members: [],
            roles: [],
            dialogFormVisible: false,
            selectedMember: [],
            selectedRolesIds: [],
            searchInfo: []
          }
      },
      mounted () {
        this.listMembers()
        // this.listRoles()
      },
      computed: {
        tableHeight () {
          // return window.innerHeight - 320
        }
      },
      methods: {
        handleSizeChange: function (size) {   //一页显示多少条
          this.pagesize = size;
          // console.log(this.pagesize);
          this.listMembers()
          
        },
        handleCurrentChange: function (currentPage) {  //页码更改方法
          this.currentPage = currentPage;
          // console.log(this.currentPage);
          this.listMembers()
          
        },
        returnList(){
          var _this = this
          _this.searchInfo.truename = '',
          _this.searchInfo.memberno = '',
          _this.searchInfo.phone = ''
          this.disabledFlag = false
          this.$axios.get(`/member/paging/0/5`).then(resp => {
            console.log(this.currentPage);
            
            if (resp && resp.status === 200) {
              _this.resData = resp.data
              _this.members = _this.resData.content
              _this.totalElements = _this.resData.totalElements
              _this.pagesize = _this.resData.size
              // console.log( _this.members); 
            }
          })
        },
        handleSearch(){
          var _this = this
          if(this.searchInfo.truename != null || this.searchInfo.memberno != null || this.searchInfo.phone != null){
            console.log(this.searchInfo.truename, this.searchInfo.memberno, this.searchInfo.phone);
            this.$axios.post(`/member/searchInfo`,{
              truename: this.searchInfo.truename,
              memberno: this.searchInfo.memberno,
              phone: this.searchInfo.phone
            }).then(resp => {
              if(resp && resp.status === 200 && Number(resp.data) != 0){
                _this.members = resp.data
                _this.totalElements = resp.data.length
                _this.pagesize = resp.data.length
                _this.disabledFlag = true
                // console.log(111111,resp.data);
              }else{
                _this.members = []
              }
            })
            // console.log(this.searchInfo.truename);
          }
        },
        listMembers () {
          var _this = this
          this.$axios.get(`/member/paging/${this.currentPage-1}/${this.pagesize}`).then(resp => {
            // console.log(this.currentPage);
            if (resp && resp.status === 200) {
              _this.resData = resp.data
              _this.members = _this.resData.content
              _this.totalElements = _this.resData.totalElements
              _this.pagesize = _this.resData.size
              // console.log( _this.members); 
            }
          })
        },
        // listRoles () {
        //   var _this = this
        //   this.$axios.get('/admin/role').then(resp => {
        //     if (resp && resp.status === 200) {
        //       _this.roles = resp.data
        //     }
        //   })
        // },
        commitStatusChange (value, member) {
          this.$axios.put('/member/status', {
            enabled: value,
            membername: member.membername,
            memberno: member.memberno
          }).then(resp => {
            if (resp && resp.status === 200) {
              if (value) {
                this.$message('用户 [' + member.membername + '] 已启用')
              } else {
                this.$message('用户 [' + member.membername + '] 已禁用')
              }
            }
          })
        },
        onSubmit (selectedMember) {
          // let _this = this
          // // 根据视图绑定的角色 id 向后端传送角色信息
          // let roles = []
          // for (let i = 0; i < _this.selectedRolesIds.length; i++) {
          //   for (let j = 0; j < _this.roles.length; j++) {
          //     if (_this.selectedRolesIds[i] === _this.roles[j].id) {
          //       roles.push(_this.roles[j])
          //     }
          //   }
          // }
          let _this = this
          this.$axios.put('/member/update',{
            id: selectedMember.id,
            memberno: selectedMember.memberno,
            membername: selectedMember.membername,
            truename: selectedMember.truename,
            phone: selectedMember.phone,
            email: selectedMember.email,
            memberaddr: selectedMember.memberaddr
          }).then(resp => {
            if (resp && resp.status === 200) {
              this.$alert('用户信息修改成功')
              this.dialogFormVisible = false
              // 修改角色后重新请求用户信息，实现视图更新
              this.listMembers()
            }
          }).catch((failResponse) => {
            this.$alert('发生错误', '提示', {
              confirmButtonText: '确定'
            })
          })
        },
        editMembers (member) {
          this.dialogFormVisible = true
          this.selectedMember = member
          // let roleIds = []
          // for (let i = 0; i < user.roles.length; i++) {
          //   roleIds.push(user.roles[i].id)
          // }
          // this.selectedRolesIds = roleIds
        },
        deleteMembers(member){
          this.$confirm('确定删除？', '提示', {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
          }).then(() => {
            let _this = this
            this.$axios.delete(`/member/deleteMember/${member.id}`,{
            }).then(resp => {
            if (resp.data.code === 200) {
              this.$alert(resp.data.data, '提示', {
                confirmButtonText: '确定'
              })
              this.listMembers()
            } else {
              this.$alert(resp.data.message, '提示', {
                confirmButtonText: '确定'
              })
            }
          }).catch(failResponse => {
            this.$alert('发生错误', '提示', {
              confirmButtonText: '确定'
            })
          }) 
          })             
        },
        // resetPassword (username) {
        //   this.$axios.put('/admin/user/password', {
        //     username: username
        //   }).then(resp => {
        //     if (resp && resp.status === 200) {
        //       this.$alert('密码已重置为 123')
        //   }
        //   })
        // }
      }
    }
</script>

<style scoped>

</style>
