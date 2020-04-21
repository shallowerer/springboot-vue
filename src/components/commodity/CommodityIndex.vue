<template>
  <el-container>
    <el-aside style="width: 200px;margin-top: 20px">
      <!-- <switch></switch> -->
      <SideMenu @indexSelect="listByCategory" ref="sideMenu"></SideMenu>
    </el-aside>
    <el-main>
      <Commodity class="commodity-area" ref="commodityArea"></Commodity>
    </el-main>
  </el-container>
</template>

<script>

  import SideMenu from './SideMenu'
  import Commodity from './Commodity'

  export default {
    name: 'CommodityIndex',
    data() {
      return{
        
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
        var url = 'categories/' + cid + '/commodities'
        this.$axios.get(url).then(resp => {
          if (resp && resp.status === 200) {
            _this.$refs.commodityArea.currentPage = 1;
            _this.$refs.commodityArea.items = resp.data
          }
        })
        // console.log('listByCategory');
        this.$refs.commodityArea.items = this.items; 
        console.log(this.items);
           
      }
    }
  }
</script>

<style scoped>
  .commodity-area {
    width: 1260px;
    margin-left: auto;
    margin-right: auto;
  }
</style>