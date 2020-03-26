<template>
  <div>
    <!-- elementUI 设计导航按钮 -->
    <el-menu 
      :default-active="path"
      router
      mode="horizontal"
      background-color="white"
      text-color="#222"
      active-text-color="red"
      style="min-width: 1300px"
    >
      <el-menu-item v-for="(item,i) in navList" :key="i" :index="item.name">
          {{ item.navItem }}
      </el-menu-item>
      <span style="position: absolute; padding-top: 20px;right:28%;font-size: 20px;font-weight: bold">
        女娲未来科技-生活大厦
      </span>
      <el-input
        placeholder="快速搜索..."
        prefix-icon="el-icon-search"
        size="medium"
        style="width: 300px;position:absolute;margin-top: 13px;right: 3%"
        v-model="keywords">
      </el-input>
    </el-menu>
  </div>
  
</template>

<script>
export default {
 name: 'NavMenu',
    data () {
      return {
        navList: [
          {name: '/index', navItem: '首页'},
          {name: '/shopindex', navItem: '店铺'},
          {name: '/commodityindex', navItem: '商品'},
          {name: '/shopcart', navItem: '购物车'},
          {name: '/bought', navItem: '购买历史'},
          {name: '/admin/dashboard', navItem: '管理中心'}
        ],
        keywords: '',
        path: ''
      }
    },
    mounted: function () {
    // 获得第一级路由，以设置导航栏高亮,初次进入时，没有此判断会导致首页不亮
    var x = this.$route.path.indexOf('/', 1)
    if (x !== -1) {
      this.path = this.$route.path.substring(0, x)
    } else {
      this.path = this.$route.path
    }
  },
  computed: {
    hoverBackground () {
      return '#ffd04b'
    }
  },
  methods: {
  }
}
</script>

<style>
  a {
    text-decoration: none;
    /* color:rgb(66, 162, 226) */
  }
  span {
    pointer-events: none;
  } 
</style>