<template>
 <el-menu
    class="categories"
    default-active="0"
    @select="handleSelect"
    style="width: 200px">
    <el-menu-item index="0">
      <i class="el-icon-menu"></i>
      <span slot="title">全部</span>
    </el-menu-item>
    <el-menu-item index="1">
      <i class="el-icon-menu"></i>
      <span slot="title">整件装</span>
    </el-menu-item>
    <el-menu-item index="2">
      <i class="el-icon-menu"></i>
      <span slot="title">套装</span>
    </el-menu-item>
    <el-menu-item index="3">
      <i class="el-icon-menu"></i>
      <span slot="title">外套</span>
    </el-menu-item>
    <el-menu-item index="4">
      <i class="el-icon-menu"></i>
      <span slot="title">背心</span>
    </el-menu-item>
    <el-menu-item index="5">
      <i class="el-icon-menu"></i>
      <span slot="title">裙</span>
    </el-menu-item>
    <el-menu-item index="6">
      <i class="el-icon-menu"></i>
      <span slot="title">裤</span>
    </el-menu-item>
        <el-menu-item index="7">
      <i class="el-icon-menu"></i>
      <span slot="title">其他类</span>
    </el-menu-item>
  </el-menu>
</template>

<script>
    export default {
      name: 'SideMenu',
      data () {
        return {
          cid: ''
        }
      },
      methods: {
        // handleOpen (key, keyPath) {
        //   console.log(key, keyPath)
        // },
        handleSelect (key, keyPath) {
          this.cid = key;   
          this.$emit('indexSelect')
        }
      }
    }
</script>

<style scoped>
  .categories {
    position: fixed;
    margin-left: 50%;
    left: -750px;
    top:50%;
    transform:translateY(-50%)
  }
  /* .categories {
    position: fixed;
    top:50%;
    transform:translateY(-50%)
  } */
</style>
