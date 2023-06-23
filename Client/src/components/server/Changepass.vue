<template>
  <el-row style="text-align: center">
    <el-col>
      <el-form :model="form" label-width="120px" style="display: inline-block;margin-top:50px;">
        <el-form-item label="账号">
          <el-input v-model="form.name" disabled style="width:290px" />
        </el-form-item>
        <el-form-item label="旧密码">
          <el-input v-model="form.pass" show-password style="width:290px" />
          <label>{{ mima }}</label>
        </el-form-item>
        <el-form-item label="新密码">
          <el-input v-model="form.password" show-password style="width:290px" />
        </el-form-item>
        <el-form-item label="再次输入">
          <el-input v-model="form.repassword" show-password style="width:290px" />
          <label>{{ remima }}</label>
        </el-form-item>
        <el-form-item style="margin-top: 59px;">
          <el-button key="plain" type="" @click="confirm()">确认</el-button>
          <el-button key="plain" type="" style="margin-left:160px">取消</el-button>
        </el-form-item>
      </el-form>
    </el-col>
  </el-row>
</template>
<script>
import { reactive } from 'vue'
import axios from 'axios'
import { ElMessage } from 'element-plus'
import router from '@/router'
export default {
  data() {
    return {
      form: reactive({
        name: '',
        pass: '',
        password: '',
        repassword: ''

      }), remima: ''
    }
  },
  methods: {
    confirm() {
      var rules = JSON.parse(localStorage.getItem('usersinfo')).roule
      if (this.form.password != this.form.repassword) {
        this.remima = '前后密码不一致'
      }
      else {
        this.remima = ''
        if (rules != 3) {
          axios.get('/api/admin/loginadmin', {
            params: {
              uname: this.form.name,
              password: this.form.pass
            }
          }).then(res => {
            if (res.data.code == 200) {
              axios.put('/api/admin/changeadminpass', {
                params: {
                  number: this.form.name,
                  password: this.form.password
                }
              }).then(res => {
                if (res.data.code == 200) {
                  ElMessage({
                    showClose: true,
                    message: '修改成功',
                    type: 'success',
                  })
                  localStorage.clear();
                  router.push({ name: 'login' })
                }
                else {
                  ElMessage({
                    showClose: true,
                    message: '修改失败',
                    type: 'error',
                  })
                }
              })
            }
            else {
              ElMessage({
                showClose: true,
                message: '原密码错误',
                type: 'error',
              })
            }
          })

        }
        else {
          axios.get('/api/admin/loginUser', {
            params: {
              uname: this.form.name,
              password: this.form.pass
            }
          }).then(res => {
            if (res.data.code == 200) {
              axios.put('/api/admin/changeuserpass', {
                params: {
                  userpassword: this.form.password,
                  username: this.form.name
                }
              }).then(res => {
                if (res.data.code == 200) {
                  ElMessage({
                    showClose: true,
                    message: '修改成功',
                    type: 'success',
                  })
                  localStorage.clear();
                  router.push({ name: 'login' })
                }
                else {
                  ElMessage({
                    showClose: true,
                    message: '修改失败',
                    type: 'error',
                  })
                }
              })
            }
            else {
              ElMessage({
                showClose: true,
                message: '原密码错误',
                type: 'error',
              })
            }
          })
        }
      }

    }
  },
  mounted() {
    this.form.name = JSON.parse(localStorage.getItem('usersinfo')).uid
  }

}
</script>