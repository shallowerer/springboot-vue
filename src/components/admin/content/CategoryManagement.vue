<template>
  <div>
    <!-- （编辑）修改信息弹框 -->
    <el-dialog
      title="类型信息"
      :visible.sync="dialogFormVisible">
      <el-form v-model="selectedCate" style="text-align: left" ref="dataForm">
        <el-form-item label="类型id" label-width="120px" prop="id">
          <label>{{selectedCate.id}}</label>
        </el-form-item>
        <el-form-item label="类型名称" label-width="120px" prop="name">
          <el-input v-model="selectedCate.name" autocomplete="off"></el-input>
        </el-form-item>
        <!-- <el-form-item label="会员昵称" label-width="120px" prop="name">
          <el-input v-model="selectedCate.membername" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="真实姓名" label-width="120px" prop="phone">
          <el-input v-model="selectedCate.truename" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="手机号码" label-width="120px" prop="email">
          <el-input v-model="selectedCate.phone" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="邮箱" label-width="120px" prop="email">
          <el-input v-model="selectedCate.email" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="地址" label-width="120px" prop="password">
          <el-input v-model="selectedCate.memberaddr" autocomplete="off"></el-input>
        </el-form-item> -->
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="onSubmit(selectedCate)">确 定</el-button>
      </div>
    </el-dialog>

    <el-row style="margin: 18px 0px 0px 18px ">
      <el-breadcrumb separator-class="el-icon-arrow-right">
        <el-breadcrumb-item :to="{ path: '/admin/dashboard' }">管理中心</el-breadcrumb-item>
        <el-breadcrumb-item>门店管理</el-breadcrumb-item>
        <el-breadcrumb-item>类型管理</el-breadcrumb-item>
      </el-breadcrumb>
    </el-row>

    <!-- 批量添加组件 -->
    <bulk-registration @onSubmit="listCates()"></bulk-registration>
    <el-row>
    <div style="margin: 20px 0 0 -100px" class="">
      <el-input style="width:250px;margin-right:30px;" v-model="searchInfo.name" placeholder="类型名称"></el-input>
      <!-- <el-input style="width:250px;margin-right:30px;"  v-model="searchInfo.memberno" placeholder="会员编号"></el-input> -->
      <!-- <el-input style="width:250px;margin-right:30px;"  v-model="searchInfo.phone" placeholder="会员手机号"></el-input> -->
      <el-button type="primary" icon="el-icon-search" @click="handleSearch()">模糊搜索</el-button>
      <el-button type="primary" icon="el-icon-tickets" @click="returnList()">返回列表</el-button>
    </div>
    </el-row>

    <el-card style="margin: 18px 2%;width: 95%">
      <el-table
        :data="cates"
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
         fit>
        </el-table-column>
        <!-- <el-table-column
          prop="memberno"
          label="会员编号"
          fit>
        </el-table-column>
        <el-table-column
          prop="membername"
          label="会员昵称"
          fit>
        </el-table-column> -->
        <el-table-column
          prop="name"
          label="类型名称"
          fit>
        </el-table-column>
        <!-- <el-table-column
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
        </el-table-column> -->
        <el-table-column
          label="状态"
          sortable
          fit>
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
              @click="editCate(scope.row)"
              type="text"
              size="small">
              编辑
            </el-button>
            <el-button
              @click="deleteCate(scope.row)"
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
            cates: [],
            roles: [],
            dialogFormVisible: false,
            selectedCate: [],
            selectedRolesIds: [],
            searchInfo: []
          }
      },
      mounted () {
        this.listCates()
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
          this.listCates()
          
        },
        handleCurrentChange: function (currentPage) {  //页码更改方法
          this.currentPage = currentPage;
          // console.log(this.currentPage);
          this.listCates()
          
        },
        returnList(){
          var _this = this
          _this.searchInfo.name = '',

          this.disabledFlag = false
          this.$axios.get(`/cate/paging/0/5`).then(resp => {
            console.log(this.currentPage);
            
            if (resp && resp.status === 200) {
              _this.resData = resp.data
              _this.cates = _this.resData.content
              _this.totalElements = _this.resData.totalElements
              _this.pagesize = _this.resData.size
              // console.log( _this.members); 
            }
          })
        },
        handleSearch(){
          var _this = this
          if(this.searchInfo.name != null){
            console.log(this.searchInfo.name);
            this.$axios.post(`/cate/searchInfo`,{
              id: this.searchInfo.id,
              name: this.searchInfo.name
            }).then(resp => {
              if(resp && resp.status === 200 && Number(resp.data) != 0){
                _this.cates = resp.data
                _this.totalElements = resp.data.length
                _this.pagesize = resp.data.length
                _this.disabledFlag = true
                // console.log(111111,resp.data);
              }else{
                _this.cates = []
              }
            })
            // console.log(this.searchInfo.truename);
          }
        },
        listCates () {
          var _this = this
          this.$axios.get(`/cate/paging/${this.currentPage-1}/${this.pagesize}`).then(resp => {
            // console.log(this.currentPage);
            if (resp && resp.status === 200) {
              _this.resData = resp.data
              _this.cates = _this.resData.content
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
        commitStatusChange (value, cate) {
          this.$axios.put('/cate/status', {
            enabled: value,
            id: cate.id,
            name: cate.name,
          }).then(resp => {
            if (resp && resp.status === 200) {
              if (value) {
                this.$message('类型 [' + cate.name + '] 已启用')
              } else {
                this.$message('用户 [' + cate.name + '] 已禁用')
              }
            }
          })
        },
        onSubmit (selectedCate) {
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
          this.$axios.put('/cate/update',{
            id: selectedCate.id,
            name: selectedCate.name,
          }).then(resp => {
            if (resp && resp.status === 200) {
              this.$alert('用户信息修改成功')
              this.dialogFormVisible = false
              // 修改角色后重新请求用户信息，实现视图更新
              this.listCates()
            }
          }).catch((failResponse) => {
            this.$alert('发生错误', '提示', {
              confirmButtonText: '确定'
            })
          })
        },
        editCate (cate) {
          this.dialogFormVisible = true
          this.selectedCate = cate
          // let roleIds = []
          // for (let i = 0; i < user.roles.length; i++) {
          //   roleIds.push(user.roles[i].id)
          // }
          // this.selectedRolesIds = roleIds
        },
        deleteCate(cate){
          this.$confirm('确定删除？', '提示', {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
          }).then(() => {
            let _this = this
            this.$axios.delete(`/cate/deleteCate/${cate.id}`,{
            }).then(resp => {
            if (resp.data.code === 200) {
              this.$alert(resp.data.data, '提示', {
                confirmButtonText: '确定'
              })
              this.listCates()
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
