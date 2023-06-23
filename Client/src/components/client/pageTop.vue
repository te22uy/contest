<!-- <template>
    <div class="policy-home">
     <div class="policyNav">
      <el-menu :default-active="activeIndex"
              text-color="black"
              active-text-color="red"
              class="el-menu-demo"
              mode="horizontal"
              :router="true"
              :ellipsis="false">
        <el-menu-item>学科竞赛</el-menu-item>
        <div class="flex-grow" />
        <el-menu-item index="/Homepage">首页</el-menu-item>
        <el-menu-item index="/race">竞赛信息列表</el-menu-item>
        <el-menu-item index="/informationList">电子资讯</el-menu-item>
        <el-button round @click="Openlogin" v-if="userInfo==null">登陆</el-button>
        <el-button round @click="Openregister" v-if="userInfo==null">注册</el-button>
        <el-button round @click="Openlogin" v-else-if="userInfo.name==null">游客</el-button>    
    <el-button key="success" type="success" text v-else="userInfo.isLogin" @click="Openlogin">{{ userInfo.name }}</el-button
    >
      </el-menu>
     </div>
     <div class="navContent">
       <router-view></router-view>
     </div>
    </div>
   
  </template>
  <script>
    export default {
      data() {
        return {
          activeIndex: '/Homepage',
          userInfo:JSON.parse(localStorage.getItem('usersinfo'))
        };
      },
      mounted(){
        this.$router.push('/Homepage')
      },
      watch: {
        // 监听路由变化
        '$route.path': {
          handler (routePath) {
            this.initMenuActive(routePath)
          },
          immediate: true
        }
      },
      methods: {
        initMenuActive (routePath) {
          //路由跳转时，标记在导航的哪个选项下对应的路由，css高亮显示
          if (routePath == '/loginPolicy') {
            this.activeIndex = '/Homepage'
          } else if(routePath == '/raceTotals'){
            this.activeIndex = '/race'
          } else if(routePath == '/applyDetail'){
            this.activeIndex = '/applyNews'
          } 
          else if(routePath=='/electronInformation'){
            this.activeIndex='/informationList'
          }
          else if(routePath=='/original'){
            this.activeIndex='/original'
          }
          else {
            this.activeIndex = routePath
          }
        },
        Openlogin(){
          this.$router.push('/login')
        },
        Openregister(){
          this.$router.push('/register')
        }
      }
    }
  </script>
  
  <style scoped>
    /* 导航下页面 */
    .navContent {
      min-height: 800px;
      padding-bottom: 70px;
      background-color: #fff;
    }
    .flex-grow {
  flex-grow: 0.9;
}
.el-menu{
  margin-left: 20px;
  margin-right: 20px;
}
.el-button{
  margin:auto;
}
  </style> -->
  <template>
    
</template>
<script>
import { ArrowRight } from '@element-plus/icons-vue';

import axios from 'axios';
import { ref } from 'vue';
import { ElMessage } from 'element-plus'
import router from '@/router';
export default{
data(){
    
},
methods:{
    qiow(){
        axios.post(
    'https://api.openai.com/v1/chat/completions',
    // '{\n    "model": "gpt-3.5-turbo",\n    "messages": [{"role": "user", "content": "Hello!"}]\n  }',
    {
        'model': 'gpt-3.5-turbo',
        'messages': [
            {
                'role': 'user',
                'content': 'Hello!'
            }
        ]
    },
    {
        headers: {
            'Content-Type': 'application/json',
            'Authorization': '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'
        }
    }
).then(res=>{console.log(res.data)})
    }
},
mounted(){
    this.qiow();
}

 } 
  </script>
