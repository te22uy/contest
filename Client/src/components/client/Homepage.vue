<template>
    <el-carousel indicator-position="outside" height="500px" style="margin: auto;cursor: pointer;">
      <el-carousel-item v-for="item in arr" :key="item" @click="xiangq(item)">
        <img :src="item.contestImg" style="width: 100%;"> 
      </el-carousel-item>
    </el-carousel>
    <div class="hollow">竞赛列表</div>
    <div class="main container" v-for="arr1 in listarr" :key="arr1.contestId" @click="detail(arr1.contestId)"> 
      <ul class="product_list clearfloat" id="imglist">
				<li >
						<div class="wrap">
							<div class="img-box">
								<img class="imgs" :src="arr1.contestImg" />
							</div>
						</div>
					
					<div class="pdlist_text clearfloat">
						<h3><span>
							<span v-text="arr1.name" id="baom"></span>
							
                <el-tag type="warning" effect="dark" v-if="(arr1.outdated==0)">未开始</el-tag>
            <el-tag type="success" effect="dark" v-if="(arr1.outdated==1)">正在报名</el-tag>
            <el-tag type="danger" effect="dark" v-if="(arr1.outdated==2)">已经结束</el-tag>
              </span>
			
						</h3>
					</div>
				</li>
				</ul>
    </div>
    <div class="hollow">竞赛新闻</div>   
    <el-row align="middle" :gutter="70">
    <el-col :span="10" v-for="(activity, index) in listData.arr" :key="index" style="height:60px">{{ activity.NewsName }}</el-col>
  </el-row>
  </template>
  <script>
  import { ref,reactive,  } from 'vue';
import axios from 'axios';
import { ElMessage } from 'element-plus'
export default{
     data(){
        return{
          listarr:[],
            arr:[],
            listData:reactive({
        arr:[]
    })
        }
     },
     methods:{
      xiangq(item){
        this.$router.push({
        name:'raceDetail',
        query:{
          id:item.contestId
        }
      })
      },
      shuju(){
        axios.get('api/user/newslist')
        .then(res=>{
           this.listData.arr= res.data
        })
      },
      haha(id){
        this.$router.push({
        path:'/information',
        query:{
          id:id
        }
      })
    },
    shuju1(){
      axios.get('/api/user/contestrace').then(res=>{
    this.arr=res.data
	this.listarr=res.data
	this.listarr.sort((a, b) => {
        return b.Enddate< a.Enddate? -1 : 1
      })
  })
    },
    detail(id){
		this.$router.push({
        name:'raceDetail',
        query:{
          id:id
        }
      })
	}
     },
     mounted(){
      this.shuju()
      this.shuju1()
        axios.get('/api/user/contest').then(res=>{
            this.arr=res.data
        })
     },
     
}
</script>
<style scoped>
.grid-content {
  border-radius: 4px;
  min-height: 30px;
}
.hollow{
clear: both;
text-shadow:  0 0 2px hsl(40, 28.57% , 28.82%),0 0 2px hsl(40, 28.57% , 28.82%), 0 0 2px hsl(40, 28.57% , 28.82%);/*多个叠加*/
font-size: 30px; 
color:#fff;
margin-left: 29px;
}
* {
margin: 0;
padding: 0;
}

ul {
list-style-type: none;
font-size: small;
}

a {
text-decoration: none;
}				
      .container {
        margin-top: 50px;
        margin-left: 90px;
      }
      .product_list {
        margin-top: 20px;
        height: auto;
      }
      
      .product_list li {
        float: left;
        margin-right: 40px;
        width: 310px;
        box-sizing: border-box;
        border: 2px solid #ccc;
        margin-bottom: 40px;
      }
      
      .product_list>li>a {
        display: block;
        width: 300px;
        padding: 2px;
        overflow: hidden;
      }
      
      .product_list>li>a>img {
        max-width: 100%;
        transition: all 0.3s;
      }
      #imglist{
        cursor: pointer;
      }
      .pdlist_text {
        border-top: 1px solid #ccc;
        padding: 10px 10px 6px 10px;
      }
      
      .pdlist_text>h3 {
        font-weight: lighter;
      }
      
      .pdlist_text>h3>p {
        font-size: 18px;
      }
      #baom{
        margin-right: 140px;
      }
      .pdlist_text>a:hover {
        background: #f6cd8a;
      }
.wrap{
width: 300px;
height: 180px;
position: relative;
overflow: hidden;
}
.imgs{
width: 300px;
height: 230px;
}
.wrap:hover .drop-box{
top: 0;
left: 0;
}
.select-label{
background: lavender;
padding: 15px 0;
}
.el-col span{
padding: 8px 10px;
color: #333;
margin-left: 20px;
border-radius:4px ;
cursor: pointer;
}
.el-col-6{
margin-left: 20px;
}
span.active{
background: coral;
color:#fff
}
</style>


