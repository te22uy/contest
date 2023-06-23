<template>
  <div>
    <p><i class="el-icon-time"></i> {{ `${hr}: ${min}: ${sec}` }}</p>
  </div>
  <div id="app12">
    <div v-for="(item, index) in question" :key="index" v-show="index == idx" class="question">
      <div class="title"><h3 v-if="item.xuan===1">单选题</h3>
        <h3 v-else-if="item.xuan===2">判断题</h3>
        <h3 v-else>多选题</h3>
        题目：{{ item.name }}
        <span class="answer" v-show="answerShow">答案：{{ item.answer }}</span>
        <span style="float: right;">{{ idx+ 1}}/{{ question.length }}</span>
      </div>
      <div>
        <div :class="val.checked ? 'bgc' : ''" v-for="val in item.option" :key="val.id" class="list"
          @click="handleCilck(val)">{{ val.letter }}.
          {{ val.name }}</div>
      </div>
    </div>
    <div>

      <button @click="back()" :style="idx == 0 ? 'background-color:#ccc;' : ''"
        :disabled="idx == 0 ? true : false">上一题</button>
      <button @click="next()" :style="idx == question.length - 1 ? 'background-color:#ccc;' : ''"
        :disabled="idx == question.length - 1 ? true : false">下一题</button>
      <button @click="sumbit" style="background-color: rgb(250, 142, 0);color: aliceblue;">提交</button>
      <button v-show="isshow" @click="answerShow = true"
        style="background-color: rgb(238, 190, 79);color: rgb(255, 255, 255);">查看答案</button>
    </div>
  </div>
