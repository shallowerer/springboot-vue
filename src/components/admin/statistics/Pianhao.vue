<template>
  <div>
    <el-row style="margin: 18px 0px 0px 18px ">
      <el-breadcrumb separator-class="el-icon-arrow-right">
        <el-breadcrumb-item :to="{ path: '/admin/dashboard' }">管理中心</el-breadcrumb-item>
        <el-breadcrumb-item>销售统计</el-breadcrumb-item>
        <el-breadcrumb-item>会员偏好</el-breadcrumb-item>
      </el-breadcrumb>
    </el-row>
    <el-card style="margin: 18px 2%;width: 95%">
      <div class="el-card__header" >
        <slot name="header">用户数据输入</slot>
      </div>
        <div class="el-card__body" >
        <slot></slot>
        <div>
        输入会员id：
        <el-input
            style="width:200px;margin:0 30px 0 0"
          placeholder="会员id"
          clearable
          maxlength="20"
          v-model="input1">
        </el-input>
        
        <el-button @click="handleGetOne()" type="primary" style="margin:0 10px">获取会员偏好信息</el-button>
       </div>
      </div> 
    </el-card>

    <el-card style="margin: 18px 2%;width: 95%">
      <div class="el-card__header" >
          <slot name="header">用户偏好分析</slot>
      </div>
      <div class="el-card__body" >
        <div class="echart-sheet">
        <!--条形图-->
          <div id="allsh" style="width:80%; height: 400px;margin:0 auto"></div>
        </div>
      </div>
    </el-card>

    <el-card style="margin: 18px 2%;width: 95%">
      <div class="el-card__header" >
        <slot name="header">当前会员信息</slot>
      </div>
        <div class="el-card__body" >
        <slot></slot>
        <span style="display:inline-block;margin:0 30px">会员编号：{{memberInfo.id}}</span>
        <span style="display:inline-block;margin:0 30px">会员昵称：{{memberInfo.membername}}</span>
        <span style="display:inline-block;margin:0 30px">会员地址：{{memberInfo.memberaddr}}</span>
        <span style="display:inline-block;margin:0 30px">会员电话：{{memberInfo.phone}}</span>
        <span style="display:inline-block;margin:0 30px">会员真名：{{memberInfo.truename}}</span>
  
        
       
        
      </div>
      
    </el-card>
    <el-card style="margin: 18px 2%;width: 95%">
      <el-table
        :data="memberlove"
        stripe
        :default-sort = "{prop: 'id', order: 'ascending'}"
        style="width: 100%"
        >
        <el-table-column
          type="selection"
          width="55">
        </el-table-column>
        <!-- <el-table-column
          label="序号"
          type="index"
          sortable
          fit>
        </el-table-column> -->
        

        <el-table-column
          prop="times"
          label="购买次数"
          sortable
          fit>
        </el-table-column>
        <el-table-column
          prop="allamount"
          label="总购买量"
          sortable
          fit>
        </el-table-column>
         <el-table-column
          prop="commodityName"
          label="商品名称"
          sortable
          fit>
        </el-table-column>
        <el-table-column
          prop="totalmoney"
          label="消费额"
          sortable
          fit>
        </el-table-column>

        
        <!-- <el-table-column
          label="操作"
          width="120">
          <template slot-scope="scope">
            <el-button
              @click="editMembers(scope.row)"
              type="text"
              size="small">
              详情
            </el-button>
            
          </template>
        </el-table-column> -->
      </el-table>
      </el-card>
  </div>
</template>

<script>
export default {
  data(){
    return{
      input1: '',
      input2: '',
      input3:'',
      allPianhao:[],
      memberInfo:[],
      memberlove:[],
      memberPianhao:[]
    }
  },
  mounted () {
    this.loadData()
  },
  computed: {
     
  },
  methods: {
    loadData(){
      let _this = this
      this.$axios.get(`/allMemberPianhao`).then(resp => {
        if (resp && resp.status === 200) {
          _this.allPianhao = resp.data
          _this.memberlove =   resp.data[0].memberlove
          _this.memberInfo =   resp.data[0].memberInfo
          // console.log( resp.data[0].memberInfo); 
        }
      })  
    },

    handleGetOne(){
      let _this = this
      if(typeof Number(this.input1) == 'number'){
        this.$axios.get(`/oneMemberPianhao/${_this.input1}`).then(resp => {
          if (resp && resp.status === 200) {
          // console.log(resp.data);
            _this.memberInfo = resp.data[0].menberInfo
            _this.memberlove =   resp.data[0].memberlove
            console.log(_this.memberInfo);  
          }
        }) 
      }else{

      }

             
    }
  }

}
</script>

<style>

</style>