<template>
  <el-row style="text-align: center">
    <el-col>
      <el-form :model="form" ref="form" :rules="formrule" label-width="120px"
        style="display: inline-block;margin-top:50px;">
        <el-form-item prop="name" label="老师姓名">
          <el-input v-model="form.name" style="width:290px" clearable />
        </el-form-item>
        <el-form-item label="老师编号" prop="number">
          <el-input v-model="form.number" style="width:290px" clearable />
        </el-form-item>
        <el-form-item label="性别" prop="sex">
          <el-select v-model="form.sex" style="width:290px">
            <el-option label="男" value="男" />
            <el-option label="女" value="女" />
          </el-select>
        </el-form-item>
        <el-form-item label="出生时间" prop="date">
          <el-date-picker value-format="YYYY-MM-DD" v-model="form.date" type="date" placeholder="选择时间"
            :disabled-date="disabledDate" :shortcuts="shortcuts" :size="size" style="width:290px" />
        </el-form-item>
        <el-form-item label="职称" prop="job">
          <el-select v-model="form.job" style="width:290px">
            <el-option label="助教" value="助教" />
            <el-option label="讲师" value="讲师" />
            <el-option label="副教授" value="副教授" />
            <el-option label="教授" value="教授" />
          </el-select>
        </el-form-item>
        <el-form-item label="就职院校" prop="school">
          <el-input v-model="form.school" style="width:290px" clearable />
        </el-form-item>
        <el-form-item label="专业名称" prop="specialized">
          <el-input v-model="form.specialized" style="width:290px" clearable />
        </el-form-item>
        <el-form-item label="电话" prop="phone">
          <el-input v-model="form.phone" style="width:290px" clearable />
        </el-form-item>
        <el-form-item label="电子邮箱" prop="email">
          <el-input v-model="form.email" style="width:290px" clearable />
        </el-form-item>
        <el-form-item style="margin-top: 10px;">
          <el-button key="plain" type="" @click="Confirm('form')">确认</el-button>
          <el-button key="plain" type="" style="margin-left:160px">取消</el-button>
        </el-form-item>
      </el-form>
    </el-col>
  </el-row>
</template>
<script>
import { reactive } from 'vue'
import axios from 'axios';
import { ElMessage } from 'element-plus'
export default {
  data() {
    return {
      form: reactive({
        sex: '男',
        job: '助教',
        name: '',
        number: '',
        date: '',
        school: '',
        specialized: '',
        phone: '',
        email: '',
      }),
      disabledDate(time) {
        return time.getTime() > Date.now()
      },
      formrule: {
        name: [{ required: true, message: '请输入老师姓名' }, { type: 'string', message: '老师编号格式不对' }],
        sex: [{ required: true, message: '不能为空' }],
        job: [{ required: true, message: '不能为空' }],
        number: [{ required: true, message: '请输入老师编号' }, { type: 'number', message: '老师编号格式不对', transform: (value) => Number(value) }],
        date: [{ required: true, message: '不能为空' }],
        school: [{ required: true, message: '不能为空' }],
        specialized: [{ required: true, message: '不能为空' }],
        phone: [{ required: true, message: '请输入手机号' }, { type: "number", message: '手机号格式不对', transform: (value) => Number(value) }, { pattern: /^1[3456789]\d{9}$/, message: "手机号格式不对", }],
        email: [{ required: true, message: '不能为空' }, { type: "email", message: '电子邮箱格式不对' }]
      }
    }
  },
  methods: {
    Confirm(form) {
      this.$refs[form].validate(validate => {
        if (validate) {
          console.log(this.job)
          axios.post('/api/admin/addtec', {
            params: {
              sex: this.form.sex,
              job: this.form.job,
              name: this.form.name,
              number: this.form.number,
              date: this.form.date,
              school: this.form.school,
              specialized: this.form.specialized,
              phone: this.form.phone,
              email: this.form.email,
            }
          }).then(res => {
            if (res.data.code == 200) {
              ElMessage({
                showClose: true,
                message: '添加成功',
                type: 'success',
              })
              this.$refs['form'].resetFields()
            }
          })
        }
      })

    }
  }
}
</script>