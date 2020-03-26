<template>
  <div>
    
    <el-row style="height: 800px;">
      <!-- <search-bar @onSearch="searchResult" ref="searchBar"></search-bar>
      <view-switch class="switch"></view-switch> -->
      <el-tooltip effect="dark" placement="right"
                  v-for="item in items"
                  :key="item.id">
        <p slot="content" style="font-size: 14px;margin-bottom: 6px;">{{item.title}}</p>
        <!-- <p slot="content" style="font-size: 13px;margin-bottom: 6px">
          <span>{{item.author}}</span> /
          <span>{{item.date}}</span> /
          <span>{{item.press}}</span>
        </p> -->
        <!-- <p slot="content" style="width: 300px" class="abstract">{{item.abs}}</p> -->
        <el-card style="width: 280px;margin-bottom: 20px;height: 233px;float: left;margin-right: 15px" class="commodity"
                 bodyStyle="padding:10px" shadow="hover">
          <div class="cover">
            <img :src="getImgUrl(item.cover)" alt="封面">
          </div>
          <div class="info">
            <div class="title">
              <a href="">{{item.title}}</a>
            </div>
          </div>
          <!-- <div class="author">{{item.author}}</div> -->
        </el-card>
      </el-tooltip>
    </el-row>
    <el-row>
        <el-pagination
          @current-change="loadCommodity"
          :current-page="currentPage"
          :page-size="pagesize"
          :total="total">
        </el-pagination>
    </el-row>
  </div>
  <!-- <div >
    <div v-for="item in items" :key="item.id">{{ item.id }}</div>
  </div> -->
</template>

<script>
  import SearchBar from './SearchBar'
  // import ViewSwitch from './ViewSwitch'

  export default {
    name: 'Commodity',
    components: {
      SearchBar,
      // ViewSwitch
    },
    data () {
      return {
        items: [],
        currentPage: 0,
        pagesize: 10,
        total:10
      }
    },
    mounted() {
      this.loadCommodity()
    },
  
    methods: {
      getImgUrl(serveImgUrl){
        if(!serveImgUrl){
          serveImgUrl = 'vue.png'
        }
        let trueUrl = require('@/static/img/carousel/'+ serveImgUrl);
        return trueUrl;
      },
      loadCommodity(currentPage = 1) {
        var _this = this    
        this.$axios.get('/paging/'+(currentPage-1)+'/12').then(res => {
          if (res && res.status === 200) {
            _this.items = res.data.content;
            _this.pagesize = res.data.size;
            _this.total = res.data.totalElements
          }
        })
      },

      // loadBooks () {
      //   var _this = this
      //   this.$axios.get('/books').then(resp => {
      //     if (resp && resp.status === 200) {
      //       _this.books = resp.data
      //     }
      //   })
      // },
      // handleCurrentChange: function (currentPage) {
      //   console.log(currentPage);
      //   this.currentPage = currentPage
      // },
      // searchResult () {
      //   var _this = this
      //   this.$axios
      //     .get('/search?keywords=' + this.$refs.searchBar.keywords, {
      //     }).then(resp => {
      //     if (resp && resp.status === 200) {
      //       _this.books = resp.data
      //     }
      //   })
      // }
    }
  }
</script>
<style scoped>

  .cover {
    width: 100%;
    height: 172px;
    margin-bottom: 7px;
    overflow: hidden;
    cursor: pointer;
  }

  img {
    width: 100%;
    height: 100%;
    /*margin: 0 auto;*/
  }

  .title {
    font-size: 14px;
    text-align: left;
  }

  .author {
    color: #333;
    width: 102px;
    font-size: 13px;
    margin-bottom: 6px;
    text-align: left;
  }

  .abstract {
    display: block;
    line-height: 17px;
  }

  .el-icon-delete {
    cursor: pointer;
    float: right;
  }

  .switch {
    display: flex;
    position: absolute;
    left: 780px;
    top: 25px;
  }

  a {
    text-decoration: none;
  }

  a:link, a:visited, a:focus {
    color: #3377aa;
  }

</style>
