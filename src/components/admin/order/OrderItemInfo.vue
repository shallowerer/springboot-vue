<template>
  <div>
    <!-- （编辑）修改信息弹框 -->
    <el-dialog
      title="修改订单明细信息"
      :visible.sync="dialogFormVisible">
      <el-form v-model="selectedMember" style="text-align: left" ref="dataForm">
        <el-form-item label="标识" label-width="120px" prop="id">
          <label>{{selectedMember.id}}</label>
        </el-form-item>
        <el-form-item label="订单编号" label-width="120px" prop="orderNo">
          <el-input v-model="selectedMember.orderNo" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="商品id" label-width="120px" prop="commodityId">
          <el-input v-model="selectedMember.commodityId" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="商品名称" label-width="120px" prop="commodityName">
          <el-input v-model="selectedMember.commodityName" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="数量" label-width="120px" prop="amount">
          <el-input v-model="selectedMember.amount" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="价格￥" label-width="120px" prop="price">
          <el-input v-model="selectedMember.price" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="小计￥" label-width="120px" prop="lttAccount">
          <el-input v-model="selectedMember.lttAccount" autocomplete="off"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false;returnList()">取 消</el-button>
        <el-button type="primary" @click="onSubmit(selectedMember)">确 定</el-button>
      </div>
    </el-dialog>

    <el-row style="margin: 18px 0px 0px 18px ">
      <el-breadcrumb separator-class="el-icon-arrow-right">
        <el-breadcrumb-item :to="{ path: '/admin/dashboard' }">管理中心</el-breadcrumb-item>
        <el-breadcrumb-item>订单管理</el-breadcrumb-item>
        <el-breadcrumb-item>订单明细</el-breadcrumb-item> 
      </el-breadcrumb>
    </el-row>

    <!-- 批量添加组件 -->
    <bulk-registration @onSubmit="listMembers()"></bulk-registration>
    <el-row>
    <div style="margin: 20px 0 0 -100px" class="">
      <el-input style="width:250px;margin-right:30px;"  v-model="searchInfo.commodityName" placeholder="商品名称"></el-input>
      <!-- <el-input style="width:250px;margin-right:30px;"  v-model="searchInfo.orderNo" placeholder="订单编号"></el-input> -->
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
          label="明细表编号"
          sortable
          fit>
        </el-table-column>
        <el-table-column
          prop="commodityOrder.orderNo"
          label="订单编号"
          fit>
        </el-table-column>
        <el-table-column
          prop="commodityName"
          label="商品名称"
          fit>
        </el-table-column>
        <el-table-column
          prop="amount"
          label="数量"
          fit>
        </el-table-column>
        <el-table-column
          prop="price"
          label="价格￥"
          fit>
        </el-table-column>
        <el-table-column
          prop="lttAccount"
          label="小计￥"
          fit>
        </el-table-column>
       

        <!-- <el-table-column
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
        </el-table-column> -->
        
        <el-table-column
          label="操作"
          width="120">
          <template slot-scope="scope">
            <el-button
              @click="editMembers(scope.row,scope.row.commodityOrder.orderNo)"
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
          _this.searchInfo=[]
          this.disabledFlag = false
          this.$axios.get(`/orderItem/paging/0/5`).then(resp => {
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
          if(this.searchInfo.commodityName != null || this.searchInfo.memberno != null){
            this.$axios.post(`/orderItem/searchInfo`,{
              commodityName: this.searchInfo.commodityName,
              orderNo: this.searchInfo.orderNo
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
          this.$axios.get(`/orderItem/paging/${this.currentPage-1}/${this.pagesize}`).then(resp => {
            // console.log(this.currentPage);
            if (resp && resp.status === 200) {
              console.log(resp);
              
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
          this.$axios.put('/orderItem/status', {
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
          this.$axios.put('/orderItem/update',{
            id: selectedMember.id,
            orderNo: selectedMember.orderNo,
            commodityId: selectedMember.commodityId,
            commodityName: selectedMember.commodityName,
            amount: selectedMember.amount,
            price: selectedMember.price,
            lttAccount: selectedMember.lttAccount
          }).then(resp => {
            if (resp && resp.status === 200) {
              this.$alert('信息修改成功')
              this.dialogFormVisible = false
              // 修改角色后重新请求用户信息，实现视图更新
              this.returnList()
            }
          }).catch((failResponse) => {
            this.$alert('发生错误', '提示', {
              confirmButtonText: '确定'
            })
          })
        },
        editMembers (member,oId) {
          // console.log(oId);
          
          this.dialogFormVisible = true
          this.selectedMember = member
          this.selectedMember.orderNo = oId

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
            this.$axios.delete(`/orderItem/deleteOrderItem/${member.id}`,{
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
