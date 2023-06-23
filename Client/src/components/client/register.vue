<template>
  <div class="login" clearfix>
    <div class="login-wrap">
      <el-row type="flex" justify="center">
        <el-form ref="loginForm" :model="user" :rules="rules" status-icon label-width="80px">
          <h3>注册</h3>
          <hr>
          <el-form-item prop="username" label="用户名">
            <el-input v-model="username" placeholder="请输入用户名" prefix-icon></el-input>
          </el-form-item>
          <el-form-item id="password" prop="password" label="密码">
            <el-input v-model="userpassword" show-password placeholder="请输入密码"></el-input>
          </el-form-item>

          <el-form-item prop="email" label="电子邮箱">
            <el-input type="email" v-model="email" placeholder="请输入电子邮箱" @blur="email_blur()"></el-input>
          </el-form-item>

          <el-form-item prop="smscode" label="验证码">
            <el-input class="msc" v-model="smscode" placeholder="验证码"></el-input>
            <el-button class="ms" type="primary" size=10px @click="emailcode()" :disabled='isdisabled' :class="{codeGeting:isGeting}">{{getcode}}</el-button>
          </el-form-item>
          <el-form-item class="an">
            <el-button style="width:90px"  @click="doregister()">注册</el-button>
            <el-button style="margin-left:80px;width:90px"  @click="doclear()">取消</el-button>
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
export default {
  data() {
    return{
    isdisabled:false,
    username:ref(''),
    userpassword : ref(''),
    smscode:ref(''),
    email:ref(''),
    isGeting:false,
    getcode:'获取验证码',
    count:60,
    }
  },
  methods: {
    
     email_blur(){
      var verify = /^[A-Za-z0-9\u4e00-\u9fa5]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;
                if (!verify.test(this.email)) {
                  ElMessage({
          showClose: true,
          message: '邮箱格式错误, 请重新输入',
          type: 'error'
        }) 
      } 
    },
    doregister() {
      if (!this.username) {
        ElMessage({
          showClose: true,
          message: '请输入账号',
          type: 'error'
        })
      }
      else{
        axios.get('api/admin/check',{
          params:{
            uname: this.username,
            email:this.email,
          }
        }).then(res=>{
          if(res.data.code === 200){
            ElMessage({
              showClose: true,
              message: '账号和邮箱都已被注册，请重新注册或登录',
              type: 'error',
            })
          }
          else if(res.data.code===201){
            ElMessage({
              showClose: true,
              message: '账号已被注册，请登录或找回密码',
              type: 'error',
            })
          }
          else if(res.data.code===202){
            ElMessage({
              showClose: true,
              message: '邮箱已被注册，请登录或找回密码',
              type: 'error',
            })
          }
          else if(res.data.code ===404){
            if (!this.userpassword) {
        ElMessage({
          showClose: true,
          message: '请输入密码',
          type: 'error'
        })
      }
      else if(!this.smscode){
        ElMessage({
          showClose: true,
          message: '请输入验证码',
          type: 'error'
        })
        
      }
      else if(!this.email){
        ElMessage({
          showClose: true,
          message: '请输入邮箱',
          type: 'error'
        }) 
      }
      else {
        axios.post('/api/admin/register', {
          params: {
            mailcode:this.smscode,
            email:this.email,
            uname: this.username,
            password: this.userpassword
          }
        }).then(res => {
          
          if (res.data.code === 200) {
            ElMessage({
              showClose: true,
              message: '注册成功',
              type: 'success',
            })
            router.push({ name:'login' })
          }
          else if (res.data.code === 404) {
            ElMessage({
              showClose: true,
              message: '注册失败,验证码错误或已过期',
              type: 'error'
            })
          }
         })
      }




            
          }
        })
      }
      

    },
    emailcode(){
      
      var verify = /^[A-Za-z0-9\u4e00-\u9fa5]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;
                if (!verify.test(this.email)) {
                  ElMessage({
          showClose: true,
          message: '邮箱格式错误, 请重新输入',
          type: 'error'
        }) 
      } 
      else{
        var countDown=setInterval(() => {
        if(this.count<1){
          this.isGeting=true
          this.isdisabled=false
          this.getcode='获取验证码'
          this.count=6
          clearInterval(countDown)
        }else{
          this.isGeting=true
          this.isdisabled=true
          this.getcode=this.count-- +'s后重发'
        }
      }, 1000);
        axios.get('api/admin/getcode',{
          params:{
            email:this.email,
          }
        }).then(res=>{
          if(res.data.code === 200){
            ElMessage({
              showClose: true,
              message: '验证码发送成功，请注意查看',
              type: 'success',
            })
          }
          else if(res.data.code === 404){
            ElMessage({
              showClose: true,
              message: '验证码发送失败，请检查',
              type: 'error',
            })
          }
          else{
            ElMessage({
              showClose: true,
              message: '系统错误',
              type: 'error',
            })
          }
        })
      }
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

.msc{
  width:65.3%;
}

</style>
