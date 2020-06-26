<template>
  <div>
    <el-row style="margin: 18px 0px 0px 18px ">
      <el-breadcrumb separator-class="el-icon-arrow-right">
        <el-breadcrumb-item :to="{ path: '/admin/dashboard' }">管理中心</el-breadcrumb-item>
        <el-breadcrumb-item>店铺管理</el-breadcrumb-item>
        <el-breadcrumb-item>商品管理</el-breadcrumb-item>
      </el-breadcrumb>
    </el-row>
    <edit-form @onSubmit="returnList()" ref="edit"></edit-form>

    <el-row>
    <div style="margin: 20px 0 0 -100px" class="">
      <el-input style="width:250px;margin-right:30px;" v-model="cname" placeholder="商品名称"></el-input>
      <!-- <el-input style="width:250px;margin-right:30px;"  v-model="cno" placeholder="商品编号"></el-input> -->
      <el-input style="width:250px;margin-right:30px;"  v-model="ctime" placeholder="上架日期"></el-input>
      <el-button type="primary" icon="el-icon-search" @click="handleSearch()">模糊搜索</el-button>
      <el-button type="primary" icon="el-icon-tickets" @click="returnList()">返回列表</el-button>
    </div>
    </el-row>

    <el-card style="margin: 18px 2%;width: 95%">
      <el-table
        :data="commodities"
        stripe
        style="width: 100%"
        :max-height="tableHeight">
        <el-table-column
          type="selection"
          width="55">
        </el-table-column>
        <el-table-column type="expand">
          <template slot-scope="props">
            <el-form label-position="left" inline>
              <el-form-item>
                <span>{{ props.row.abs }}</span>
              </el-form-item>
            </el-form>
          </template>
        </el-table-column>
        <el-table-column
          prop="title"
          label="商品名（展开查看摘要）"
          fit>
        </el-table-column>
        <el-table-column
          prop="cno"
          label="商品编号"
          fit>
        </el-table-column>
        <el-table-column
          prop="category.name"
          label="分类"
          fit>
        </el-table-column>
        <el-table-column
          prop="date"
          label="上架日期"
          fit>
        </el-table-column>
        <el-table-column
          prop="sellPrice"
          label="价格"
          fit>
        </el-table-column>
        <el-table-column label="商品图片" fit>
          <template slot-scope="scope">
              <img :src="scope.row.cover" width="50" height="50" class="img"/>
          </template>
        </el-table-column>
        <el-table-column
          fixed="right"
          label="操作"
          fit>
          <template slot-scope="scope">
            <el-button
              @click.native.prevent="editCommodity(scope.row)"
              type="text"
              size="small">
              编辑
            </el-button>
            <el-button
              @click.native.prevent="deleteCommodity(scope.row.id)"
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
  import EditForm from './EditForm'
  export default {
    name: 'CommodityManagement',
    components: {EditForm},
    data () {
      return {
        disabledFlag: false,
          currentPage: 1,   //默认页码为1
          pagesize: 5,  //默认一页显示10条
          totalElements: 0,
          members: [],
          roles: [],
          dialogFormVisible: false,
          commodities: [],

          // 模糊搜索
          cname:'',
          cno:'',
          ctime:''
      }
    },
    mounted () {
      // this.loadCommodities()
      this.listCommodities()
    },
    computed: {
      tableHeight () {
        return window.innerHeight - 320
      }
    },
    methods: {
      // 分页
      handleSizeChange: function (size) {   //一页显示多少条
          this.pagesize = size;
          // console.log(this.pagesize);
          this.listCommodities()
          
      },
      handleCurrentChange: function (currentPage) {  //页码更改方法
        this.currentPage = currentPage;
        // console.log(this.currentPage);
        this.listCommodities()
        
      },
      



      // getImgUrl(serveImgUrl){
      //   if(!serveImgUrl){
      //     serveImgUrl = 'vue.png'
      //   }
      //   let trueUrl = require('@/static/img/carousel/'+ serveImgUrl);
      //   return trueUrl;
      // },
      deleteCommodity (id) {
        this.$confirm('此操作将永久删除该商品, 是否继续?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
            this.$axios
              .post('/admin/content/commodities/delete', {id: id}).then(resp => {
              if (resp && resp.status === 200) {
                this.loadCommodities()
              }
            })
          }
        ).catch(() => {
          this.$message({
            type: 'info',
            message: '已取消删除'
          })
        })
      },
      editCommodity (item) {
        this.$refs.edit.dialogFormVisible = true
        this.$refs.edit.form = {
          id: item.id,
          title: item.title,
          cno: item.cno,
          abs: item.abs,
          cover: item.cover,
          date: item.date,
          sellPrice: item.sellPrice,
          originPrice:item.originPrice,
          category: {
            id: item.category.id.toString(),
            name: item.category.name
          }
        }
        // this.$refs.edit.category = {
        //   id: item.category.id.toString()
        // }
      },
      loadCommodities () {
        var _this = this
        this.$axios.get('/findAllCommodity').then(resp => {
          if (resp && resp.status === 200) {
            _this.commodities = resp.data
          }
        })
      },

      //分页获取数据
      listCommodities () {
        var _this = this
        this.$axios.get(`/paging/${this.currentPage-1}/${this.pagesize}`).then(resp => {
          // console.log(this.currentPage);
          if (resp && resp.status === 200) {
            _this.commodities = resp.data.content
            // console.log(resp.data);
            
            _this.totalElements = resp.data.totalElements
            _this.pagesize = resp.data.size
            // console.log( _this.members); 
          }
        })
      },

      //返回所有数据
      returnList(){
        var _this = this
        _this.cname = ''
        _this.cno = ''
        _this.ctime = ''
        this.disabledFlag = false
        this.$axios.get(`/paging/0/5`).then(resp => {
          // console.log(this.currentPage);
          if (resp && resp.status === 200) {
            _this.resData = resp.data
            _this.commodities = _this.resData.content
            _this.totalElements = _this.resData.totalElements
            _this.pagesize = _this.resData.size
            // console.log( _this.members); 
          }
        })
      },

      // 模糊搜索
       handleSearch(){
        var _this = this
        if(this.cname != null || this.cno != null || this.ctime != null){
          console.log(this.cname, this.cno, this.ctime);
          this.$axios.get(`/commodity/searchInfo?cname=${_this.cname}&cno=${_this.cno}&cdate=${_this.ctime}`).then(resp => {
            if(resp && resp.status === 200 && Number(resp.data) != 0){
              _this.commodities = resp.data
              _this.totalElements = resp.data.length
              _this.pagesize = resp.data.length
              _this.disabledFlag = true

              // console.log(111111,resp.data);
            }else{
              _this.commodities = []
            }
            _this.cname = '',
            _this.cno = '',
            _this.ctime = ''
          })
          // console.log(this.searchInfo.truename);
        }
      },

        

    }
  }
</script>

<style scoped>
</style>
