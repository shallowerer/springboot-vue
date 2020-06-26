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
      <div class="el-card__header" >
          <slot name="header">用户偏好分析</slot>
      </div>
      <div class="el-card__body" >
        <div class="echart-sheet">
        <!--条形图-->
          <div id="allph" style="width:90%; height: 400px;margin:0 auto"></div>
        </div>
      </div>
    </el-card>
    <el-card style="margin: 18px 2%;width: 95%">
      <div class="el-card__header" >
        <slot name="header">输入会员id可直接查询其他会员偏好</slot>
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
import echarts from 'echarts'
export default {
  data(){
    return{
      input1: '',
      input2: '',
      input3:'',
      allPianhao:[],
      memberInfo:[],
      memberlove:[],
      memberPianhao:[],

      allph:[],

      params:{}
    }
  },
  mounted () {
    console.log(this.params);
    
    if(this.params.member){
      this.handleGetOneInit()
      return;
    }
    this.loadData()
  },
  computed: {
     
  },
  created(){
    //获取传入的参数
    var param = this.$route.query;
    // console.log(param);
    // var param = this.$route.params;
    this.params = param
    
  },
  methods: {
    loadData(){
      let _this = this
      this.$axios.get(`/allMemberPianhao`).then(resp => {
        if (resp && resp.status === 200) {
          _this.allPianhao = resp.data
          _this.memberlove =   resp.data[0].memberlove
          _this.memberInfo =   resp.data[0].memberInfo
          
          // console.table( resp.data[0].memberlove);
          _this.$nextTick(function() {
            _this.drawPie3('allph')
          })  
        }
      })  
    },
     handleGetOneInit(){
      let _this = this
      this.$axios.get(`/oneMemberPianhao/${_this.params.member.id}`).then(resp => {
        if (resp && resp.status === 200) {
          // console.log(resp.data);
          _this.memberInfo = resp.data[0].menberInfo
          _this.memberlove =   resp.data[0].memberlove
          // console.log(_this.memberlove);
          _this.$nextTick(function() {
            _this.drawPie3('allph')
          })  
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
            // console.log(_this.memberlove);
            _this.$nextTick(function() {
              _this.drawPie3('allph')
            })  
          }
        }) 
      }else{

      }             
    },

    drawPie3(id) {
      let _this = this
      this.charts = echarts.init(document.getElementById(id))
      this.charts.setOption({
        title: {
          text: '',
          subtext: '',
          x:'center'
        },
        tooltip : {
          trigger: 'item',
          formatter: "{a} <br/>{b} : {c} ({d}%)"
        },
            // backgroundColor: '#2c343c',
        legend: {
          // data: ['ddd','ddd','ddd','ddd']
          // selectedMode: false // 取消图例点击动态效果
        },
        toolbox: {
            show : true,
            feature : {
                mark : {show: true},
                dataView : {show: true, readOnly: false},
                magicType : {
                    show: true,
                    type: ['pie', 'funnel']
                },
                restore : {show: true},
                saveAsImage : {show: true}
            }
        },
        series: [
          {
            name: '总购买次数',
            type: 'pie',
            radius: '45%',
            roseType: 'angle',
            center: ['20%', '50%'],
            data:(function () {
              var arrNum = [];
              var temp = _this.memberlove;
              for(var i=0;i<temp.length; i++){
                arrNum.push({"value": temp[i].times,"name":temp[i].commodityName});
                // console.log(arrNum);
                
              }
              return arrNum;
            })()
          },
           {
            name: '总购买数量',
            type: 'pie',
            radius: '45%',
            roseType: 'angle',
            center: ['50%', '50%'],
            data:(function () {
              var arrNum = [];
              var temp = _this.memberlove;
              for(var i=0;i<temp.length; i++){
                arrNum.push({"value": temp[i].allamount,"name":temp[i].commodityName});
                // console.log(arrNum);
              }
              return arrNum;
            })()
          },
           {
            name: '总消费额',
            type: 'pie',
            radius: '45%',
            roseType: 'angle',
            center: ['80%', '50%'],
            data:(function () {
              var arrNum = [];
              var temp = _this.memberlove;
              for(var i=0;i<temp.length; i++){
                arrNum.push({"value": temp[i].totalmoney,"name":temp[i].commodityName});
                // console.log(arrNum);
                
              }
              return arrNum;
            })()
          },
        ]      
      })
    },
  }

}
</script>

<style>

</style>