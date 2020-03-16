<template>
  <el-container>
    <el-aside style="width: 200px;margin-top: 20px">
      <!-- <switch></switch> -->
      <SideMenu @indexSelect="listByCategory" ref="sideMenu"></SideMenu>
    </el-aside>
    <el-main>
      <commodity class="commodity-area" ref="commodityArea"></commodity>
    </el-main>
  </el-container>
</template>

<script>

  import SideMenu from './SideMenu'
  import Commodity from './Commodity'

  export default {
    name: 'CommodityIndex',
    data() {
      return {
        items:[
          {id:1},
          {id:2},
          {id:3},
          {id:4},
          {id:5},
          {id:6},
          {id:7},
        ]
      }
    },
    components: {
      Commodity,
      SideMenu
    },
    methods: {
      listByCategory () {
        var _this = this
        var cid = this.$refs.sideMenu.cid
        // var url = 'categories/' + cid + '/books'
        // this.$axios.get(url).then(resp => {
        //   if (resp && resp.status === 200) {
        //     _this.$refs.booksArea.books = resp.data
        //   }
        // })
        console.log('listByCategory');
        this.$refs.commodityArea.items = this.items;    
      }
    }
  }
</script>

<style scoped>
  .books-area {
    width: 990px;
    margin-left: auto;
    margin-right: auto;
  }
</style>