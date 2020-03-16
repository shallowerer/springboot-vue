<template>
  <div>
    <el-card class="box-card">
      <div style="font-size: 25px;color: rgb(36, 106, 235);white-space: nowrap">女娲科技，享你所想！</div>
      <a href="http://huaxianvwa.com" target="_blank">
        <img src="../../assets/img/icon/icon6.png" alt="" class="git-link">
      </a>
      <a href="http://huaxianvwa.com" target="_blank">
        <img src="../../assets/img/icon/csdn.png" alt="" class="csdn-link">
      </a>
      <a href="http://huaxianvwa.com" target="_blank">
        <img src="../../assets/myimg/icon/csdn1.png" alt="" class="csdn-link">
      </a>
      <a href="http://huaxianvwa.com" target="_blank">
        <img src="../../assets/myimg/icon/zhuye.png" alt="" class="csdn-link">
      </a>
      <a href="http://huaxianvwa.com" target="_blank">
        <img src="../../assets/myimg/icon/wyy.png" alt="" class="csdn-link">
      </a>
    </el-card>
  </div>
</template>

<script>
  export default {
    name: 'AboutMe'
  }
</script>

<style scoped>
  .box-card {
    width: 100%;
    height: 150px;
    background-color: #555;
    text-align: center;
    margin-top: 10px;
  }

  .slogan {
    width: 100%;
  }

  .git-link {
    width: 80px;
    /*position: absolute;*/
    margin-bottom: 2px;
    margin-left: 20px;
  }

  .csdn-link {
    width: 62px;
    /*position: absolute;*/
    margin-bottom: 10px;
    margin-left: 20px;
    margin-right: 20px;
  }
</style>
