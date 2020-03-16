<template>

  <el-card class="card-carousel">
    <el-carousel :interval="3500" arrow="always" indicator-position="outside">
      <el-carousel-item v-for="item in items" :key="item.id">
        <a :href="item.link" target="_blank">
          <img :src="item.img" alt="无法显示图片" class="carousel_img">
        </a>
        <h3>{{ item.title }}</h3>
      </el-carousel-item>
    </el-carousel>
  </el-card>
</template>

<style>
  .el-carousel__item h3 {
    color: rgb(36, 106, 235);
    font-size: 18px;
    /* line-height: 300px; */
    margin: 0 auto;
    bottom: 25px;
    /* float: left; */
    position: relative;
  }

  .card-carousel {
    /* margin-left: 0px; */
    width: 900px;
    height: 400px;
  }

  /* .el-carousel__item:nth-child(2n) {
    background:  #99a9bf;
  }

  .el-carousel__item:nth-child(2n+1) {
    background: #d3dce6;
  } */

  .carousel_img {
    height: 100%;
    width: 100%;
    text-align: center;
  }
</style>

<script>
  export default {
    name: 'Carousel',
    data: function () {
      return {
        items: [{
          id: 1,
          title: 'How2J.cn - Java 全栈学习网站',
          img: require('@/static/img/carousel/how2j.png'),
          link: 'http://how2j.cn?p=50613'},
        {
          id: 2,
          title: 'Vue.js - 渐进式 JavaScript 框架',
          img: require('@/static/img/carousel/vue.png'),
          link: 'https://cn.vuejs.org/'
        },
        {
          id: 3,
          title: 'element-ui - 网站快速成型工具',
          img: require('@/static/img/carousel/el.png'),
          link: 'http://element-cn.eleme.io/#/zh-CN'
        },
        {
          id: 4,
          title: 'Spring Boot - 致力于在蓬勃发展的快速应用开发领域成为领导者',
          img: require('@/static/img/carousel/springboot.png'),
          link: 'https://spring.io/projects/spring-boot/'
        }]
      }
    }
  }
</script>
