<template>
  <div class="deme">
    <el-row>
      <el-col :span="6" v-for="(item, index) in items" :key="item.id" :offset="index > 0 ? 3 : 0" >
        <el-card :body-style="{ padding: '10px' }">
          <img :src="item.img" class="image">
          <div style="padding: 14px;">
            <span>{{ item.title }}</span>
            <div class="bottom clearfix">
              <time class="time">{{ item.data }}</time>
              <!-- <el-button type="text" class="button">操作按钮</el-button> -->
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<style>
  .deme {
    background-color: #fff;
    margin-top: 10px;
    width: 900px;
    text-align: left;
    /* margin-left: 30px */
  }

  .time {
    font-size: 10px;
    color: #999;
  }
  
  .bottom {
    margin-top: 12px;
    line-height: 12px;
  }


/* 
  .button {
    padding: 0;
    float: right;
  } */

  .image {
    width: 100%;
    height: 143px;
    display: block;
  }

  .clearfix:before,
  .clearfix:after {
      display: table;
      content: "";
  }
  
  .clearfix:after {
      clear: both
  }
</style>

<script>
export default {
  data() {
    return {
      items: [
        {
          id: 1,
          title: '致力于人类舒适',
          img: require('@/static/img/demeanor/ss.jpg'),
          data: '2025-2035'
        },
        {
          id: 2,
          title: '致力于世界未来',
          img: require('@/static/img/demeanor/cs.jpg'),
          data: '2030-2070'
        },
        {
          id: 3,
          title: '致力于宇宙探索',
          img: require('@/static/img/demeanor/yz.jpg'),
          data: '2070-3000'
        }],
      currentDate: new Date()
    };
  }
}
</script>