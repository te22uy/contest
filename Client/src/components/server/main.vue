<template>
  <el-container>
    <el-header>学科竞赛管理系统</el-header>
    <el-container>
      <el-aside width="200px">
        <el-row>
          <el-col :span="24">
            <el-menu active-text-color="#ffd04b" background-color="#545c64" class="el-menu-vertical-demo"
              default-active="2" text-color="#fff">
              <el-sub-menu index="1">
                <template #title>
                  <el-icon class="el-icon-firstgerenzhongxin"></el-icon>
                  <span>个人中心</span>
                </template>
                <el-menu-item index="1-1" @click="open('Changepass')"><el-icon
                    class="el-icon-firstxiugaimima"></el-icon>修改密码</el-menu-item>
                <el-menu-item index="1-2" @click="open('Personalinfo')"><el-icon
                    class="el-icon-firstgerenxinxi"></el-icon>个人信息</el-menu-item>
              </el-sub-menu>
              <el-sub-menu index="2" v-if="this.log.roule == 1">
                <template #title>
                  <el-icon class="el-icon-firstlaoshiguanli"></el-icon>
                  <span>老师管理</span>
                </template>
                <el-menu-item index="2-1" @click="open('addtech')"><el-icon
                    class="el-icon-firstzhucetianjiahaoyou"></el-icon>添加老师</el-menu-item>
                <el-menu-item index="2-2" @click="open('Changetech')"><el-icon
                    class="el-icon-firsticon_icon_laoshiguanli"></el-icon>老师管理</el-menu-item>
              </el-sub-menu>
              <el-sub-menu index="11" v-if="this.log.roule == 3">
                <template #title>
                  <el-icon class="el-icon-firsticon_icon_xueshengguanli"></el-icon>
                  <span>参赛信息管理</span>
                </template>
                <el-menu-item index="11-2" @click="open('usercontest')"><el-icon
                    class="el-icon-firstxueshengdangan"></el-icon>参赛信息管理</el-menu-item>
              </el-sub-menu>
              <el-sub-menu index="3" v-if="this.log.roule != 3">
                <template #title>
                  <el-icon class="el-icon-firsticon_icon_xueshengguanli"></el-icon>
                  <span>竞赛学生管理</span>
                </template>
                <el-menu-item index="3-2" @click="open('ResetPass')"><el-icon
                    class="el-icon-firstxueshengdangan"></el-icon>学生管理</el-menu-item>
              </el-sub-menu>
              <el-sub-menu index="4" v-if="this.log.roule == 1">
                <template #title>
                  <el-icon class="el-icon-firstzhishijingsai"></el-icon>
                  <span>竞赛管理</span>
                </template>
                <el-menu-item index="4-1" @click="open('addContest')"><el-icon
                    class="el-icon-firsttianjiajihua"></el-icon>添加竞赛信息</el-menu-item>
                <el-menu-item index="4-2" @click="open('LookContest')"><el-icon
                    class="el-icon-firstchakan"></el-icon>查看竞赛信息</el-menu-item>
              </el-sub-menu>
              <el-sub-menu index="9" v-if="this.log.roule==1">
                <template #title>
                  <el-icon class="el-icon-firsticon_icon_xueshengguanli"></el-icon>
                  <span>题库管理</span>
                </template>
                <el-menu-item index="9-2" @click="open('bank')"><el-icon
                    class="el-icon-firstxueshengdangan"></el-icon>添加题库</el-menu-item>
                <el-menu-item index="9-4" @click="open('lookbank')"><el-icon
                    class="el-icon-firstxueshengdangan"></el-icon>查看题库</el-menu-item>
              </el-sub-menu>
              <el-sub-menu index="10" v-if="this.log.roule != 3">
                <template #title>
                  <el-icon class="el-icon-firsticon_icon_xueshengguanli"></el-icon>
                  <span>试题管理</span>
                </template>
                <el-menu-item index="10-2" @click="open('addexam')"><el-icon
                    class="el-icon-firstxueshengdangan"></el-icon>添加试题</el-menu-item>
                <el-menu-item index="10-4" @click="open('lookexam')"><el-icon
                    class="el-icon-firstxueshengdangan"></el-icon>查看试题</el-menu-item>
              </el-sub-menu>
              <el-sub-menu index="5" v-if="this.log.roule != 3">
                <template #title>
                  <el-icon class="el-icon-firstzhishijingsai"></el-icon>
                  <span>竞赛统计</span>
                </template>
                <el-menu-item index="3-1" @click="open('enroll')"><el-icon
                    class="el-icon-firstcz-khdf"></el-icon>总体统计</el-menu-item>
                <el-menu-item index="3-3" @click="open('count')"><el-icon
                    class="el-icon-firstchakan"></el-icon>详细统计</el-menu-item>
              </el-sub-menu>
              <el-sub-menu index="6" v-if="this.log.roule == 1">
                <template #title>
                  <el-icon class="el-icon-firstxinwenguanli"></el-icon>
                  <span>新闻管理</span>
                </template>
                <el-menu-item index="5-1" @click="open('addNews')"><el-icon>
                    <DocumentAdd />
                  </el-icon> 添加新闻</el-menu-item>
                <el-menu-item index="5-2" @click="open('LookNews')"><el-icon>
                    <Management />
                  </el-icon>查看新闻</el-menu-item>
              </el-sub-menu>
              <el-menu-item index="7" @click="open('Homepage')">
                <el-icon class="el-icon-firstfanhui"></el-icon>
                <span>返回前台</span>
              </el-menu-item>
              <el-menu-item index="8" @click="tuichu">
                <el-icon class="el-icon-firstexit-full"></el-icon>
                <span>退出登录</span>
              </el-menu-item>
            </el-menu>
          </el-col>
        </el-row>
      </el-aside>

      <el-main>
        <router-view />
      </el-main>
    </el-container>
  </el-container>
</template>
<script>
import { House, User, Avatar, EditPen, UserFilled, Location, Edit, Document, DocumentAdd, Management } from '@element-plus/icons-vue';
import router from '@/router';
import Cookie from 'js-cookie'
import { ref } from 'vue';
export default {
  data() {
    return {

      log: JSON.parse(localStorage.getItem('usersinfo')),
    }
  },
  methods: {
    open(name) {
      this.$router.push({ name })
    },
    tuichu() {
      localStorage.clear();
      router.push({ name: 'Homepage' })
    }
  },
  components: {
    House, User, Avatar, EditPen, UserFilled, Location, Edit, Document, DocumentAdd, Management
  }
}
</script>
<style scoped>
.el-container {
  height: 100%;
}

.el-header {
  background-color: #B3C0D1;
  color: #333;
  text-align: center;
  line-height: 60px;
}

.el-aside {
  background-color: #545c64;
  color: #333;
  text-align: center;
  line-height: 200px;
}

.el-main {
  background-color: #E9EEF3;
  color: #333;
  line-height: 100px;
}
</style>>
