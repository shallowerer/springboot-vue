<template>
  <div>
    <el-row style="margin: 18px 0px 0px 18px ">
      <el-breadcrumb separator-class="el-icon-arrow-right">
        <el-breadcrumb-item :to="{ path: '/admin/dashboard' }">管理中心</el-breadcrumb-item>
        <el-breadcrumb-item>销售统计</el-breadcrumb-item>
        <el-breadcrumb-item>财务收入</el-breadcrumb-item>
      </el-breadcrumb>
    </el-row>
    <el-card style="margin: 18px 2%;width: 95%">
      历史所有商品总销量为：{{staticData.allSalesvolume}}件&nbsp;&nbsp;&nbsp;历史所有商品总售额为：{{staticData.aLLMoney}}元
    </el-card>
    <!-- <el-card style="margin: 18px 2%;width: 95%">
    <div class="el-card__header" >
        <slot name="header">年度财务收入分析</slot>
    </div>
    <div class="el-card__body" >
      <div class="echart-sheet">
        <div id="main" style="width:80%; height: 400px;margin:0 auto"></div>
      </div>
    </div>
    </el-card> -->
       <!-- <el-select v-model="addBM.storeManagerName" @change="selectGet" filterable style="display:block;" placeholder="请选择门店业务员名称">
        <el-option
         v-for="item in userList"
         :key="item.id"
         :label="item.name"
         :value="item.id">
        </el-option>
       </el-select>  -->
 
    <el-card style="margin: 18px 2%;width: 95%">     
      <div class="el-card__header" >
        <div style="margin-left:-500px;margin-bottom:30px">
          <el-select  @change="selectYear" filterable v-model="year" placeholder="选择年份" style="width:130px;margin-right:30px">
            <el-option value="0" 
              label="所有年份"
            >
              所有年份
            </el-option>
            <el-option v-for="item in yearHaveData" 
              :key="item"
              :label="item"
              :value="item"
            >
            </el-option>
            </el-select>
          <el-select  @change="selectMonth"  v-model="month" filterable placeholder="选择月份" style="width:130px;margin-right:30px">
            <el-option value="0" 
            label="所有年份">
              
              全年
            </el-option>
            <el-option v-for="item in 12" 
              :key="item"
              :label="item"
              :value="item"
            >
            </el-option>
          </el-select>
          <!-- <el-select  @change="selectWeek"  v-model="week" filterable placeholder="选择周" style="width:130px;margin-right:30px">
            <el-option value="0" 
            label="全周">
              全周
            </el-option>
            <el-option v-for="item in 12" 
              :key="item"
              :label="item"
              :value="item"
            >
            </el-option>
          </el-select> -->
          
          <el-button type="primary" @click="getAn" style="float:right" icon="el-icon-search">开始分析</el-button>
          <el-button type="primary" @click="back" style="float:right;margin-right:10px" icon="el-icon-search">返回总趋势</el-button>
        </div>
      
      <slot name="header">财务收入趋势</slot>
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
          <slot name="header">全部商品销售收入分析</slot>
      </div>
      <div class="el-card__body" >
        <div class="echart-sheet">
        <!--条形图-->
          <div id="allsp" style="width:90%; height: 400px;margin:0 auto"></div>
        </div>
      </div>
    </el-card>

    
    <el-card style="margin: 18px 2%;width: 95%">
      <el-table
        :data="all"
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
          prop="cid"
          label="商品id"
          sortable
          fit>
        </el-table-column>
        <el-table-column
          prop="cname"
          label="商品名字"
          fit>
        </el-table-column>

        <el-table-column
          prop="count"
          label="销量"
          sortable
          fit>
        </el-table-column>
        <el-table-column
          prop="proportion"
          label="销售量占比%"
          sortable
          fit>
        </el-table-column>
         <el-table-column
          prop="cmoney"
          label="销售额"
          sortable
          fit>
        </el-table-column>
        <el-table-column
          prop="p"
          label="销售额占比%"
          sortable
          fit>
        </el-table-column>

