<template>
  <el-row style="text-align: center">
    <el-col>
      <el-form :model="form" ref="form" :rules="formrule" label-width="120px"
        style="display: inline-block;margin-top:50px;">
        <el-form-item prop="username" label="账号">
          <el-input v-model="form.username" style="width:290px" disabled="true" />
        </el-form-item>
        <el-form-item label="姓名" prop="name">
          <el-input v-model="form.name" style="width:290px" clearable />
        </el-form-item>
        <el-form-item label="性别" prop="sex">
          <el-select v-model="form.sex" style="width:290px">
            <el-option label="男" value="男" />
            <el-option label="女" value="女" />
          </el-select>
        </el-form-item>
        <el-form-item label="就读学校" prop="school">
          <el-input v-model="form.school" style="width:290px" clearable />
        </el-form-item>
        <el-form-item label="所在系别" prop="department">
          <el-input v-model="form.department" style="width:290px" clearable />
        </el-form-item>

        <el-form-item label="年级" prop="grade">
          <el-select v-model="form.grade" style="width:290px" @visible-change="yearChange($event)">
            <el-option v-for="item in years" :key="item.value" :label="item.label" :value="item.value">
            </el-option>
          </el-select>
        </el-form-item>

        <el-form-item label="专业名称" prop="professional">
          <el-input v-model="form.professional" style="width:290px" clearable />
        </el-form-item>
        <el-form-item label="电子邮箱" prop="email">
          <el-input v-model="form.email" style="width:290px" clearable disabled="true" />
        </el-form-item>
        <el-form-item label="地址">
          <el-select v-model="sheng" @change="choseProvince" placeholder="省级地区">
            <el-option v-for="item in province" :key="item.id" :label="item.value" :value="item.id">
            </el-option>
          </el-select>
          <el-select v-model="shi" @change="choseCity" placeholder="市级地区">
            <el-option v-for="item in shi1" :key="item.id" :label="item.value" :value="item.id">
            </el-option>
          </el-select>
          <el-select v-model="qu" @change="choseBlock" placeholder="区级地区">
            <el-option v-for="item in qu1" :key="item.id" :label="item.value" :value="item.id">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item style="margin-top: 59px;">
          <el-button key="plain" type="" @click="Confirm('form')">确认</el-button>
          <el-button key="plain" type="" style="margin-left:160px">取消</el-button>
        </el-form-item>
      </el-form>
    </el-col>
  </el-row>
</template>
<script>
import { reactive, ref } from 'vue'
import axios from 'axios';
import { ElMessage } from 'element-plus'
export default {
  data() {
    return {
      form: reactive({
        sex: '男',
        name: '',
        school: '',
        email: '',
        department: '',
        grade: '',
        professional: ''
      }),
      fromdata: ref(''),
      formrule: {
        name: [{ required: true, message: '不能为空' }],
        sex: [{ required: true, message: '不能为空' }],
        school: [{ required: true, message: '不能为空' }],
        department: [{ required: true, message: '不能为空' }],
        grade: [{ required: true, message: '不能为空' }],
        professional: [{ required: true, message: '不能为空' }],
        email: [{ required: true, message: '不能为空' }, { type: "email", message: '电子邮箱格式不对' }],
      },
      years: [],
      province: [],
      sheng: '', shi: '', qu: '',

      shi1: [],

      qu1: [],
      city: '',
      block: '',
    }
  },
  methods: {
    userlist() {
      let userInfo = JSON.parse(localStorage.getItem('usersinfo'));
      axios.get('/api/admin/userPersonal', {
        params: {
          username: userInfo.uid
        }
      }).then(res => {
        this.form = res.data[0]
      })
    },
    yearChange() {
      var myDate = new Date()
      var startYear = myDate.getFullYear() - 5// 起始年份
      var endYear = myDate.getFullYear()// 结束年份

      this.years = []
      for (var i = startYear; i <= endYear; i++) {
        this.years.push({ value: (i), label: (i) })
      }
    },

    // 加载china地点数据，三级
    getCityData: function () {
      const loading = this.$loading({
        lock: true,//lock的修改符--默认是false
        text: 'Loading',//显示在加载图标下方的加载文案
        spinner: 'el-icon-loading',//自定义加载图标类名
        background: 'rgba(0, 0, 0, 0.7)',//遮罩层颜色
      });
      var that = this
      axios.get('http://127.0.0.1:8080/static/map.json').then(function (response) {
        loading.close()
        if (response.status == 200) {

          var data = response.data
          that.province = []
          that.city = []
          that.block = []
          // 省市区数据分类
          for (var item in data) {
            if (item.match(/0000$/)) {//省
              that.province.push({ id: item, value: data[item], children: [] })
            } else if (item.match(/00$/)) {//市
              that.city.push({ id: item, value: data[item], children: [] })
            } else {//区
              that.block.push({ id: item, value: data[item] })
            }
          }
          // 分类市级
          for (var index in that.province) {
            for (var index1 in that.city) {
              if (that.province[index].id.slice(0, 2) === that.city[index1].id.slice(0, 2)) {
                that.province[index].children.push(that.city[index1])
              }
            }
          }
          // 分类区级
          for (var item1 in that.city) {
            for (var item2 in that.block) {
              if (that.block[item2].id.slice(0, 4) === that.city[item1].id.slice(0, 4)) {
                that.city[item1].children.push(that.block[item2])
              }
            }
          }
        }
        else {
          console.log(response.status)
        }
      }).catch(function (error) { console.log(typeof + error) })

    },
    // 选省
    choseProvince: function (e) {
      for (var index2 in this.province) {
        if (e === this.province[index2].id) {
          this.sheng = this.province[index2].value
          this.shi1 = this.province[index2].children
          this.shi = this.province[index2].children[0].value
          this.qu1 = this.province[index2].children[0].children
          this.qu = this.province[index2].children[0].children[0].value
          this.E = this.qu1[0].id
        }
      }
    },
    // 选市
    choseCity: function (e) {
      for (var index3 in this.city) {
        if (e === this.city[index3].id) {
          this.qu1 = this.city[index3].children
          this.qu = this.city[index3].children[0].value
          this.E = this.qu1[0].id
          // console.log(this.E)
        }
      }
    },
    // 选区
    choseBlock: function (e) {
      this.E = e;
    },
    Confirm(form) {

      this.$refs[form].validate(validate => {
        if (validate) {
          axios.put('/api/admin/changestudent', {
            params: {
              sheng: this.sheng,
              shi: this.shi,
              qu: this.qu,
              form: this.form
            }
          }).then(res => {
            if (res.data.code == 200) {
              ElMessage({
                message: '修改成功',
                type: 'success'
              })
              let userinfo = JSON.parse(localStorage.getItem('usersinfo'))
              userinfo.grade = this.form.grade
              userinfo.name = this.form.name
              localStorage.setItem('usersinfo', JSON.stringify(userinfo))
              console.log(localStorage.getItem('usersinfo'))
            }
            else {
              ElMessage({
                message: '修改失败',
                type: 'error',
              })
            }
          })
        }
      })
    }
  },
  mounted() {
    this.userlist();
    this.getCityData();
  }

}
</script>