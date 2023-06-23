<template>
  <div class="login" clearfix>
    <div class="login-wrap">
      <el-row type="flex" justify="center">
        <el-form ref="loginForm" :model="user" :rules="rules" status-icon label-width="80px">
          <h3>登录</h3>
          <hr>
          <el-form-item prop="username" label="用户名">
            <el-input v-model="username" placeholder="请输入用户名" prefix-icon></el-input>
          </el-form-item>
          <el-form-item id="password" prop="password" label="密码">
            <el-input v-model="userpassword" show-password placeholder="请输入密码"></el-input>
          </el-form-item>
          <el-form-item id="password" prop="password" label="权限">
            <el-radio-group v-model="radio">
              <el-radio label="3">用户</el-radio>
              <el-radio label="6">教师或管理员</el-radio>
            </el-radio-group>
          </el-form-item>
          <router-link class="zc" :to="{ name: 'register' }">注册</router-link>
          <router-link class="wangj" :to="{ name: 'forgotPassword' }">忘记密码</router-link>

          <el-form-item class="an">
            <el-button style="width:90px" @click="doLogin()">登陆</el-button>
            <el-button style="margin-left:80px;width:90px" @click="doclear()">取消</el-button>
          </el-form-item>

        </el-form>
      </el-row>
    </div>
  </div>
</template>
<script>
import axios from 'axios';
import { ref } from 'vue';
import { ElMessage } from 'element-plus'
import router from '@/router';
import Cookies from 'js-cookie'
export default {
  name: 'login',
  data() {
    return {
      radio: ref('3'),
      username: ref(''),
      userpassword: ref('')
    }
  },
  methods: {
    doLogin() {
      if (!this.username) {
        ElMessage({
          showClose: true,
          message: '请输入账号',
          type: 'error'
        })
      }
      else if (!this.userpassword) {
        ElMessage({
          showClose: true,
          message: '请输入密码',
          type: 'error'
        })
      }
      else {
        if (this.radio == 3) {
          axios.get('/api/admin/loginUser', {
            params: {
              uname: this.username,
              password: this.userpassword
            }
          }).then(res => {

            if (res.data.code === 200) {
              ElMessage({
                showClose: true,
                message: '登陆成功',
                type: 'success',
              })
              console.log(res.data.result[0])
              let userInfo = {
                isLogin: true,
                manage: true,
                roule: '3',
                name: res.data.result[0].name,
                uid: res.data.result[0].username,
                grade: res.data.result[0].grade
              }
              localStorage.setItem('usersinfo', JSON.stringify(userInfo))
              this.$store.state.userInfo = userInfo
              console.log(localStorage.getItem('usersinfo'))
              let userinfo = JSON.parse(localStorage.getItem('usersinfo'))
              console.log(userinfo)
              router.push({ name: 'main' })
            }
            else if (res.data.code === 404) {
              ElMessage({
                showClose: true,
                message: '用户名或密码错误',
                type: 'error'
              })
            }
          })
        }
        else {
          axios.get('/api/admin/loginadmin', {
            params: {
              uname: this.username,
              password: this.userpassword
            }
          }).then(res => {

            if (res.data.code === 200) {
              ElMessage({
                showClose: true,
                message: '登陆成功',
                type: 'success',
              })
              console.log(res.data.result[0])
              let userInfo = {
                isLogin: true,
                manage: true,
                roule: res.data.result[0].rule,
                name: res.data.result[0].name,
                uid: res.data.result[0].number
              }
              localStorage.setItem('usersinfo', JSON.stringify(userInfo))
              this.$store.state.userInfo = userInfo
              router.push({ name: 'main' })
            }
            else if (res.data.code === 404) {
              ElMessage({
                showClose: true,
                message: '用户名或密码错误',
                type: 'error'
              })
            }
          })
        }
      }

    },
    doclear() {
      router.push({ name: 'Homepage' })
    }
  },
  mounted() {
    let userInfo = JSON.parse(localStorage.getItem('usersinfo'));
    console.log(userInfo)
    if (userInfo === null) {
      return
    }
    if (userInfo.isLogin) {
      ElMessage({
        showClose: true,
        message: '登陆成功',
        type: 'success',
      })
      router.push({ name: 'main' })
    }
  }
}

</script>
<style scoped>
.login {
  width: 100%;
  height: 640px;
  background-size: cover;
  overflow: hidden;
}

.login-wrap {
  background-size: cover;
  width: 400px;
  height: 400px;
  margin: 215px auto;
  overflow: hidden;
  padding-top: 10px;
  line-height: 40px;
}

#password {
  margin-bottom: 5px;
}

h3 {
  color: #0babeab8;
  font-size: 24px;
}

hr {
  background-color: #444;
  margin: 20px auto;
}

a {
  text-decoration: none;
  color: #aaa;
  font-size: 15px;
}

a:hover {
  color: coral;
}

.wangj {
  margin-left: 210px;
}

.zc {
  margin-left: 90px
}
</style>