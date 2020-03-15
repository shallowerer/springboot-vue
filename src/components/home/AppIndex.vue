<template>
  <div style="margin-top: 10px">
    <side-menu  id="side-menu"/>
    <div class="home">
      <div id="header-div">
        <div style="height: 150px"></div>
        <carousel />
      </div>
    </div>
  </div>
</template>

<script>
import SideMenu from './SideMenu'
import Carousel from './Carousel'
export default {
 name: 'AppIndex',
 components: {
   SideMenu,
   Carousel
 }
}
</script>

<style>
  
  #side-menu {
    position: fixed;
    margin-left: 50%;
    left: -750px;
    top: 200px;
  }

  .home {
    width: 720px;
    margin-left: auto;
    margin-right: auto;
    margin-top: 20px;
  }

  .header-div {
    padding-bottom: 20px;
    padding-left: 5px;
    background-color: #EEE;
  }
</style>