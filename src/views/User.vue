<template>
  <div>
    <table>
      <tr>
        <td>标号</td>
        <td>名字</td>
        <td>电话</td>
      </tr>
			<tr v-for="(item,index) in users" :key="index">
				<td>{{ item.id }}</td>
				<td>{{ item.username }}</td>
				<td>{{ item.mobile }}</td>
			</tr>
    </table>
  </div>
</template>

<script>
export default {
	name: "User",
	data() {
		return {
			msg:"hello springboot",
			users:[
				{
					sid: 1,
					uid: 1,
					uname: "测试人"
				},
				{
					sid: 1,
					uid: 1,
					uname: "测试人"
				},
				{
					sid: 1,
					uid: 1,
					uname: "测试人"
				}
			]
		}
	},
	created() {
		axios.get('http://localhost:8899/user/findAll/').then((res)=> { // 当不是箭头函数，此时的this为回调
			console.log(res)
			this.users = res.data
		})
	
	}

}
</script>

<style>

</style>