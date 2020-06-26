<template>
  <div>
    <el-row style="margin: 18px 0px 0px 18px ">
      <el-breadcrumb separator-class="el-icon-arrow-right">
        <el-breadcrumb-item :to="{ path: '/admin/dashboard' }">管理中心</el-breadcrumb-item>
        <el-breadcrumb-item>销售统计</el-breadcrumb-item>
        <el-breadcrumb-item>群体偏好</el-breadcrumb-item>
      </el-breadcrumb>
    </el-row>
    <el-card style="margin: 18px 2%;width: 95%">
      <div class="el-card__header" >
        <div style="margin-left:00px;margin-bottom:30px">
          <div style="margin-bottom:15px">
            年龄：<el-select filterable @change="selectAge" v-model="age" placeholder="年龄段" style="width:130px;margin-right:30px">
              <el-option value="0" label="所有年龄"></el-option>
              <el-option value="[10,19]" label="10到20岁"></el-option>
              <el-option value="[20,29]" label="20到30岁"></el-option>
              <el-option value="[30,39]" label="30到40岁"></el-option>
              <el-option value="[40,49]" label="40到50岁"></el-option>
              <el-option value="[50,59]" label="50到60岁"></el-option>
              <el-option value="[60,90]" label="大于60岁"></el-option>
              
            </el-select>

            性别：<el-select @change="selectSex"  v-model="sex" filterable placeholder="选择性别" style="width:130px;margin-right:30px">
              <el-option label="保密" value="0"></el-option>
              <el-option label="男" value="男"></el-option>
              <el-option label="女" value="女"></el-option>
            </el-select>
            省份：<el-select @change="selectProvince" v-model="province" filterable placeholder="选择省份" style="width:130px;margin-right:30px">
              <el-option value="0" label="所有省份"></el-option>
              <el-option v-for="item in allProvince" 
                :key="item"
                :label="item"
                :value="item"
              >
              </el-option>
            </el-select>

            城市：<el-select @change="selectCity" v-model="city" filterable placeholder="所在市" style="width:130px;margin-right:30px">
              <el-option value="0" label="所有城市"></el-option>
              <el-option v-for="item in allCity" 
                :key="item"
                :label="item"
                :value="item"
              >
              </el-option>
            </el-select>
            </div>
            <div style="margin-bottom:30px">
            地区：<el-select @change="selectArea" v-model="area" filterable placeholder="所在区" style="width:130px;margin-right:30px">
              <el-option value="0" label="所有地区"></el-option>
              <el-option v-for="item in allArea" 
                :key="item"
                :label="item"
                :value="item"
              >
              </el-option>
            </el-select>
            街道：<el-select @change="selectTown"  v-model="town" filterable placeholder="所在街道（镇）" style="width:130px;margin-right:30px">
              <el-option value="0" label="所有街道"></el-option>
              <el-option v-for="item in allTown" 
                :key="item"
                :label="item"
                :value="item"
              >
              </el-option>              
            </el-select>
            路段：<el-select @change="selectRoad"  v-model="road" filterable placeholder="所在大道（村）" style="width:130px;margin-right:30px">
              <el-option value="0" label="所有大道"></el-option>
              <el-option v-for="item in allRoad" 
                :key="item"
                :label="item"
                :value="item"
              >
              </el-option>
            </el-select>
            小区：<el-select @change="selectMyfloor"  v-model="myfloor" filterable placeholder="所在小区（屯）" style="width:130px;margin-right:30px">
              <el-option value="0" label="所有小区"></el-option>
              <el-option v-for="item in allMyfloor" 
                :key="item"
                :label="item"
                :value="item"
              >
              </el-option>
            </el-select>
          </div>
          <div style="margin-left:00px">
            <el-button type="primary" @click="getAn"  icon="el-icon-search">开始分析</el-button>
            <el-button type="primary" @click="back"  icon="el-icon-search">返回所有</el-button>
          </div>
        </div>
      
      <slot name="header">财务收入趋势</slot>
      </div>
      <div class="el-card__body" >
        <div class="echart-sheet">
        <!--条形图-->
          <div id="allph" style="width:90%; height: 400px;margin:0 auto"></div>
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
          label="产生消费额"
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

      //群体偏好
      allph:[],


      //预先获取范围
      allProvince:[],
      allCity:[],
      allArea:[],
      allTown:[],
      allRoad:[],
      allMyfloor:[],


      //设置分析条件
      age:'',
      sex:'',
      province:'',
      city:'',
      area:'',
      town:'',
      road:'',

      // 和后端保持一致，后端怕与MySQL关键字同名
      myfloor:''
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
      this.$axios.get(`/allPianhao`).then(resp => {
        if (resp && resp.status === 200) {
          _this.memberlove = resp.data
          _this.$nextTick(function() {
            _this.drawPie3('allph')
          })  
        }
      })

      //获取订单出现的省份
      this.$axios.get(`/getAllProvince`).then(resp => {
        if (resp && resp.status === 200) {
          _this.allProvince = resp.data
        }
      })

      
    },


    // 用户输入后开始分析
    getAn(e){
      let _this = this
      let age = this.age
      let sex = this.sex
      let province = this.province
      let city =this.city
      let area =this.area
      let town =this.town
      let road =this.road
      let myfloor =this.myfloor
      // console.log(year,month,week);


// ----------单一判断------------
      //单单判断年龄
      if(age != 0 && sex == 0 && province == 0 && city == 0 && area == 0 && town == 0 && road == 0 && myfloor == 0){
        let ageArr = eval(_this.age)
        this.$axios.get(`/getPreferenceByAge?age1=${ageArr[0]}&age2=${ageArr[1]}`).then(resp => {
          if (resp && resp.status === 200) {
            // console.log(resp);
            _this.memberlove = resp.data
            if(resp.data.length<=0){
              this.$alert('所选择的范围没有数据', '分析提示', {
                confirmButtonText: '确定',
              });
            }
          }
          _this.$nextTick(function() {
            _this.drawPie3('allph')
          }) // 延迟调用
        })
      }

      //单单判断性别
      if(age==0 && sex != 0 && province == 0 && city == 0 && area == 0  && town == 0 && road == 0 && myfloor == 0){
          this.$axios.get(`/getPreferenceBySex?sex=${_this.sex}`).then(resp => {
          if (resp && resp.status === 200) {
            _this.memberlove = resp.data
            if(resp.data.length<=0){
              this.$alert('所选择的范围没有数据', '分析提示', {
                confirmButtonText: '确定',
              });
            }
          }
          _this.$nextTick(function() {
            _this.drawPie3('allph')
          }) // 延迟调用
        })
      }


      //单单判断省
      if(age==0 && sex == 0 && province != 0 && city == 0 && area == 0 && town == 0 && road == 0 && myfloor == 0){
        this.$axios.get(`/getPreferenceByP?province=${_this.province}`).then(resp => {
          // console.log(resp);
          
          if (resp && resp.status === 200) {
            _this.memberlove = resp.data
            if(resp.data.length<=0){
              this.$alert('所选择的范围没有数据', '分析提示', {
                confirmButtonText: '确定',
              });
            }
          }
          _this.$nextTick(function() {
            _this.drawPie3('allph')
          }) // 延迟调用
        })
      }

      //单单判断省市
      if(age==0 && sex == 0 && province != 0 && city != 0  && area == 0  && town == 0 && road == 0 && myfloor == 0){
        this.$axios.get(`/getPreferenceByPC?province=${_this.province}&city=${_this.city}`).then(resp => {
          // console.log(resp);
          if (resp && resp.status === 200) {
            _this.memberlove = resp.data
            if(resp.data.length<=0){
              this.$alert('所选择的范围没有数据', '分析提示', {
                confirmButtonText: '确定',
              });
            }
          }
          _this.$nextTick(function() {
            _this.drawPie3('allph')
          }) // 延迟调用
        })
      }

      //单单判断省市区
      if(age==0 && sex == 0 && province != 0 && city != 0 && area != 0 && town == 0 && road == 0 && myfloor == 0){
        this.$axios.get(`/getPreferenceByPCA?province=${_this.province}&city=${_this.city}&area=${_this.area}`).then(resp => {
          // console.log(resp);
          if (resp && resp.status === 200) {
            _this.memberlove = resp.data
            if(resp.data.length<=0){
              this.$alert('所选择的范围没有数据', '分析提示', {
                confirmButtonText: '确定',
              });
            }
          }
          _this.$nextTick(function() {
            _this.drawPie3('allph')
          }) // 延迟调用
        })
      }

      //单单判断省市区街道
      if(age==0 && sex == 0 && province != 0 && city != 0 && area != 0 && town != 0 && road == 0 && myfloor == 0){
        this.$axios.get(`/getPreferenceByPCAT?province=${_this.province}&city=${_this.city}&area=${_this.area}&town=${_this.town}`).then(resp => {
          // console.log(resp);
          if (resp && resp.status === 200) {
            _this.memberlove = resp.data
            if(resp.data.length<=0){
              this.$alert('所选择的范围没有数据', '分析提示', {
                confirmButtonText: '确定',
              });
            }
          }
          _this.$nextTick(function() {
            _this.drawPie3('allph')
          }) // 延迟调用
        })
      }


      //单单判断省市区街道路段
      if(age==0 && sex == 0 && province != 0 && city != 0 && area != 0 && town != 0 && road != 0 && myfloor == 0){
        this.$axios.get(`/getPreferenceByPCATR?province=${_this.province}&city=${_this.city}&area=${_this.area}&town=${_this.town}&road=${_this.road}`).then(resp => {
          // console.log(resp);
          if (resp && resp.status === 200) {
            _this.memberlove = resp.data
            if(resp.data.length<=0){
              this.$alert('所选择的范围没有数据', '分析提示', {
                confirmButtonText: '确定',
              });
            }
          }
          _this.$nextTick(function() {
            _this.drawPie3('allph')
          }) // 延迟调用
        })
      }


      //单单判断省市区街道路段小区
      if(age==0 && sex == 0 && province != 0 && city != 0 && area != 0 && town != 0 && road != 0 && myfloor != 0){
        this.$axios.get(`/getPreferenceByPCATRM?province=${_this.province}&city=${_this.city}&area=${_this.area}&town=${_this.town}&road=${_this.road}&myfloor=${_this.myfloor}`).then(resp => {
          // console.log(resp);
          if (resp && resp.status === 200) {
            _this.memberlove = resp.data
            if(resp.data.length<=0){
              this.$alert('所选择的范围没有数据', '分析提示', {
                confirmButtonText: '确定',
              });
            }
          }
          _this.$nextTick(function() {
            _this.drawPie3('allph')
          }) // 延迟调用
        })
      }



      // -----------------------组合判断--------------------

      //判断age和省
      if(age!=0 && sex == 0 && province != 0 && city == 0 && area == 0 && town == 0 && road == 0 && myfloor == 0){
        let ageArr = eval(_this.age)
        this.$axios.get(`/getPreferenceByAgeAndP?age1=${ageArr[0]}&age2=${ageArr[1]}&province=${_this.province}`).then(resp => {
          if (resp && resp.status === 200) {
            // console.log(resp);
            _this.memberlove = resp.data
            if(resp.data.length<=0){
              this.$alert('所选择的范围没有数据', '分析提示', {
                confirmButtonText: '确定',
              });
            }
          }
          _this.$nextTick(function() {
            _this.drawPie3('allph')
          }) // 延迟调用
        })
      }
      //判断age和省市
      if(age!=0 && sex == 0 && province != 0 && city != 0 && area == 0 && town == 0 && road == 0 && myfloor == 0){
        let ageArr = eval(_this.age)
        this.$axios.get(`/getPreferenceByAgeAndPC?age1=${ageArr[0]}&age2=${ageArr[1]}&province=${_this.province}&city=${_this.city}`).then(resp => {
          if (resp && resp.status === 200) {
            // console.log(resp);
            _this.memberlove = resp.data
            if(resp.data.length<=0){
              this.$alert('所选择的范围没有数据', '分析提示', {
                confirmButtonText: '确定',
              });
            }
          }
          _this.$nextTick(function() {
            _this.drawPie3('allph')
          }) // 延迟调用
        })
      }
      //判断age和省市区
      if(age!=0 && sex == 0 && province != 0 && city != 0 && area != 0 && town == 0 && road == 0 && myfloor == 0){
        let ageArr = eval(_this.age)
        this.$axios.get(`/getPreferenceByAgeAndPCA?age1=${ageArr[0]}&age2=${ageArr[1]}&province=${_this.province}&city=${_this.city}&area=${_this.area}`).then(resp => {
          if (resp && resp.status === 200) {
            // console.log(resp);
            _this.memberlove = resp.data
            if(resp.data.length<=0){
              this.$alert('所选择的范围没有数据', '分析提示', {
                confirmButtonText: '确定',
              });
            }
          }
          _this.$nextTick(function() {
            _this.drawPie3('allph')
          }) // 延迟调用
        })
      }
      //判断age和省市区镇
      if(age!=0 && sex == 0 && province != 0 && city != 0 && area != 0 && town != 0 && road == 0 && myfloor == 0){
        let ageArr = eval(_this.age)
        this.$axios.get(`/getPreferenceByAgeAndPCAT?age1=${ageArr[0]}&age2=${ageArr[1]}&province=${_this.province}&city=${_this.city}&area=${_this.town}`).then(resp => {
          if (resp && resp.status === 200) {
            // console.log(resp);
            _this.memberlove = resp.data
            if(resp.data.length<=0){
              this.$alert('所选择的范围没有数据', '分析提示', {
                confirmButtonText: '确定',
              });
            }
          }
          _this.$nextTick(function() {
            _this.drawPie3('allph')
          }) // 延迟调用
        })
      }
      //判断age和省市区镇村
      if(age!=0 && sex == 0 && province != 0 && city != 0 && area != 0 && town != 0 && road != 0 && myfloor == 0){
        let ageArr = eval(_this.age)
        this.$axios.get(`/getPreferenceByAgeAndPCATR?age1=${ageArr[0]}&age2=${ageArr[1]}&province=${_this.province}&city=${_this.city}&area=${_this.town}&road=${_this.road}`).then(resp => {
          if (resp && resp.status === 200) {
            // console.log(resp);
            _this.memberlove = resp.data
            if(resp.data.length<=0){
              this.$alert('所选择的范围没有数据', '分析提示', {
                confirmButtonText: '确定',
              });
            }
          }
          _this.$nextTick(function() {
            _this.drawPie3('allph')
          }) // 延迟调用
        })
      }
      //判断age和省市区镇村屯
      if(age!=0 && sex == 0 && province != 0 && city != 0 && area != 0 && town != 0 && road != 0 && myfloor != 0){
        let ageArr = eval(_this.age)
        this.$axios.get(`/getPreferenceByAgeAndPCATRM?age1=${ageArr[0]}&age2=${ageArr[1]}&province=${_this.province}&city=${_this.city}&area=${_this.town}&road=${_this.road}&myfloor=${_this.myfloor}`).then(resp => {
          if (resp && resp.status === 200) {
            // console.log(resp);
            _this.memberlove = resp.data
            if(resp.data.length<=0){
              this.$alert('所选择的范围没有数据', '分析提示', {
                confirmButtonText: '确定',
              });
            }
          }
          _this.$nextTick(function() {
            _this.drawPie3('allph')
          }) // 延迟调用
        })
      }


      // ------------性别加地区--------
      //判断sex和省
      if(age==0 && sex != 0 && province != 0 && city == 0 && area == 0 && town == 0 && road == 0 && myfloor == 0){
        let ageArr = eval(_this.age)
        this.$axios.get(`/getPreferenceBySexAndP?sex=${_this.sex}&province=${_this.province}`).then(resp => {
          if (resp && resp.status === 200) {
            // console.log(resp);
            _this.memberlove = resp.data
            if(resp.data.length<=0){
              this.$alert('所选择的范围没有数据', '分析提示', {
                confirmButtonText: '确定',
              });
            }
          }
          _this.$nextTick(function() {
            _this.drawPie3('allph')
          }) // 延迟调用
        })
      }
      //判断sex和省市
      if(age==0 && sex != 0 && province != 0 && city != 0 && area == 0 && town == 0 && road == 0 && myfloor == 0){
        let ageArr = eval(_this.age)
        this.$axios.get(`/getPreferenceBySexAndPC?sex=${_this.sex}&province=${_this.province}&city=${_this.city}`).then(resp => {
          if (resp && resp.status === 200) {
            // console.log(resp);
            _this.memberlove = resp.data
            if(resp.data.length<=0){
              this.$alert('所选择的范围没有数据', '分析提示', {
                confirmButtonText: '确定',
              });
            }
          }
          _this.$nextTick(function() {
            _this.drawPie3('allph')
          }) // 延迟调用
        })
      }
      //判断sex和省市区
      if(age==0 && sex != 0 && province != 0 && city != 0 && area != 0 && town == 0 && road == 0 && myfloor == 0){
        let ageArr = eval(_this.age)
        this.$axios.get(`/getPreferenceBySexAndPCA?sex=${_this.sex}&province=${_this.province}&city=${_this.city}&area=${_this.area}`).then(resp => {
          if (resp && resp.status === 200) {
            // console.log(resp);
            _this.memberlove = resp.data
            if(resp.data.length<=0){
              this.$alert('所选择的范围没有数据', '分析提示', {
                confirmButtonText: '确定',
              });
            }
          }
          _this.$nextTick(function() {
            _this.drawPie3('allph')
          }) // 延迟调用
        })
      }
      //判断sex和省市区镇
      if(age==0 && sex != 0 && province != 0 && city != 0 && area != 0 && town != 0 && road == 0 && myfloor == 0){
        let ageArr = eval(_this.age)
        this.$axios.get(`/getPreferenceBySexAndPCAT?sex=${_this.sex}&province=${_this.province}&city=${_this.city}&area=${_this.area}&town=${_this.town}`).then(resp => {
          if (resp && resp.status === 200) {
            // console.log(resp);
            _this.memberlove = resp.data
            if(resp.data.length<=0){
              this.$alert('所选择的范围没有数据', '分析提示', {
                confirmButtonText: '确定',
              });
            }
          }
          _this.$nextTick(function() {
            _this.drawPie3('allph')
          }) // 延迟调用
        })
      }
      //判断sex和省市区镇村
      if(age==0 && sex != 0 && province != 0 && city != 0 && area != 0 && town != 0 && road != 0 && myfloor == 0){
        let ageArr = eval(_this.age)
        this.$axios.get(`/getPreferenceBySexAndPCATR?sex=${_this.sex}&province=${_this.province}&city=${_this.city}&area=${_this.area}&town=${_this.town}&road=${_this.road}`).then(resp => {
          if (resp && resp.status === 200) {
            // console.log(resp);
            _this.memberlove = resp.data
            if(resp.data.length<=0){
              this.$alert('所选择的范围没有数据', '分析提示', {
                confirmButtonText: '确定',
              });
            }
          }
          _this.$nextTick(function() {
            _this.drawPie3('allph')
          }) // 延迟调用
        })
      }
      //判断sex和省市区镇村屯
      if(age==0 && sex != 0 && province != 0 && city != 0 && area != 0 && town != 0 && road != 0 && myfloor != 0){
        let ageArr = eval(_this.age)
        this.$axios.get(`/getPreferenceBySexAndPCATRM?sex=${_this.sex}&province=${_this.province}&city=${_this.city}&area=${_this.area}&town=${_this.town}&road=${_this.road}&myfloor=${_this.myfloor}`).then(resp => {
          if (resp && resp.status === 200) {
            // console.log(resp);
            _this.memberlove = resp.data
            if(resp.data.length<=0){
              this.$alert('所选择的范围没有数据', '分析提示', {
                confirmButtonText: '确定',
              });
            }
          }
          _this.$nextTick(function() {
            _this.drawPie3('allph')
          }) // 延迟调用
        })
      }


      // ------------性别年龄加地区--------

      //判断sexage和省
      if(age!=0 && sex != 0 && province != 0 && city == 0 && area == 0 && town == 0 && road == 0 && myfloor == 0){
        let ageArr = eval(_this.age)
        this.$axios.get(`/getPreferenceBySexAndAgeAndP?sex=${_this.sex}&age1=${ageArr[0]}&age2=${ageArr[1]}&province=${_this.province}`).then(resp => {
          if (resp && resp.status === 200) {
            // console.log(resp);
            _this.memberlove = resp.data
            if(resp.data.length<=0){
              this.$alert('所选择的范围没有数据', '分析提示', {
                confirmButtonText: '确定',
              });
            }
          }
          _this.$nextTick(function() {
            _this.drawPie3('allph')
          }) // 延迟调用
        })
      }
      //判断sexage和省市
      if(age!=0 && sex != 0 && province != 0 && city != 0 && area == 0 && town == 0 && road == 0 && myfloor == 0){
        let ageArr = eval(_this.age)
        this.$axios.get(`/getPreferenceBySexAndAgeAndPC?sex=${_this.sex}&age1=${ageArr[0]}&age2=${ageArr[1]}&province=${_this.province}&city=${_this.city}`).then(resp => {
          if (resp && resp.status === 200) {
            // console.log(resp);
            _this.memberlove = resp.data
            if(resp.data.length<=0){
              this.$alert('所选择的范围没有数据', '分析提示', {
                confirmButtonText: '确定',
              });
            }
          }
          _this.$nextTick(function() {
            _this.drawPie3('allph')
          }) // 延迟调用
        })
      }
      //判断sexage和省市区
      if(age!=0 && sex != 0 && province != 0 && city != 0 && area != 0 && town == 0 && road == 0 && myfloor == 0){
        let ageArr = eval(_this.age)
        this.$axios.get(`/getPreferenceBySexAndAgeAndPCA?sex=${_this.sex}&age1=${ageArr[0]}&age2=${ageArr[1]}&province=${_this.province}&city=${_this.city}&area=${_this.area}`).then(resp => {
          if (resp && resp.status === 200) {
            // console.log(resp);
            _this.memberlove = resp.data
            if(resp.data.length<=0){
              this.$alert('所选择的范围没有数据', '分析提示', {
                confirmButtonText: '确定',
              });
            }
          }
          _this.$nextTick(function() {
            _this.drawPie3('allph')
          }) // 延迟调用
        })
      }
      //判断sexage和省市区镇
      if(age!=0 && sex != 0 && province != 0 && city != 0 && area != 0 && town != 0 && road == 0 && myfloor == 0){
        let ageArr = eval(_this.age)
        this.$axios.get(`/getPreferenceBySexAndAgeAndPCAT?sex=${_this.sex}&age1=${ageArr[0]}&age2=${ageArr[1]}&province=${_this.province}&city=${_this.city}&area=${_this.area}&town=${_this.town}`).then(resp => {
          if (resp && resp.status === 200) {
            // console.log(resp);
            _this.memberlove = resp.data
            if(resp.data.length<=0){
              this.$alert('所选择的范围没有数据', '分析提示', {
                confirmButtonText: '确定',
              });
            }
          }
          _this.$nextTick(function() {
            _this.drawPie3('allph')
          }) // 延迟调用
        })
      }
      //判断sexage和省市区镇村
      if(age!=0 && sex != 0 && province != 0 && city != 0 && area != 0 && town != 0 && road != 0 && myfloor == 0){
        let ageArr = eval(_this.age)
        this.$axios.get(`/getPreferenceBySexAndAgeAndPCATR?sex=${_this.sex}&age1=${ageArr[0]}&age2=${ageArr[1]}&province=${_this.province}&city=${_this.city}&area=${_this.area}&town=${_this.town}&road=${_this.road}`).then(resp => {
          if (resp && resp.status === 200) {
            // console.log(resp);
            _this.memberlove = resp.data
            if(resp.data.length<=0){
              this.$alert('所选择的范围没有数据', '分析提示', {
                confirmButtonText: '确定',
              });
            }
          }
          _this.$nextTick(function() {
            _this.drawPie3('allph')
          }) // 延迟调用
        })
      }
      //判断sexage和省市区镇村屯
      if(age!=0 && sex != 0 && province != 0 && city != 0 && area != 0 && town != 0 && road != 0 && myfloor != 0){
        let ageArr = eval(_this.age)
        this.$axios.get(`/getPreferenceBySexAndAgeAndPCATRM?sex=${_this.sex}&age1=${ageArr[0]}&age2=${ageArr[1]}&province=${_this.province}&city=${_this.city}&area=${_this.area}&town=${_this.town}&road=${_this.road}&myfloor=${_this.myfloor}`).then(resp => {
          if (resp && resp.status === 200) {
            // console.log(resp);
            _this.memberlove = resp.data
            if(resp.data.length<=0){
              this.$alert('所选择的范围没有数据', '分析提示', {
                confirmButtonText: '确定',
              });
            }
          }
          _this.$nextTick(function() {
            _this.drawPie3('allph')
          }) // 延迟调用
        })
      }

      //判断sex age
      if(age!=0 && sex != 0 && province == 0 && city == 0 && area == 0 && town == 0 && road == 0 && myfloor == 0){
        let ageArr = eval(_this.age)
        this.$axios.get(`/getPreferenceBySexAndAge?sex=${_this.sex}&age1=${ageArr[0]}&age2=${ageArr[1]}`).then(resp => {
          if (resp && resp.status === 200) {
            // console.log(resp);
            _this.memberlove = resp.data
            if(resp.data.length<=0){
              this.$alert('所选择的范围没有数据', '分析提示', {
                confirmButtonText: '确定',
              });
            }
          }
          _this.$nextTick(function() {
            _this.drawPie3('allph')
          }) // 延迟调用
        })
      }

      //全为空
      if(age==0 && sex == 0 && province == 0 && city == 0 && area == 0 && town == 0 && road == 0 && myfloor == 0){
        this.back()
      }
    },



    

    // 返回所有
    back(){
      let _this = this
      this.age = ''
      this.sex = ''
      this.province = ''
      this.city = ''
      this.area = ''
      this.town = ''
      this.road = ''
      this.myfloor = ''
      this.allCity=[]
      this.allArea=[]
      this.allTown=[]
      this.allRoad=[]
      this.allMyfloor=[]
      this.$axios.get(`/allPianhao`).then(resp => {
        if (resp && resp.status === 200) {
          _this.memberlove = resp.data
          if(resp.data.length<=0){
              this.$alert('所选择的范围没有数据', '分析提示', {
                confirmButtonText: '确定',
              });
            }
          _this.$nextTick(function() {
            _this.drawPie3('allph')
          })  
        }
      }) 
    },

    selectAge(age){
      // console.log(this.age);
      
    },
    selectSex(sex){
      // console.log(sex);
    },
    selectProvince(province){
      this.city = ''
      this.area = ''
      this.town = ''
      this.road = ''
      this.myfloor = ''
      this.allCity=[]
      this.allArea=[]
      this.allTown=[]
      this.allRoad=[]
      this.allMyfloor=[]
      // console.log(province);
      //根据订单省份获取订单出现的城市
      this.$axios.get(`/getAllCity?province=${this.province}`).then(resp => {
        if (resp && resp.status === 200) {
          this.allCity = resp.data
        }
      })
    },
    selectCity(city){
      let _this = this
      this.area = ''
      this.town = ''
      this.road = ''
      this.myfloor = ''
      // console.log(this.city);
      if(this.city == null){
        this.$message('请先输入省份')
        this.allArea=[]
        this.allTown=[]
        this.allRoad=[]
        this.allMyfloor=[]
        
      }else{
        this.$axios.get(`/getAllArea?province=${_this.province}&city=${_this.city}`).then(resp => {
          if (resp && resp.status === 200) {
            _this.allArea = resp.data
          }
        })
      }
    },
    selectArea(area){
      let _this = this
      this.town = ''
      this.road = ''
      this.myfloor = ''
      if(this.area == null){
        this.$message('请先输入城市')
        this.allTown=[]
        this.allRoad=[]
        this.allMyfloor=[]
      }else{
        this.$axios.get(`/getAllTown?province=${_this.province}&city=${_this.city}&area=${_this.area}`).then(resp => {
          if (resp && resp.status === 200) {
            this.allTown = resp.data
          }
        })
      }
    },
    selectTown(town){
      this.road = ''
      this.myfloor = ''
      let _this = this
      // console.log(town);
      
      if(this.town == null){
        this.$message('请先输入辖区')
        this.allRoad=[]
        this.allMyfloor=[]
      }else{
        this.$axios.get(`/getAllRoad?province=${_this.province}&city=${_this.city}&area=${_this.area}&town=${_this.town}`).then(resp => {
          if (resp && resp.status === 200) {
            this.allRoad = resp.data
          }
        })
      }
    },
    selectRoad(road){
      this.myfloor = ''
      let _this = this
      if(this.road == null){
         this.$message('请先输入街道（镇）')
        this.allMyfloor=[]
        
      }else{
        this.$axios.get(`/getAllMyfloor?province=${_this.province}&city=${_this.city}&area=${_this.area}&town=${_this.town}&road=${_this.road}`).then(resp => {
          if (resp && resp.status === 200) {
            this.allMyfloor = resp.data
          }
        })
      }
    },
    selectMyfloor(myfloor){
      let _this = this
       if(this.road == null){
        this.$message('请先输入大道（村）')
        this.allMyfloor=[]
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
            radius: '40%',
            roseType: 'angle',
            center: ['20%', '60%'],
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
            radius: '40%',
            roseType: 'angle',
            center: ['50%', '60%'],
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
            name: '总产生消费额',
            type: 'pie',
            radius: '40%',
            roseType: 'angle',
            center: ['80%', '60%'],
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