<template>
    <div style="width:70%;margin: auto;margin-top: 20px;height: 100%;" v-for="arrlist in arr" :key="arrlist.contestId">
        <img :src="arrlist.contestImg" /><div style="float: right;text-align: center"></div>
        <h1 style="text-align: center;clear: both;">{{arrlist.name}} &nbsp;&nbsp;
            <el-button :type="type" size="large" :disabled="disabled" @click="enlists()">{{ label }}
            </el-button>
        </h1>
        <p style="text-align: center;">主办方:{{arrlist.Organizer}}&nbsp;&nbsp;承办方:{{arrlist.undertaker}}&nbsp;&nbsp; </p>
        <div style="text-align: center;"><p>{{arrlist.level}}</p> <p >{{ arrlist.category }}</p></div>
        <p style="text-align: center;">截止时间:{{arrlist.Enddate}}</p>
        <p v-html="arrlist.detail"></p>
    </div>
    
        
</template>
<script>
import axios from 'axios';
import { ElMessage } from 'element-plus';
import { ref } from 'vue';
import router from '@/router';
export default{
    data(){
        return{
            id:this.$route.query.id,
            src:ref(''),
            arr:[],
            label:'',
            type:'',
            disabled:false
        }
    },
    methods:{
        enlists(){
            let userinfo=JSON.parse(localStorage.getItem('usersinfo'))
            if(userinfo==null){
                this.$confirm('请先登录', '提示', {
          confirmButtonText: '返回登录',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
            router.push({name:'login'})
        }).catch(() => {
          return          
        });
            }
            else if(userinfo.roule!=3){
                ElMessage({
    message: '老师或管理员账号不能参赛',
    type: 'warning',
  })
            }
            else{ 
                if(userinfo.grade==null){
                    this.$confirm('请先完善个人信息', '提示', {
          confirmButtonText: '立即完善',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
            router.push({name:'selfinfo'})
        }).catch(() => {
          return          
        });
                }
                else{
                axios.post('/api/user/addusercontest',{
                params:{
                    username:userinfo.uid,
                    name:userinfo.name,
                    contestId:this.arr[0].contestId,
                    contestName:this.arr[0].name,
                    conteststar:this.arr[0].Startdate,
                    contestEnd:this.arr[0].Enddate,
                    contestcategory:this.arr[0].category,
                    Contestlevel:this.arr[0].level,
                }
            }).then(res=>{
                if(res.data.code==200){
                    ElMessage({
    message: '参加成功',
    type: 'success',
  })
                }
                else{
                    ElMessage({
    message: '参赛失败',
    type: 'error',
  })
                }
                this.race();
       this.check()
            })
        }
        }   
        },
        race(){
             axios.get('/api/user/race',{
            params:{
                id:this.id
            }
        }).then(res=>{
            this.arr=res.data
        })
        },
        check(){
            let userinfo=JSON.parse(localStorage.getItem('usersinfo'))
            axios.get('/api/user/checkoverdue',{
                params:{
                    contestId:this.id
                }
            }).then(res=>{
                if(res.data[0].outdated!=1){
                    this.label='已过期'
                    this.type='info'
                    this.disabled=true
                }
                else{
                    axios.get('/api/user/checkattend',{
                        params:{
                            contestId:this.id,
                            name:userinfo.uid,
                        }
                    }).then(res1=>{
                        if(res1.data.code==200){
                    this.label='已报名'
                    this.type='info'
                    this.disabled=true
                        }
                        else if(res1.data.code==404){
                    this.label='立即报名'
                    this.type='success'
                    this.disabled=false
                        }
                    })
                }
            })
        }
    },
    mounted(){
       this.race();
       this.check()
    }
}
</script>
<style scoped>
p{
    white-space: normal;
}
</style>