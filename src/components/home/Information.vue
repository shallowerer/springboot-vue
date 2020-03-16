<template>
  <el-card class="box-card">
    <div slot="header" class="clearfix">
      <span style="font-weight: bold;font-size: 20px">热门资讯</span>
      <!--<el-button style="float: right; padding: 3px 0" type="text">修改</el-button>-->
    </div>
    <div class="block">
      <el-timeline>
        <el-timeline-item timestamp="2020/03/15" placement="top">
          <el-card>
            <h4>女娲未来科技公司拥有人——明介正式开始项目的制作</h4>
            <p>明介 提交于 2020/03/15 22:12</p>
          </el-card>
        </el-timeline-item>
        <el-timeline-item timestamp="2020/03/12" placement="top">
          <el-card>
            <h4>决定采用springboot+vue实现一个简单系统</h4>
            <p>明介 提交于 2020/03/12 12:02</p>
          </el-card>
        </el-timeline-item>
        <el-timeline-item timestamp="2020/03/11" placement="top">
          <el-card>
            <h4>女娲未来科技公司拥有人——明介开始构思</h4>
            <p>明介 提交于 2020/03/11 22:10</p>
          </el-card>
        </el-timeline-item>
        <el-timeline-item timestamp="2019/04/06" placement="top">
          <el-card>
            <h4>女娲个人网页正式进行域名解析</h4>
            <p>明介 提交于 2019/04/06 19:51</p>
          </el-card>
        </el-timeline-item>
        <el-timeline-item timestamp="2017/10/25" placement="top">
          <el-card>
            <h4>女娲未来科技域名购买(www.huaxianvwa.com)</h4>
            <p>明介 提交于 2017/10/25 11:52</p>
          </el-card>
        </el-timeline-item>
      </el-timeline>
    </div>
  </el-card>
  
</template>

<script>
export default {

}
</script>

<style>
  .box-card {
    margin-top: 10px;
    width: 900px;
    text-align: left;
  }
</style>