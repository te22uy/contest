<template>
    <el-steps :active="active" align-center finish-status="success">
      <el-step title="Step 1" />
      <el-step title="Step 2" />
      <el-step title="Step 3" />
    </el-steps>
    <div class="login" clearfix >
    <div class="login-wrap">
      <el-row type="flex" justify="center">
        <el-form ref="loginForm" :model="user" :rules="rules" status-icon label-width="80px" v-if="active==0">
          <h3>忘记密码</h3>
          <hr>
          <el-form-item prop="username" label="用户名">
            <el-input v-model="username" placeholder="请输入用户名" prefix-icon></el-input>
          </el-form-item>

          <el-form-item prop="email" label="电子邮箱">
            <el-input type="email" v-model="email" placeholder="请输入电子邮箱" @blur="email_blur()"></el-input>
          </el-form-item>
        </el-form>
        
        <el-form ref="loginForm" :model="user" :rules="rules" status-icon label-width="80px" v-if="active==1">
          <h3>忘记密码</h3>
          <hr>
          <el-form-item prop="email" label="电子邮箱">
            <el-input type="email" v-model="email" disabled  @blur="email_blur()"></el-input>
          </el-form-item>
          <el-form-item prop="smscode" label="验证码">
            <el-input class="msc" v-model="smscode" placeholder="验证码"></el-input>
            <el-button class="ms" type="primary" size=10px @click="emailcode()" :disabled='isdisabled' :class="{codeGeting:isGeting}">{{getcode}}</el-button>
          </el-form-item>
        </el-form>

        <el-form ref="loginForm" :model="user" :rules="rules" status-icon label-width="80px" v-if="active==2">
          <h3>忘记密码</h3>
          <hr>
          <el-form-item prop="username" label="用户名">
            <el-input v-model="username"  disabled prefix-icon></el-input>
          </el-form-item>
          <el-form-item id="password" prop="password" label="密码">
            <el-input v-model="userpassword" show-password placeholder="请输入新密码"></el-input>
          </el-form-item>
        </el-form>

      </el-row>
  <el-button style="width:90px;margin-left:250px"  @click="next" v-if="isshow">下一步<el-icon><ArrowRight /></el-icon></el-button>
  <el-button style="width:90px;margin-left:250px"  @click="next" v-else>完成<el-icon><ArrowRight /></el-icon></el-button>
  
    </div>
  </div>
  <el-dialog v-model="centerDialogVisible" title="Warning" width="30%" center>
    <span>
      请确定你的身份？
    </span>
    <template #footer>
      <span class="dialog-footer">
        <el-button @click="centerDialogVisible = false,roule=0">用户</el-button>
        <el-button @click="centerDialogVisible = false,roule=1">管理员或老师</el-button>
      </span>
    </template>
  </el-dialog>
  </template>
  <script>
import { ArrowRight } from '@element-plus/icons-vue';

import axios from 'axios';
import { ref } from 'vue';
import { ElMessage } from 'element-plus'
import router from '@/router';
export default{
data(){
    return{
    userpassword:ref(''),
    isdisabled:false,
    username:ref(''),
  active:0,
  isshow:'true',
  smscode:ref(''),
    email:ref(''),
    isGeting:false,
    getcode:'获取验证码',
    count:60, 
    centerDialogVisible:ref(''),
    roule:0
    }
},
methods:{
  next(){
    if(this.roule===0){
    if(this.active==0){
      axios.get('api/admin/check',{
        params:{
            email:this.email,
            uname:this.username
          }
      }).then(res=>{
          if(res.data.code === 200){
            this.active=this.active+1
            
          }
          else{
            ElMessage({
              showClose: true,
              message: '账号和邮箱不匹配，请重新输入',
              type: 'error',
            })
          }
        })
    }
    else if(this.active==1){
      axios.get('api/admin/forgot',{
        params:{
          email:this.email,
          mailcode:this.smscode,
          
        }
      }).then(res=>{
        if(res.data.code==200){
          this.active=this.active+1
          this.isshow=false
        }
        else{
          ElMessage({
              showClose: true,
              message: '验证码错误，请重新输入',
              type: 'error',
            })
        }
      })
    }
    else if(this.active==2){
      axios.put('api/user/reset',{
        params:{
          uname:this.username,
          password:this.userpassword
        }
      }).then(res=>{
        if(res.data.code==200){
          ElMessage({
              showClose: true,
              message: '修改成功',
              type: 'success',
            })
            router.push({name:'login'})
        }
        else{
          ElMessage({
              showClose: true,
              message: '修改密码失败',
              type: 'error',
            })
        }
      })
    }
    }
    else{
      if(this.active==0){
      axios.get('api/user/check',{
        params:{
            email:this.email,
            uname:this.username
          }
      }).then(res=>{
          if(res.data.code === 200){
            this.active=this.active+1
            
          }
          else{
            ElMessage({
              showClose: true,
              message: '账号和邮箱不匹配，请重新输入',
              type: 'error',
            })
          }
        })
    }
    else if(this.active==1){
      axios.get('api/admin/forgot',{
        params:{
          email:this.email,
          mailcode:this.smscode,
          
        }
      }).then(res=>{
        if(res.data.code==200){
          this.active=this.active+1
          this.isshow=false
        }
        else{
          ElMessage({
              showClose: true,
              message: '验证码错误，请重新输入',
              type: 'error',
            })
        }
      })
    }
    else if(this.active==2){
      axios.put('api/admin/reset',{
        params:{
          uname:this.username,
          password:this.userpassword
        }
      }).then(res=>{
        if(res.data.code==200){
          ElMessage({
              showClose: true,
              message: '修改成功',
              type: 'success',
            })
            router.push({name:'login'})
        }
        else{
          ElMessage({
              showClose: true,
              message: '修改密码失败',
              type: 'error',
            })
        }
      })
    }
    }
  },
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

},
components:{
  ArrowRight,
},
mounted(){this.centerDialogVisible=true
}

 } 
  </script>
  <style scoped>
  .login {
    width: 100%;
    height: 220px;
    background-size: cover;
  }
  
  .login-wrap {
    background-size: cover;
    width: 400px;
    height:400px;
    margin: 30px auto;
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
  width:65.3% !important;
}

  </style>
  