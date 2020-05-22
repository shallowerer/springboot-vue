<template>
  <div style="margin-top: 10px">
    <side-menu  id="side-menu"/>
    <div class="home">
      <div id="header-div">
        <div style=""></div>
        <!-- <quick-nav style="float: right;margin-top: -220px;margin-right: 480px"></quick-nav> -->
        <carousel id="carousel"/>
      </div>
      <demeanor id="demeanor"/>
      <information />
      <about-me id="aboutme"/>
    </div>
  </div>
</template>

<script>
import SideMenu from './SideMenu'
import Carousel from './Carousel'
// import QuickNav from './QuickNav'
import Demeanor from './Demeanor'
import Information from './Information'
import AboutMe from './AboutMe'
export default {
 name: 'AppIndex',
 components: {
   SideMenu,
   Carousel,
  //  QuickNav,
  Information,
  Demeanor,
  AboutMe
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
    padding: 0;
    position: relative;
    width: 900px;
    margin:0 auto;
  }

  #header-div {
    position: relative;
    top: 0px;
    left: 0px;
    width: 900px;
    padding-bottom: 20px;
    background-color: #fff;
  }
</style>