<template>
  <div>
    <el-row style="margin: 18px 0px 0px 18px ">
      <el-breadcrumb separator-class="el-icon-arrow-right">
        <el-breadcrumb-item :to="{ path: '/admin/dashboard' }">管理中心</el-breadcrumb-item>
        <el-breadcrumb-item>销售统计</el-breadcrumb-item>
        <el-breadcrumb-item>销量分析</el-breadcrumb-item>
      </el-breadcrumb>
    </el-row>
    
    <el-card style="margin: 18px 2%;width: 95%">历史所有商品总销量为：{{staticData.allSalesvolume}}件&nbsp;&nbsp;&nbsp;历史所有商品总售额为：{{staticData.aLLMoney}}元</el-card>
    
    
    <!-- <div id="main" style="width: 600px;height: 400px;">dddddddddddddd</div> -->
    <!-- <div style="width: 100%;height: 50%;border:1px solid rgb(180,180,180);top: 0px" id="echartss"></div> -->
    <el-card style="margin: 18px 2%;width: 95%">
      <div class="el-card__header" >
          <slot name="header">销量分析条形图</slot>
      </div>
      <div class="el-card__body" >
        <div class="echart-sheet">
        <!--条形图-->
          <div id="main" style="width:80%; height: 400px;margin:0 auto"></div>
        </div>
      </div>
    </el-card>
    
<!-- 
    <div class="echart-sheet">
     
      <div id="hh" style="width:80%; height: 400px;margin:0 auto"></div>
    </div> -->

    <el-card style="margin: 18px 2%;width: 95%">
      <div class="el-card__header" >
          <slot name="header">销量分析扇形图</slot>
      </div>
      <div class="el-card__body" >
        <div class="echart-sheet">
        <!--扇形-->
          <div id="h3" style="width:80%; height: 400px;margin:0 auto"></div>
        </div>
      </div>
    </el-card>



    
    
    <el-card style="margin: 18px 2%;width: 95%">
      <el-table
        :data="allData"
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
          
          fit>
        </el-table-column>
        <el-table-column
          prop="p"
          label="销售额占比%"
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




      <!-- <div class="About">
        <div class="print_box">
        <div class="input_some">
            <span>输入标题：</span><input
            style       = "width:300px;"
            type        = "text"
            v-model     = "objectData.textTitle"
            placeholder = "请输入标题"
            >
        </div>
        <div class="input_some">
            <span>输入数据描述：</span><input
            style       = "width:300px;"
            type        = "text"
            v-model     = "objectData.nameTitle"
            placeholder = "请输入数据描述,默认为‘数据类型’"
            >
        </div>
        <div class="input_some">
            <div class="text_weight">选择颜色后点击添加按钮</div>
            <span>选择颜色：</span><input
            type        = "color"
            v-model     = "colorData"
            placeholder = "请输入数据描述,默认为‘数据类型’"
            >
            <button @click="addColorClick">addColor</button>
            {{objectData.colorArray}}
        </div>
        <div class="input_some">
            <div class="text_weight">选择颜色后点击添加按钮</div>
            <input
            style       = "width:180px;"
            type        = "text"
            v-model     = "leftData"
            placeholder = "请输入数据"
            >
            <input
            style       = "width:180px;"
            type        = "text"
            v-model     = "rightData"
            placeholder = "请输入数据对应字段"
            >
            <button @click=addDataClick()>addData</button>
            <div>数据为：{{objectData.dataArray}}</div>
            <div>字段为：{{objectData.nameArray}}</div>
        </div>
          <div class="input_some">
              <button @click="clearAll()">清空所有数据</button>
          </div>
        </div> -->
        <!-- <Bar
            class   = "about_bar"
            :get-data = "objectData"
        ></Bar> -->
    </div>



</template>

