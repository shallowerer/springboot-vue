<template>
  <div>
    <el-row style="margin: 18px 0px 0px 18px ">
      <el-breadcrumb separator-class="el-icon-arrow-right">
        <el-breadcrumb-item :to="{ path: '/admin/dashboard' }">管理中心</el-breadcrumb-item>
        <el-breadcrumb-item>店铺管理</el-breadcrumb-item>
        <el-breadcrumb-item>商品管理</el-breadcrumb-item>
      </el-breadcrumb>
    </el-row>
    <edit-form @onSubmit="loadCommodities()" ref="edit"></edit-form>
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
        commodities: []
      }
    },
    mounted () {
      this.loadCommodities()
    },
    computed: {
      tableHeight () {
        return window.innerHeight - 320
      }
    },
    methods: {
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
      }
    }
  }
</script>

<style scoped>
</style>
