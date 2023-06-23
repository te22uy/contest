<template>
  
    <div class="hollow">竞赛列表</div>
    <div class="select-label">
    <el-row :gutter="20">
      <el-col :span="6"><div class="grid-content ep-bg-purple" /><b>竞赛类别</b></el-col>
      <el-col :span="3" v-for="category1 in categorydata" :key="category1.index" ><div class="grid-content ep-bg-purple" /><span @click="addLabel('category',category1.index)" :class="{'active':activeLabel.category==category1.index}">{{ category1.index }}</span></el-col>
    </el-row>
  
    <el-row :gutter="20">
      <el-col :span="6"><div class="grid-content ep-bg-purple" /><b>竞赛时间</b></el-col>
      <el-col :span="4"><div class="grid-content ep-bg-purple" /><span @click="addLabel('outdated','0')" :class="{'active':activeLabel.outdated=='0'}">未开始</span></el-col>
      <el-col :span="4"><div class="grid-content ep-bg-purple" /><span @click="addLabel('outdated','1')" :class="{'active':activeLabel.outdated=='1'}">正在进行</span></el-col>
      <el-col :span="5"><div class="grid-content ep-bg-purple" /><span @click="addLabel('outdated','2')" :class="{'active':activeLabel.outdated=='2'}">已结束</span></el-col>
    </el-row>
    
    
    <el-row :gutter="20">
      <el-col :span="6"><div class="grid-content ep-bg-purple" /><b>竞赛级别</b></el-col>
      <el-col :span="3" v-for="level1 in leveldata" :key="level1.index" ><div class="grid-content ep-bg-purple" /><span @click="addLabel('level',level1.index)" :class="{'active':activeLabel.level==level1.index}">{{ level1.index }}</span></el-col>
      <!-- <el-col :span="3"><div class="grid-content ep-bg-purple" /><span @click="addLabel('level','非排行榜国赛')" :class="{'active':activeLabel.level=='非排行榜国赛'}">非排行榜国赛</span></el-col>
      <el-col :span="3"><div class="grid-content ep-bg-purple" /><span @click="addLabel('level','省赛')" :class="{'active':activeLabel.level=='省赛'}">省赛</span></el-col>
      <el-col :span="4"><div class="grid-content ep-bg-purple" /><span @click="addLabel('level','区域赛')" :class="{'active':activeLabel.level=='区域赛'}">区域赛</span></el-col> -->
    </el-row>
  </div>
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
   
  </template>
  <script>
  import { ref,reactive,  } from 'vue';
import axios from 'axios';
import { ElMessage } from 'element-plus'
import { objectExpression } from '@babel/types';
export default{
data(){
  return{
	leveldata:[],
	categorydata:[],
    arr:[],
	listarr:[],
	activeLabel:{
		level:'',
		category:'',
		outdated:''
	}
  }
},
computed:{
	currLabelArr(){
		return Object.keys(this.activeLabel).filter(str=>{
			if(this.activeLabel[str]!==''){
				return true
			}
			
		});
	}
},
methods:{
	level(){
		axios.get('/api/admin/level').then(res=>{
			this.leveldata=res.data
		})
	},
	category(){
		axios.get('/api/admin/category').then(res=>{
			this.categorydata=res.data
		})
	},
	addLabel(type,value){
		if(this.activeLabel[type]!=value){
			this.activeLabel[type]=value
		}
		else{
			this.activeLabel[type]=''
		}
		this.filterarr()
	},
	filterarr(){
		this.listarr=this.arr.filter(contest=>{
			return this.currLabelArr.every(item=>{
				return this.activeLabel[item]==contest[item]
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
  axios.get('/api/user/contestrace').then(res=>{
    this.arr=res.data
	this.listarr=res.data
	this.listarr.sort((a, b) => {
        return b.Enddate< a.Enddate? -1 : 1
      })
  }),
  this.level(),
  this.category()
}
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
