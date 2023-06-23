<template>
  <el-descriptions title="基本信息" direction="vertical" column="3" border>
    <el-descriptions-item label="账号" width="33%">{{ Account }}</el-descriptions-item>
    <el-descriptions-item label="姓名" width="33%">{{ name }}</el-descriptions-item>
    <el-descriptions-item :label="lay5" width="33%">{{ content5 }}</el-descriptions-item>
    <el-descriptions-item :label="lay2" width="33%">{{ content2 }}</el-descriptions-item>
    <el-descriptions-item :label="lay4" width="33%">{{ content4 }}</el-descriptions-item>
    <el-descriptions-item :label="lay1" width="33%">{{ content1 }}</el-descriptions-item>
    <el-descriptions-item :label="lay3" width="33%">{{ content3 }}</el-descriptions-item>
    <el-descriptions-item label="邮箱" width="33%">{{ email }}</el-descriptions-item>
    <el-descriptions-item :label="lay6" width="33%">{{ content6 }}</el-descriptions-item>
  </el-descriptions>
  <div style="text-align: center;" v-if="consts"><el-button type="type" size="large" @click="enlists()">修改</el-button>
  </div>
</template>

<script>
import axios from 'axios';
import { ref } from 'vue';
import { Edit, Delete } from '@element-plus/icons-vue';
import { ElMessage } from 'element-plus';
import router from '@/router';
export default {
  data() {
    return {
      Account: ref(''),
      name: ref(''),
      email: ref(''),
      lay1: ref(''), lay2: ref(''), lay3: ref(''), lay4: ref(''), lay5: ref(''), lay6: ref(''), content1: ref(''), content2: ref(''), content3: ref(''),
      content6: ref(''), content5: ref(''), content4: ref(''),
      Edit, Delete,
      consts: false,
      user: JSON.parse(localStorage.getItem('usersinfo'))
    }
  },
  methods: {
    basicInformation() {
      let userInfo = JSON.parse(localStorage.getItem('usersinfo'));
      if (userInfo.roule == 3) {
        this.consts = true
        axios.get('/api/admin/userPersonal', {
          params: {
            username: userInfo.uid
          }
        }).then(res => {
          this.lay1 = '年级'
          this.content1 = res.data[0].grade
          this.lay2 = '就读学校'
          this.content2 = res.data[0].school
          this.lay3 = '专业'
          this.content3 = res.data[0].professional
          this.Account = res.data[0].username
          this.name = res.data[0].name
          this.email = res.data[0].email
          this.lay4 = '系别'
          this.content4 = res.data[0].department
          this.lay5 = '性别'
          this.content5 = res.data[0].sex
          this.lay6 = '地址'
          this.content6 = res.data[0].address
        })
      }//学生
      else {
        axios.get('/api/admin/adminPersonal', {
          params: {
            number: userInfo.uid
          }
        }).then(res => {
          console.log(res.data[0])
          this.lay1 = '职称'
          this.content1 = res.data[0].job_title
          this.lay2 = '就职学校'
          this.content2 = res.data[0].school
          this.lay3 = '专业'
          this.content3 = res.data[0].specialized
          this.lay5 = '性别'
          this.content5 = res.data[0].sex
          this.Account = res.data[0].number
          this.name = res.data[0].name
          this.email = res.data[0].email
          this.lay4 = '出生日期'
          this.content4 = res.data[0].age
          this.lay6 = '电话号码'
          this.content6 = res.data[0].phone
        })
      }
    },
    enlists() {
      router.push({ name: 'selfinfo' })
    }
  },
  mounted() {
    this.basicInformation();
  }
}
</script>

 
