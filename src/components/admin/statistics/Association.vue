<template>
  <div>
    <el-row style="margin: 18px 0px 0px 18px ">
      <el-breadcrumb separator-class="el-icon-arrow-right">
        <el-breadcrumb-item :to="{ path: '/admin/dashboard' }">管理中心</el-breadcrumb-item>
        <el-breadcrumb-item>销售统计</el-breadcrumb-item>
        <el-breadcrumb-item>关联分析</el-breadcrumb-item>
      </el-breadcrumb>
    </el-row>

    <el-card style="margin: 18px 2%;width: 95%">
      <div class="el-card__header" >
        <slot name="header">自定义分析</slot>
      </div>
        <div class="el-card__body" >
        <slot></slot>
        <div>
      输入商品A：
        <el-input
            style="width:200px;margin:0 30px 0 0"
          placeholder="商品A"
          clearable
          maxlength="20"
          v-model="input1">
        </el-input>
        输入商品B：
        <el-input
          style="width:200px;margin:0 30px 0 0"
          placeholder="商品B"
          clearable
          maxlength="20"
          v-model="input2">
        </el-input>
        <el-button @click="handleAnalysis()" type="primary" style="margin:0 10px">开始分析</el-button>
        分析结果：
        <el-input
          style="width:200px;margin:0 10px 0 0"
          disabled
          placeholder="分析结果展示区"
          clearable
          maxlength="20"
          v-model="input3">
        </el-input>
       </div>
      </div>
      
    </el-card>

    <!-- <el-row :gutter="32">
      <el-col :xs="24" :sm="24" :lg="8">
        <div class="chart-wrapper">
          <bar-chart />
        </div>
      </el-col>
    </el-row> -->

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
          prop="item1"
          label="商品1"
          fit>
        </el-table-column>
        <el-table-column
          prop="item2"
          label="商品2"
          fit>
        </el-table-column>
        <!-- <el-table-column
          prop="size"
          label="订单总数"
          fit>
        </el-table-column> -->
         <el-table-column
          prop="count"
          label="频次"
          fit>
        </el-table-column>
        <el-table-column
          prop="p"
          label="关联度"
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
// import BarChart from './admin/components/BarChart'
export default {
  components: {

  },
  data(){
    return {
      input1: '',
      input2: '',
      input3:'',
      allData: [],
      twoData: []
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
      this.$axios.get(`/alllian`).then(resp => {
        if (resp && resp.status === 200) {
          _this.allData = resp.data
          // console.table( _this.allData); 
        }
      })
    },
    handleAnalysis(){
      let _this = this
      this.$axios.post(`/handleAnalysis/${_this.input1}/${_this.input2}`).then(resp => {
        if (resp && resp.status === 200) {
          _this.input3 = resp.data
          // console.table( _this.input3); 
        }
      })
    }
  }

}
</script>

<style scoped>

</style>