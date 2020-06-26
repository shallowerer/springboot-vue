<template>
  <div style="text-align: left">
    <el-button class="add-button" type="success" @click="dialogFormVisible = true">添加商品</el-button>
    <el-dialog
      title="添加/修改商品信息"
      :visible.sync="dialogFormVisible"
      @close="clear">
      <el-form v-model="form" style="text-align: left" ref="dataForm">
        <el-form-item label="商品名" :label-width="formLabelWidth" prop="title">
          <el-input v-model="form.title" autocomplete="off" placeholder=""></el-input>
        </el-form-item>
        <el-form-item label="商品编号" :label-width="formLabelWidth" prop="cno">
          <el-input type="number" v-model="form.cno" autocomplete="off" placeholder=""></el-input>
        </el-form-item>
        <el-form-item label="上架日期" :label-width="formLabelWidth" prop="date">
          <el-input v-model="form.date" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="价格" :label-width="formLabelWidth" prop="sellPrice">
          <el-input v-model="form.sellPrice" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="历史价格" :label-width="formLabelWidth" prop="originPrice">
          <el-input v-model="form.originPrice" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="封面" :label-width="formLabelWidth" prop="cover">
          <el-input v-model="form.cover" autocomplete="off" placeholder="图片 URL"></el-input>
          <img-upload @onUpload="uploadImg" ref="imgUpload"></img-upload>
        </el-form-item>
        <el-form-item label="简介" :label-width="formLabelWidth" prop="abs">
          <el-input type="textarea" v-model="form.abs" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="分类" :label-width="formLabelWidth" prop="cid">
        <!-- <el-select v-model="form.category.id" placeholder="请选择分类">
          <el-option label="整件装" value="1"></el-option>
          <el-option label="套装" value="2"></el-option>
          <el-option label="外套" value="3"></el-option>
          <el-option label="背心" value="4"></el-option>
          <el-option label="裙" value="5"></el-option>
          <el-option label="裤" value="6"></el-option>
          <el-option label="其他" value="7"></el-option>
        </el-select> -->
        <el-select v-model="form.category.id" placeholder="请选择分类">
          <template v-for="item in dbCate" >
            <el-option v-if="form.category.id == item.id" selected="selected" :value="item.id" :label="item.name"></el-option>
            <el-option v-else :value="item.id" :label="item.name"></el-option>
          </template>
        </el-select>
        </el-form-item>
        <el-form-item prop="id" style="height: 0">
          <el-input type="hidden" v-model="form.id" autocomplete="off"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="onSubmit">确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
  import ImgUpload from './ImgUpload'
  export default {
    name: 'EditForm',
    components: {ImgUpload},
    data () {
      return {
        dialogFormVisible: false,
        form: {
          category: {
            id: '',
            name: ''
          },
          id: '',
          title: '',
          cno: '',
          abs: '',
          sellPrice: '',
          originPrice: '',
          cover: '',
          date: ''
        },
        dbCate:[],
        formLabelWidth: '120px'
      }
    },
    mounted () {
      // this.loadCommodities()
      this.listCate()
    },
    methods: {
      clear () {
        this.$refs.imgUpload.clear()
        this.form = {
         category: {
            id: '',
            name: ''
          },
          id: '',
          title: '',
          cno: '',
          abs: '',
          sellPrice: '',
          originPrice: '',
          cover: '',
          date: ''
        }
      },
      listCate(){
        let _this = this
        this.$axios
          .get('/cateInfo').then(resp => {
            console.log(resp);
            
            _this.dbCate = resp.data
        })

      },


      onSubmit () {
        this.$axios
          .post('/admin/content/commodities', {
            category: this.form.category,
            id: this.form.id,
            title: this.form.title,
            cno: this.form.cno,
            abs: this.form.abs,
            cover: this.form.cover,
            date: this.form.date,
            sellPrice: this.form.sellPrice,
            originPrice: this.form.originPrice
            
          }).then(resp => {
            if (resp && resp.status === 200) {
              this.dialogFormVisible = false
              this.$emit('onSubmit')
            }
        })
      },
      uploadImg () {
        this.form.cover = this.$refs.imgUpload.url
      }
    }
  }
</script>

<style scoped>
  .add-button {
    margin: 18px 0 0 10px;
  }
</style>
