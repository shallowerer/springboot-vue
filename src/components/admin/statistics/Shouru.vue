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

    <el-card style="margin: 18px 2%;width: 95%">

      <el-dropdown size="mini" split-button type="primary" style="margin-left:-800px">
      日期范围：年
      <el-dropdown-menu slot="dropdown">
        <el-dropdown-item>黄金糕</el-dropdown-item>
        <el-dropdown-item>狮子头</el-dropdown-item>
        <el-dropdown-item>螺蛳粉</el-dropdown-item>
        <el-dropdown-item>双皮奶</el-dropdown-item>
        <el-dropdown-item>蚵仔煎</el-dropdown-item>
      </el-dropdown-menu>
      
    </el-dropdown>
      <el-dropdown size="mini" split-button type="primary" style="margin-left:15px">
      日期范围：月
      <el-dropdown-menu slot="dropdown">
        <el-dropdown-item v-for="count in 12" v-bind:key="count">{{count}}</el-dropdown-item>

      </el-dropdown-menu>
      
    </el-dropdown>
    

      <div class="el-card__header" >
          <slot name="header">总财务收入趋势</slot>
      </div>
      <div class="el-card__body" >
        <div class="echart-sheet">
        <!--条形图-->
          <div id="allsh" style="width:80%; height: 400px;margin:0 auto"></div>
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

      allShouru:[]
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
          console.log(_this.allShouru);
          
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

  }

}
</script>

<style>

</style>