</template>
<script>
import axios from 'axios'
import { ElMessage } from 'element-plus'
export default {
  data() {
    return {
      idx: 0,
      allSocre: 0,
      isshow: false,
      answerShow: false,
      ismultipleAnswer: [],//多选选中的答案
      question: [],
      isshow1: true,
      time: '',
      hr: '12',
      min: '2',
      sec: '2',
      dataAll: [],
      question12:[],
      ismultiple:'',
    }
  },
  mounted() {
    axios.get('/api/admin/wenti', {
      params: {
        contestId: this.$route.query.contestId
      }
    }).then(res => {
      console.log(res.data)
      for (var i = 0; i < res.data.length; i++) {
        var xuanxiang1=''
        var abab = []
        if(res.data[i].answerC==''||res.data[i].answerC==null){
          var A = {
          id: '1',
          name: res.data[i].answerA,
          letter: 'A'
        }
        var B = {
          id: '2',
          name: res.data[i].answerB,
          letter: 'B'
        }
        abab.push(A,B)
        }
        else if(res.data[i].answerD==''||res.data[i].answerD==null){
          var A = {
          id: '1',
          name: res.data[i].answerA,
          letter: 'A'
        }
        var B = {
          id: '2',
          name: res.data[i].answerB,
          letter: 'B'
        }
         var C = {
          id: '3',
          name: res.data[i].answerC,
          letter: 'C'
        }
        abab.push(A,B,C)
        }
       else if(res.data[i].answerE==''||res.data[i].answerE==null){
        var A = {
          id: '1',
          name: res.data[i].answerA,
          letter: 'A'
        }
        var B = {
          id: '2',
          name: res.data[i].answerB,
          letter: 'B'
        }
         var C = {
          id: '3',
          name: res.data[i].answerC,
          letter: 'C'
        }
        var D = {
          id: '4',
          name: res.data[i].answerD,
          letter: 'D'
        }
        abab.push(A,B,C,D)
       }
       else{
        var A = {
          id: '1',
          name: res.data[i].answerA,
          letter: 'A'
        }
        var B = {
          id: '2',
          name: res.data[i].answerB,
          letter: 'B'
        }
         var C = {
          id: '3',
          name: res.data[i].answerC,
          letter: 'C'
        }
        var D = {
          id: '4',
          name: res.data[i].answerD,
          letter: 'D'
        }
        var E = {
          id: '5',
          name: res.data[i].answerE,
          letter: 'E'
        }
        abab.push(A,B,C,D,E)
       }
        if(res.data[i].level==='单选题'){
          xuanxiang1=1
          this.ismultiple=false
        }
        else if(res.data[i].level==='多选题'){
          xuanxiang1=3
          this.ismultiple=true
        }
        else{
          xuanxiang1=2
          this.ismultiple=false
        }
        var obj = {
          id: res.data[i].questionId,
          name: res.data[i].question,
          answer: res.data[i].rightAnswer,
          score: res.data[i].score,
          option: abab,
          xuan:xuanxiang1,
          ismultiple:this.ismultiple
        }
        this.question12.push(obj)
        this.question12=this.question12.sort(function(a,b){
          return b.xuan-a.xuan
        })
        this.question=this.question12
      }
    }),
      this.begin()
  },
  methods: {
    next() {
      this.idx++
    },
    back() {
      this.idx--
    },
    handleCilck(info) {
      let question = this.question[this.idx]  //每题选项
      let option = this.question[this.idx].option //每一题题目的选项

      //选中添加样式
      option.forEach(item => {
        if (item.id == info.id) {  //如果选中的与数据里面的相等就改变他的样式
          item.checked = !item.checked  // 是否选中，取反 
        } else if (!question.ismultiple) {  //如果不是多选 只能选中一个 其他的都为false
          item.checked = false
        }
      });


      let isAnswer = info.letter //选中的答案
      let answer = this.question[this.idx].answer //题目中的答案

      //如果是多选
      if (question.ismultiple) {
        this.ismultipleAnswer = []
        option.forEach(item => {
          if (item.checked) { //将选中的push到 ismultipleAnswer 数组中
            this.ismultipleAnswer.push(item.letter)
          }
        });
        isAnswer = this.ismultipleAnswer.join('')  //将ismultipleAnswer转为字符串 下面与答案比较
      }


      console.log('选中的答案', isAnswer);
      console.log('题目的答案', answer);


      //判断是否选正确，计算分数

      if (isAnswer == answer) { // 如果选的答案与题目答案相等,isOk 说明选对了
        this.question[this.idx].isOk = true
      } else {
        this.question[this.idx].isOk = false
      }

    },
    // 提交计算分数
    sumbit() {
      let userInfo = JSON.parse(localStorage.getItem('usersinfo'))
      this.allSocre = 0  //每次计算总分先清0,，在计算
      let result = []  //定义选中的个数
      this.question.forEach(item => {
        //返回是否选中的数组
        let selsetArr = item.option.map(val => {
          if (val.checked) {
            return val.checked //map最终返回一个数组，返回 checked 的数组
          }
        })
        console.log('selsetArr', selsetArr);
        //这边是否包含true，包含 true 就push到result中
        const isTrue = selsetArr.includes(true)  //如果包含返回true,否则返回false
        //这里判断一下,如果 isTrue 是 true，说明包含true 就说明选了
        if (isTrue) {
          result.push(isTrue)  //如果选了，就push到 result 中
        }

        if (item.isOk) { //如果isOK 为 true 说明选了，计算分数
          this.allSocre +=parseFloat(item.score) 
          console.log(this.allSocre)
        }
      })
      if (result.length < this.question.length) {
        alert('还有题目没做呢')
        return
      }
      
      axios.put('/api/admin/scroe', {
        params: {
          contestId: this.$route.query.contestId,
          username: userInfo.uid,
          score: this.allSocre
        }
      }).then(res => {
        if (res.data.code == 200) {
          setTimeout(() => {
            alert('获得分数：' + this.allSocre)
            this.isshow = true
          }, 100);
          this.$router.push({ name: 'usercontest' })
        }
        else { console.log(res.data) }
      })
    },
    begin() {
      let userInfo = JSON.parse(localStorage.getItem('usersinfo'))
      axios.get('/api/admin/daojishi', {
        params: {
          contestId: this.$route.query.contestId,
          username: userInfo.uid
        }
      }).then(res => {
        this.dataAll = res.data[0]
        if (this.dataAll.Answertime == '' || this.dataAll.Answertime == null) {
          axios.put('/api/admin/begindaojishi', {
            params: {
              id: userInfo.uid
            }
          }).then(this.begin())
        }
        var time1 = new Date(this.dataAll.Answertime)
        this.time = new Date(time1.setMinutes(time1.getMinutes() + 120))
        console.log(time1)
        console.log(this.time)
        // 开始执行倒计时
        this.countdown();
        // 更换按钮，根据情况选择v-if或v-show
        this.isshow1 = false;

        this.$message({
          type: 'success',
          message: '开始答题'
        });
      })
      // 点击按钮后开始计算指定长度的时间

    },
    countdown() {
      const end = this.time; // 定义结束时间
      const now = Date.parse(new Date()); // 获取本地时间
      const msec = end - now; // 定义总共所需的时间
      // 将时间戳进行格式化
      let hr = parseInt(msec / 1000 / 60 / 60 % 24);
      let min = parseInt(msec / 1000 / 60 % 60);
      let sec = parseInt(msec / 1000 % 60);
      // 倒计时结束时的操作
      const that = this;
      if (this.hr == 0 && this.min == 0 && this.sec == 0) {
        ElMessage({
          showClose: true,
          message: '添加成功',
          type: 'success'
        });
      } else {
        // 如时间未归零则继续在一秒后执行
        this.hr = hr > 9 ? hr : '0' + hr;
        this.min = min > 9 ? min : '0' + min;
        this.sec = sec > 9 ? sec : '0' + sec;
        setTimeout(that.countdown, 1000)
      }
    },
    open() {
      this.$confirm('即将结束答题, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then((action) => {
        // eleUI的确定结束回调函数方法
        if (action === 'confirm') {
          this.hr = 0;
          this.min = 0;
          this.sec = 0;
          console.log(this.hr + ',' + this.min + ',' + this.sec);
          this.isshow1 = true;
        }
        this.$message({
          type: 'success',
          message: '交卷成功!'
        });
      }).catch(() => {
        // 点击取消后
        this.$message({
          type: 'info',
          message: '已取消交卷'
        });
      });
    },
  }
}
</script>
<style scoped>
* {
  padding: 0;
  box-sizing: border-box;
  font-size: 13px;
}

.question {
  margin-top: 20px;
  width: 1100px;
  background-color: rgb(240, 240, 240);
  border-radius: 10px;
  padding: 20px;
  color: rgb(81, 81, 82);
  font-size: 16px;
}

button {
  margin-top: 15px;
  margin-right: 10px;
  outline: none;
  background-color: rgb(255, 153, 98);
  border: 0;
  padding: 10px;
  color: rgb(61, 61, 61);
  border-radius: 5px;
}

button:active {
  background-color: rgba(248, 161, 121, 0.664);
}

#app12 {
  display: flex;
  align-items: center;
  justify-content: center;
  flex-direction: column;
}

.title {
  color: black;
  font-weight: 600;
  font-size: 18px;
  height: 77px;
  line-height: 30px;
}

.list {
  margin-top: 10px;
  padding: 10px 5px;
  font-size: 16px;
  border: 1px rgb(46, 46, 46) solid;
  border-radius: 10px;
}

.bgc {

  border: 1px rgb(250, 109, 0) solid;
  color: aliceblue;
  background-color: rgb(240, 125, 38);
}

.answer {
  color: brown;
  font-size: 16px;
  margin-left: 20px;
}

.select {
  font-size: 18px;
  color: rgb(243, 25, 25);
}
</style>