<!--         
        <el-table-column
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
  // components: {
  //   Bar
  // },
  data(){
    return {
      allData: [],
      twoData: [],
      totalAmount:'',
      staticData:[],
      all:[],

      myBarData:[],

      allShouru:[],

      //下拉框选中的
      year: '',
      month: '',
      week: '',

      //有销售数据的年
      yearHaveData: '',


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
      this.$axios.get(`/amount`).then(resp => {
        if (resp && resp.status === 200) {
          _this.allData = resp.data    
          // console.table( resp.data); 
        }
      })
      this.$axios.get(`/zongxiaoliang`).then(resp => {
        if (resp && resp.status === 200) {
          _this.all = resp.data
          // console.table(resp.data);
          _this.$nextTick(function() {
            _this.drawPie3('allsp')
          })  
        }
      })
      this.$axios.get(`/staticData`).then(resp => {
        if (resp && resp.status === 200) {
          _this.staticData = resp.data
        }
      })

      this.$axios.get(`/allShouru`).then(resp => {
        if (resp && resp.status === 200) {
          _this.allShouru = resp.data
          // console.log(_this.allShouru);
          var arrNum = []
          var temp = _this.allShouru;
          for(var i=0;i<temp.length; i++){
            arrNum.push(temp[i].year);
          }
          _this.yearHaveData = arrNum
          
        }
        _this.$nextTick(function() {
          _this.drawPie2('allsh')
        }) // 延迟调用

        
      })





      // 测试
      // this.$axios.get(`/amount`).then(resp => {
      //   if (resp && resp.status === 200) {
      //     _this.allData = resp.data    
      //     // console.table( resp.data);
      //     // console.log(_this.allData[0].cname);
      //     _this.contrastItem = resp.data.map(x => {return x.cname})
      //     // console.log(_this.contrastItem);
         
      //     for (let i = 0; i < _this.contrastItem.length; i++) {
      //       _this.myBarData[i] = []
      //     }

      //     for (let i = 0; i < _this.contrastItem.length; i++) {
      //         // _this.myBarData[i] = resp.data.map(x => {return parseInt(x.count),parseInt(x.proportion),parseInt(x.cmoney),parseInt(x.p)})
      //         // console.table(obj);

      //         _this.myBarData[0][i] = parseInt(resp.data[i].count)
      //         _this.myBarData[1][i] = parseInt(resp.data[i].proportion)
      //         _this.myBarData[2][i] = parseInt(resp.data[i].cmoney)
      //         _this.myBarData[3][i] = parseInt(resp.data[i].p)
              
      //         // console.log(_this.myBarData[i]);
              
      //     }

      //     _this.$nextTick(function() {
      //       _this.drawPie('main')
      //     }) // 延迟调用
      //   }
      // })  
    },

    selectYear(year){//这个vId也就是value值
      // console.log(year);



    },

    selectMonth(month){
      // console.log(month);
    },
    
    selectWeek(week){
      // console.log(week);
    },

    // 用户输入后开始分析
    getAn(e){
      let _this = this
      let year = this.year
      let month = this.month
      let week =this.week
      // console.log(year,month,week);
      if(year == 0){
        // console.log(555);
        _this.month = ''
        this.$axios.get(`/allShouru`).then(resp => {
          if (resp && resp.status === 200) {
            _this.allShouru = resp.data
          }
          _this.$nextTick(function() {
            _this.drawPie2('allsh')
          }) // 延迟调用

        }) 
      }
      if(year != 0 && month != 0){
        this.$axios.get(`/allShouruOfYearAndMonth?year=${year}&month=${month}`).then(resp => {
          if (resp && resp.status === 200) {
            _this.allShouru = resp.data
            // console.log(resp);        
          }
          if(resp.data.length == 0){
            
          }
          _this.$nextTick(function() {
            _this.drawPie2_2('allsh')
          }) // 延迟调用
        })
      }
      if(year != 0 && month == 0){
        this.$axios.get(`/allShouruByYear?year=${year}`).then(resp => {
          if (resp && resp.status === 200) {
            _this.allShouru = resp.data
            // console.log(resp);        
          }
          if(resp.data.length == 0){
            
          }
          _this.$nextTick(function() {
            _this.drawPie2_1('allsh')
          }) // 延迟调用
        })
      }
      
    },

    // 全部年份趋势
    back(){
      let _this = this
      this.year = ''
      this.month = ''
      this.$axios.get(`/allShouru`).then(resp => {
         if (resp && resp.status === 200) {
          _this.allShouru = resp.data
        }
        _this.$nextTick(function() {
          _this.drawPie2('allsh')
        }) // 延迟调用
      })
    },


        // 第一个测试
    drawPie(id) {
      let _this = this
      this.charts = echarts.init(document.getElementById(id))
      // let dataAll = _this.
      let data1 = [1,1,1,1] // 实发
      let data2 = [3,3,3,3] // 个人
      let data3 = [2,2,2,2] // 个人所得税
      let data4 = [3,3,3,3] // 公司社保
      let data5 = [9,9,9,9] // 福利
      
      this.charts.setOption({
        tooltip: {
          trigger: 'axis',
          show: true,
          axisPointer: {            // 坐标轴指示器，坐标轴触发有效
            type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
          },
        }, // 提示框
        legend: {
          data: ['销量', '销量占比(%)', '销售额', '销售额占比(%)']
          // selectedMode: false // 取消图例点击动态效果
        },
        grid: {
          top: '10%',
          left: '0%',
          right: '0%',
          bottom: '3%',
          containLabel: true
        },
        xAxis: {
          type: 'category',
          data: _this.contrastItem
        },
        yAxis: {
          type: 'value',
          max: function(value) {
            return value.max // 因为统计功能使得最大刻度为原来的两倍,此处让其还原
          }
        },
        series: [
          {
            name: '销量',
            type: 'bar',
            stack: null,
           
            label: {
              normal: {
                formatter: function(params) {
                  if (params.value > 0) {
                    return params.value
                  } else {
                    return ''
                  }
                }, // 为0时不显示
                show: true,
                position: 'insideRight'
              }
            },
            itemStyle: {
            color: '#2661FF'
            },
             barWidth: 20,
            data: _this.myBarData[0]
          },
          {
            name: '销量占比(%)',
            type: 'bar',
            stack: null,
            label: {
              normal: {
                formatter: function(params) {
                  if (params.value > 0) {
                    return params.value
                  } else {
                    return ''
                  }
                }, // 为0时不显示
                show: true,
                position: 'insideRight'
              }
            },
            itemStyle: {
              color: '#DC143C'
            },
            barWidth: 20,
            data: _this.myBarData[1]
          },
          {
            name: '销售额',
            type: 'bar',
            stack: null,
            label: {
              normal: {
                formatter: function(params) {
                  if (params.value > 0) {
                    return params.value
                  } else {
                    return ''
                  }
                }, // 为0时不显示
                show: true,
                position: 'insideRight'
              }
            },
            itemStyle: {
              color: '#99B6FF'
            },
             barWidth: 20,
            data: _this.myBarData[2]
          },
          {
            name: '销售额占比(%)',
            type: 'bar',
            stack: null,
            label: {
              normal: {
                formatter: function(params) {
                  if (params.value > 0) {
                    return params.value
                  } else {
                    return ''
                  }
                }, // 为0时不显示
                show: true,
                position: 'insideRight'
              }
            },
            itemStyle: {
              color: '#FFA722'
            },
            barWidth: 20, // 宽度
            data: _this.myBarData[3]
          }
        ]
      })
    },


    // drawPie2(id) {
    //   let _this = this
    //   this.charts = echarts.init(document.getElementById(id))

    //   this.charts.setOption({
    //     tooltip: {
    //       trigger: 'axis',
    //       show: true,
    //       axisPointer: {            // 坐标轴指示器，坐标轴触发有效
    //         type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
    //       },
    //     }, // 提示框
    //     legend: {
    //       // data: ['销量', '销量占比(%)', '销售额', '销售额占比(%)']
    //       // selectedMode: false // 取消图例点击动态效果
    //     },
    //     grid: {
    //       top: '10%',
    //       left: '0%',
    //       right: '0%',
    //       bottom: '3%',
    //       containLabel: true
    //     },
    //     xAxis: {
    //       type: 'category',
    //       data: (function () {
    //         var arrNum = [];
    //         var temp = _this.allShouru;
    //         for(var i=0;i<temp.length; i++){
    //           arrNum.push(temp[i].year);
    //         }
    //         return arrNum;
    //       })()
    //     },
    //     yAxis: {
    //       type: 'value',
    //       max: function(value) {
    //         return value.max // 因为统计功能使得最大刻度为原来的两倍,此处让其还原
    //       }
    //     },
    //     series: [
    //       {
    //         name: '收入（元）',
    //         type: 'line',
    //         stack: null,
           
    //         label: {
    //           normal: {
    //             formatter: function(params) {
    //               if (params.value > 0) {
    //                 return params.value
    //               } else {
    //                 return ''
    //               }
    //             }, // 为0时不显示
    //             show: true,
    //             position: 'insideRight'
    //           }
    //         },
    //         itemStyle: {
    //         color: '#2661FF'
    //         },
    //         barWidth: 20,
    //         data: (function () {
    //             var arrNum = [];
    //             var temp = _this.allShouru;
    //             for(var i=0;i<temp.length; i++){
    //               arrNum.push(temp[i].total);
    //             }
    //             return arrNum;
    //           })()
    //         },
    //       {
    //         name: '收入',
    //         type: 'bar',
    //         stack: null,
           
    //         label: {
    //           normal: {
    //             formatter: function(params) {
    //               if (params.value > 0) {
    //                 return params.value
    //               } else {
    //                 return ''
    //               }
    //             }, // 为0时不显示
    //             show: true,
    //             position: 'insideRight'
    //           }
    //         },
    //         itemStyle: {
    //         color: '#2661FF'
    //         },
    //         barWidth: 20,
    //         data: (function () {
    //             var arrNum = [];
    //             var temp = _this.allShouru;
    //             for(var i=0;i<temp.length; i++){
    //               arrNum.push(temp[i].total);
    //             }
    //             return arrNum;
    //           })()
    //       }
    //     ]
    //   })
    // },

    drawPie2(id) {
      let _this = this
      this.charts = echarts.init(document.getElementById(id))

      this.charts.setOption({
        tooltip: {
          trigger: 'axis',
          show: true,
          axisPointer: {            // 坐标轴指示器，坐标轴触发有效
            type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
          },
        }, // 提示框
        legend: {
          // data: ['销量', '销量占比(%)', '销售额', '销售额占比(%)']
          // selectedMode: false // 取消图例点击动态效果
        },
        grid: {
          top: '10%',
          left: '0%',
          right: '0%',
          bottom: '3%',
          containLabel: true
        },
        xAxis: {
          type: 'category',
          data: (function () {
            var arrNum = [];
            var temp = _this.allShouru;
            for(var i=0;i<temp.length; i++){
              arrNum.push(temp[i].year);
            }
            return arrNum;
          })()
        },
        yAxis: {
          type: 'value',
          max: function(value) {
            return value.max // 因为统计功能使得最大刻度为原来的两倍,此处让其还原
          }
        },
        series: [
          {
            name: '收入（元）',
            type: 'line',
            stack: null,
           
            label: {
              normal: {
                formatter: function(params) {
                  if (params.value > 0) {
                    return params.value
                  } else {
                    return ''
                  }
                }, // 为0时不显示
                show: true,
                position: 'insideRight'
              }
            },
            itemStyle: {
            color: '#FFA722'
            },
            barWidth: 20,
            data: (function () {
                var arrNum = [];
                var temp = _this.allShouru;
                for(var i=0;i<temp.length; i++){
                  arrNum.push(temp[i].total);
                }
                return arrNum;
              })()
            },
          {
            name: '收入',
            type: 'bar',
            stack: null,
           
            label: {
              normal: {
                formatter: function(params) {
                  if (params.value > 0) {
                    return params.value
                  } else {
                    return ''
                  }
                }, // 为0时不显示
                show: true,
                position: 'insideRight'
              }
            },
            itemStyle: {
            color: '#2661FF'
            },
            barWidth: 20,
            data: (function () {
                var arrNum = [];
                var temp = _this.allShouru;
                for(var i=0;i<temp.length; i++){
                  arrNum.push(temp[i].total);
                }
                return arrNum;
              })()
          }
        ]
      })
    },

    //按年月查询
    drawPie2_1(id) {
      let _this = this
      this.charts = echarts.init(document.getElementById(id))

      this.charts.setOption({
        tooltip: {
          trigger: 'axis',
          show: true,
          axisPointer: {            // 坐标轴指示器，坐标轴触发有效
            type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
          },
        }, // 提示框
        legend: {
          // data: ['销量', '销量占比(%)', '销售额', '销售额占比(%)']
          // selectedMode: false // 取消图例点击动态效果
        },
        grid: {
          top: '10%',
          left: '0%',
          right: '0%',
          bottom: '3%',
          containLabel: true
        },
        xAxis: {
          type: 'category',
          data: (function () {
            var arrNum = [];
            var temp = _this.allShouru;
            for(var i=0;i<temp.length; i++){
              arrNum.push(temp[i].year+'-'+temp[i].month);
            }
            return arrNum;
          })()
        },
        yAxis: {
          type: 'value',
          max: function(value) {
            return value.max // 因为统计功能使得最大刻度为原来的两倍,此处让其还原
          }
        },
        series: [
          {
            name: '收入（元）',
            type: 'line',
            stack: null,
           
            label: {
              normal: {
                formatter: function(params) {
                  if (params.value > 0) {
                    return params.value
                  } else {
                    return ''
                  }
                }, // 为0时不显示
                show: true,
                position: 'insideRight'
              }
            },
            itemStyle: {
            color: '#FFA722'
            },
            barWidth: 20,
            data: (function () {
                var arrNum = [];
                var temp = _this.allShouru;
                for(var i=0;i<temp.length; i++){
                  arrNum.push(temp[i].total);
                }
                return arrNum;
              })()
            },
          {
            name: '收入',
            type: 'bar',
            stack: null,
           
            label: {
              normal: {
                formatter: function(params) {
                  if (params.value > 0) {
                    return params.value
                  } else {
                    return ''
                  }
                }, // 为0时不显示
                show: true,
                position: 'insideRight'
              }
            },
            itemStyle: {
            color: '#2661FF'
            },
            barWidth: 20,
            data: (function () {
                var arrNum = [];
                var temp = _this.allShouru;
                for(var i=0;i<temp.length; i++){
                  arrNum.push(temp[i].total);
                }
                return arrNum;
              })()
          }
        ]
      })
    },



    //按年月日查询
    drawPie2_2(id) {
      let _this = this
      this.charts = echarts.init(document.getElementById(id))

      this.charts.setOption({
        tooltip: {
          trigger: 'axis',
          show: true,
          axisPointer: {            // 坐标轴指示器，坐标轴触发有效
            type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
          },
        }, // 提示框
        legend: {
          // data: ['销量', '销量占比(%)', '销售额', '销售额占比(%)']
          // selectedMode: false // 取消图例点击动态效果
        },
        grid: {
          top: '10%',
          left: '0%',
          right: '0%',
          bottom: '3%',
          containLabel: true
        },
        xAxis: {
          type: 'category',
          data: (function () {
            var arrNum = [];
            var temp = _this.allShouru;
            for(var i=0;i<temp.length; i++){
              arrNum.push(temp[i].year+'-'+temp[i].month+'-'+temp[i].day);
            }
            return arrNum;
          })()
        },
        yAxis: {
          type: 'value',
          max: function(value) {
            return value.max // 因为统计功能使得最大刻度为原来的两倍,此处让其还原
          }
        },
        series: [
          {
            name: '收入（元）',
            type: 'line',
            stack: null,
           
            label: {
              normal: {
                formatter: function(params) {
                  if (params.value > 0) {
                    return params.value
                  } else {
                    return ''
                  }
                }, // 为0时不显示
                show: true,
                position: 'insideRight'
              }
            },
            itemStyle: {
            color: '#FFA722'
            },
            barWidth: 20,
            data: (function () {
                var arrNum = [];
                var temp = _this.allShouru;
                for(var i=0;i<temp.length; i++){
                  arrNum.push(temp[i].total);
                }
                return arrNum;
              })()
            },
          {
            name: '收入',
            type: 'bar',
            stack: null,
           
            label: {
              normal: {
                formatter: function(params) {
                  if (params.value > 0) {
                    return params.value
                  } else {
                    return ''
                  }
                }, // 为0时不显示
                show: true,
                position: 'insideRight'
              }
            },
            itemStyle: {
            color: '#2661FF'
            },
            barWidth: 20,
            data: (function () {
                var arrNum = [];
                var temp = _this.allShouru;
                for(var i=0;i<temp.length; i++){
                  arrNum.push(temp[i].total);
                }
                return arrNum;
              })()
          }
        ]
      })
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
            name: '销量',
            type: 'pie',
            radius: '45%',
            roseType: 'angle',
            center: ['20%', '60%'],
            data:(function () {
              var arrNum = [];
              var temp = _this.all;
              for(var i=0;i<temp.length; i++){
                if(temp[i].count == 0){
                  continue
                }
                arrNum.push({"value": temp[i].count,"name":temp[i].cname});
                // console.log(arrNum);
                
              }
              return arrNum;
            })()
          },
          {
            name: '销售额',
            type: 'pie',
            radius: '45%',
            roseType: 'angle',
            center: ['80%', '60%'],
            data:(function () {
              var arrNum = [];
              var temp = _this.all;
              for(var i=0;i<temp.length; i++){
                if(temp[i].cmoney == 0){
                  continue
                }
                arrNum.push({"value": temp[i].cmoney,"name":temp[i].cname});
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