<script>
import echarts from 'echarts'
import Bar from "./Bar";
export default {
  data(){
    return {
      allData: [],
      twoData: [],
      contrastItem:[],
      totalAmount:'',
      staticData:[],
      all:[],
      myBarData:[],

      // //echarts
      // totalPay: '50000', // 所有金额
      // welfare: '300', // 福利金额
      // realSalary: '600', // 实发薪金
      // personSecurity: '300', // 个人社保公积金
      // companySecurity: '300', // 公司社保公积金
      // incomeTax: '500', // 个人所得税


      // // 简述的barchrat
      // objectData: {
      //   textTitle : "",
      //   nameTitle : "",
      //   nameArray : [],
      //   dataArray : [],
      //   colorArray: []
      // },
      leftData : "",
      rightData: "",
      colorData: "#000000"
      
    }
  },
  components: {
    Bar
  },
  mounted () {
    let _this = this
    this.loadData()
    // 基于准备好的dom，初始化echarts实例

    
  },
  computed: {
     
  },
  methods: {
    loadData(){
      let _this = this
      this.$axios.get(`/amount`).then(resp => {
        if (resp && resp.status === 200) {
          _this.allData = resp.data    
          console.table( resp.data);
          // console.log(_this.allData[0].cname);
          _this.contrastItem = resp.data.map(x => {return x.cname})
          // console.log(_this.contrastItem);
         
          for (let i = 0; i < _this.contrastItem.length; i++) {
            _this.myBarData[i] = []
          }

          for (let i = 0; i < _this.contrastItem.length; i++) {
              // _this.myBarData[i] = resp.data.map(x => {return parseInt(x.count),parseInt(x.proportion),parseInt(x.cmoney),parseInt(x.p)})
              // console.table(obj);

              _this.myBarData[0][i] = parseInt(resp.data[i].count)
              _this.myBarData[1][i] = parseInt(resp.data[i].proportion)
              _this.myBarData[2][i] = parseInt(resp.data[i].cmoney)
              _this.myBarData[3][i] = parseInt(resp.data[i].p)
              
              // console.log(_this.myBarData[i]);
              
          }

          _this.$nextTick(function() {
            _this.drawPie('main')
          }) // 延迟调用
          //  _this.$nextTick(function() {
          //   _this.drawPie2('hh')
          // }) // 延迟调用
           _this.$nextTick(function() {
            _this.drawPie3('h3')
          }) 
          
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
    },


    // //第二个测试
    // addDataClick() {
    //   this.objectData.dataArray.push(this.leftData);
    //   this.objectData.nameArray.push(this.rightData);
    //   },
    //   addColorClick() {
    //   this.objectData.colorArray.push(this.colorData);
    //   },
    //   clearAll() {
    //   for (const key in this.objectData) {
    //     const element = this.objectData[key];
    //     if (typeof element == "string") {
    //     this.objectData[key] = "";
    //     }else if (typeof element == "object") {
    //     this.objectData[key] = [];
    //     }
    //   }
    // },






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
      
      // 总计的计算
      // let dataSum = (function () {
      //   let datas = []
      //   // for (let i = 0; i < data1.length; i++) {
      //   //   datas.push(data1[i] + data2[i] + data3[i] + data4[i] + data5[i])
      //   // }
      //   return datas
      // }())
      // console.log(_this.contrastItem)
      // console.log(_this.myBarData[0])
      
      this.charts.setOption({
        tooltip: {
          trigger: 'axis',
          show: true,
          axisPointer: {            // 坐标轴指示器，坐标轴触发有效
            type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
          },
          // formatter: function (params) {
          //   let relVal = params[0].name
          //   for (let i = 0, l = params.length; i < l; i++) {
          //     if (params[i].value) {
          //       relVal += '<br/>' + params[i].seriesName + ' : ' + params[i].value
          //     }
          //   }
          //   return relVal
          // } // 让为0的值不显示
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
          },
          // {
          //   name: '雨衣',
          //   type: 'bar',
          //   stack: 'sum',
          //   label: {
          //     normal: {
          //       formatter: function(params) {
          //         if (params.value > 0) {
          //           return params.value
          //         } else {
          //           return ''
          //         }
          //       }, // 为0时不显示
          //       show: true,
          //       position: 'insideRight'
          //     }
          //   },
          //   itemStyle: {
          //     color: '#FFCD81'
          //   },
          //   barWidth: 40, // 宽度
          //   data: data5
          // },
          // {
          //   name: '总计',
          //   type: 'bar',
          //   stack: 'sum',
          //   label: {
          //     normal: {
          //       // offset: [0, 0],
          //       show: true,
          //       position: 'insideBottom',
          //       formatter: '{c}',
          //       textStyle: { color: '#333333' }
          //     }
          //   },
          //   itemStyle: {
          //     normal: {
          //       color: 'rgba(128, 128, 128, 0)'
          //     }
          //   },
          //   data: dataSum
          // }
        ]
      })
    },

     drawPie2(id) {
      let _this = this
      this.charts = echarts.init(document.getElementById(id))
      // let dataAll = _this.
      let data1 = [1,1,1,1] // 实发
      let data2 = [3,3,3,3] // 个人
      let data3 = [2,2,2,2] // 个人所得税
      let data4 = [3,3,3,3] // 公司社保
      let data5 = [9,9,9,9] // 福利
      
      // 总计的计算
      // let dataSum = (function () {
      //   let datas = []
      //   // for (let i = 0; i < data1.length; i++) {
      //   //   datas.push(data1[i] + data2[i] + data3[i] + data4[i] + data5[i])
      //   // }
      //   return datas
      // }())
      // console.log(_this.contrastItem)
      // console.log(_this.myBarData[0])
      
      this.charts.setOption({
        tooltip: {
          trigger: 'axis',
          show: true,
          axisPointer: {            // 坐标轴指示器，坐标轴触发有效
            type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
          },
          // formatter: function (params) {
          //   let relVal = params[0].name
          //   for (let i = 0, l = params.length; i < l; i++) {
          //     if (params[i].value) {
          //       relVal += '<br/>' + params[i].seriesName + ' : ' + params[i].value
          //     }
          //   }
          //   return relVal
          // } // 让为0的值不显示
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
            color: '#2661FF'
            },
             barWidth: 20,
            data: _this.myBarData[0]
          },
          {
            name: '销量占比(%)',
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
              color: '#DC143C'
            },
            barWidth: 20,
            data: _this.myBarData[1]
          },
          {
            name: '销售额',
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
              color: '#99B6FF'
            },
             barWidth: 20,
            data: _this.myBarData[2]
          },
          {
            name: '销售额占比(%)',
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
            barWidth: 20, // 宽度
            data: _this.myBarData[3]
          },
        ]
      })
    },


    //  drawPie3(id) {
    //   let _this = this
    //   this.charts = echarts.init(document.getElementById(id))
    //   // let dataAll = _this.
    //   // let data1 = [1,1,1,1] // 实发
    //   // let data2 = [3,3,3,3] // 个人
    //   // let data3 = [2,2,2,2] // 个人所得税
    //   // let data4 = [3,3,3,3] // 公司社保
    //   // let data5 = [9,9,9,9] // 福利
      
    //   // 总计的计算
    //   // let dataSum = (function () {
    //   //   let datas = []
    //   //   // for (let i = 0; i < data1.length; i++) {
    //   //   //   datas.push(data1[i] + data2[i] + data3[i] + data4[i] + data5[i])
    //   //   // }
    //   //   return datas
    //   // }())
    //   // console.log(_this.contrastItem)
    //   // console.log(_this.myBarData[0])
      
    //   this.charts.setOption({
    //     // title: {
    //     //      text: '占比统计',
    //     //      left: 'center',
    //     //      top: 0,
    //     //      textStyle: {
    //     //          color: '#ccc'
    //     //      }
    //     //  },
    //     tooltip: {
    //       trigger: 'item',
    //       show: true,
    //       axisPointer: {            // 坐标轴指示器，坐标轴触发有效
    //         type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
    //       },
    //       // formatter: function (params) {
    //       //   let relVal = params[0].name
    //       //   for (let i = 0, l = params.length; i < l; i++) {
    //       //     if (params[i].value) {
    //       //       relVal += '<br/>' + params[i].seriesName + ' : ' + params[i].value
    //       //     }
    //       //   }
    //       //   return relVal
    //       // } // 让为0的值不显示
    //     }, // 提示框
    //     legend: {
    //       data: ['销量', '销量占比(%)', '销售额', '销售额占比(%)']
    //       // selectedMode: false // 取消图例点击动态效果
    //     },
    //     grid: {
    //       top: '10%',
    //       left: '0%',
    //       right: '0%',
    //       bottom: '3%',
    //       containLabel: true
    //     },
    //     // xAxis: {
    //     //   type: 'category',
    //     //   data: _this.contrastItem
    //     // },
    //     // yAxis: {
    //     //   type: 'value',
    //     //   max: function(value) {
    //     //     return value.max // 因为统计功能使得最大刻度为原来的两倍,此处让其还原
    //     //   }
    //     // },
    //     series: [
    //       {
    //         name: '销量占比',
    //         type: 'pie',
    //         clockwise:'true',
    //         startAngle:'0',
    //         radius : '60%',
    //         center: ['20%', '50%'],
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
    //          barWidth: 20,
    //         // data: 
    //         data:[
    //           {
    //             value:70,
    //             name:'语言',
    //             itemStyle:{
    //               normal:{
    //                 color:'rgb(255,192,0)',
    //                 shadowBlur:'90',
    //                 shadowColor:'rgba(0,0,0,0.8)',
    //                 shadowOffsetY:'30'
    //               }
    //             }
    //           },
    //           {
    //             value:10,
    //             name:'美国科学&社会科学',
    //             itemStyle:{
    //               normal:{
    //                 color:'rgb(1,175,80)'
    //               }
    //             }
    //           },
    //           {
    //             value:30,
    //               name:'美国数学',
    //               itemStyle:{
    //                 normal:{
    //                   color:'rgb(122,48,158)'
    //                 }
    //               }
    //           },
              
    //         ]  
              
    //       // {
    //       //   name: '销量占比(%)',
    //       //   type: 'line',
    //       //   stack: null,
    //       //   label: {
    //       //     normal: {
    //       //       formatter: function(params) {
    //       //         if (params.value > 0) {
    //       //           return params.value
    //       //         } else {
    //       //           return ''
    //       //         }
    //       //       }, // 为0时不显示
    //       //       show: true,
    //       //       position: 'insideRight'
    //       //     }
    //       //   },
    //       //   itemStyle: {
    //       //     color: '#DC143C'
    //       //   },
    //       //   barWidth: 20,
    //       //   data: _this.myBarData[1]
    //       // },
    //       // {
    //       //   name: '销售额',
    //       //   type: 'line',
    //       //   stack: null,
    //       //   label: {
    //       //     normal: {
    //       //       formatter: function(params) {
    //       //         if (params.value > 0) {
    //       //           return params.value
    //       //         } else {
    //       //           return ''
    //       //         }
    //       //       }, // 为0时不显示
    //       //       show: true,
    //       //       position: 'insideRight'
    //       //     }
    //       //   },
    //       //   itemStyle: {
    //       //     color: '#99B6FF'
    //       //   },
    //       //    barWidth: 20,
    //       //   data: _this.myBarData[2]
    //       // },
    //       // {
    //       //   name: '销售额占比(%)',
    //       //   type: 'line',
    //       //   stack: null,
    //       //   label: {
    //       //     normal: {
    //       //       formatter: function(params) {
    //       //         if (params.value > 0) {
    //       //           return params.value
    //       //         } else {
    //       //           return ''
    //       //         }
    //       //       }, // 为0时不显示
    //       //       show: true,
    //       //       position: 'insideRight'
    //       //     }
    //       //   },
    //       //   itemStyle: {
    //       //     color: '#FFA722'
    //       //   },
    //       //   barWidth: 20, // 宽度
    //       //   data: _this.myBarData[3]
    //       },
    //       {
    //         name: '销售额',
    //         type: 'pie',
    //         clockwise:'true',
    //         startAngle:'0',
    //         radius : '60%',
    //         center: ['80%', '50%'],
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
    //          barWidth: 20,
    //         // data: 
    //         data:[
    //           {
    //             value:70,
    //             name:'语言',
    //             itemStyle:{
    //               normal:{
    //                 color:'rgb(255,192,0)',
    //                 shadowBlur:'90',
    //                 shadowColor:'rgba(0,0,0,0.8)',
    //                 shadowOffsetY:'30'
    //               }
    //             }
    //           },
    //           {
    //             value:10,
    //             name:'美国科学&社会科学',
    //             itemStyle:{
    //               normal:{
    //                 color:'rgb(1,175,80)'
    //               }
    //             }
    //           },
    //           {
    //             value:20,
    //               name:'美国数学',
    //               itemStyle:{
    //                 normal:{
    //                   color:'rgb(122,48,158)'
    //                 }
    //               }
    //           },
              
    //         ]  
              
         
    //       },
    //     ]
    //   })
    // },

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
            name: '销售量（件）',
            type: 'pie',
            radius: '55%',
            roseType: 'angle',
            center: ['20%', '50%'],
            data:(function () {
              var arrNum = [];
              var temp = _this.allData;
              for(var i=0;i<temp.length; i++){
                arrNum.push({"value": temp[i].count,"name":temp[i].cname});
                // console.log(arrNum);
                
              }
              return arrNum;
            })()
          },
           {
            name: '销售额（元）',
            type: 'pie',
            radius: '55%',
            roseType: 'angle',
            center: ['75%', '50%'],
            data:(function () {
              var arrNum = [];
              var temp = _this.allData;
              for(var i=0;i<temp.length; i++){
                arrNum.push({"value": temp[i].cmoney,"name":temp[i].cname});
                // console.log(arrNum);
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

<style scoped>
    /* .about_bar {
    width : 100%;
    height: 300px;
    }
    .print_box {
    width  : 90%;
    height : 300px;
    padding: 20px;
    }
    .input_some {
    margin-top: 5px;
    border-top: 1px solid #ccc;
    }
    .text_weight {
    font-size  : 22px;
    font-weight: 800;
    } */
</style>