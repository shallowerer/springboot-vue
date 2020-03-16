<template>
    <el-menu
      default-active="1"
      style="width: 200px">
      <a href="#header-div">
        <el-menu-item index="1">
          <i class="el-icon-cpu"></i>
          <span slot="title">技术采用</span>
        </el-menu-item>
      </a>
      <a href="#carousel">
        <el-menu-item index="2">
          <i class="el-icon-menu"></i>
          <span slot="title">女娲风采</span>
        </el-menu-item>
      </a>
      <a href="#demeanor">
        <el-menu-item index="3">
          <i class="el-icon-document"></i>
          <span slot="title">热门资讯</span>
        </el-menu-item>
      </a>
      <a href="#aboutme">
        <el-menu-item index="4">
          <i class="el-icon-setting"></i>
          <span slot="title">关于我们</span>
        </el-menu-item>
      </a>
      <a href="#login">
        <el-menu-item index="5">
          <i class="el-icon-user"></i>
          <span slot="title">用户角色</span>
        </el-menu-item>
      </a>
    </el-menu>
</template>

<script>
  export default {

  }
</script>

<style>
  a {
    text-decoration: none;
    color: inherit;
  }
</style>
