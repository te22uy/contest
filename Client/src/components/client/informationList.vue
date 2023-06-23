<template>
  <div class="block">
    <el-timeline>
      <el-timeline-item
        v-for="(activity, index) in listData.arr"
        :key="index"
        color="#0bbd87">
       <div> <p class="left" v-html="activity.time"></p></div>
        <p class="right" v-html="activity.NewsName" @click="haha(activity.id)"></p>
      </el-timeline-item>
    </el-timeline>
  </div>
</template>
<script setup>
import axios from 'axios'
import { ref,reactive, onBeforeMount } from 'vue';
import{useRouter,useRoute} from 'vue-router'
  const route=useRoute()
    const router=useRouter()
    let listData = reactive({
        arr:[]
    })
    onBeforeMount(()=>{
        axios.get('api/user/newslist')
        .then(res=>{
           listData.arr= res.data
           console.log(listData.arr)
        })
    })
    function haha(id){
      router.push({
        path:'/information',
        query:{
          id:id
        }
      })
    }
    
</script>
<style scoped>
   .el-timeline {
      padding-left: 170px;
    }
    .left {
      margin: auto;
            color: #909399;
            position: absolute;
            left: -170px;
            font-size: 13px;
             
          }
   .right{
    cursor: pointer;
   } 
</style>