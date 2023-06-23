<template>
  <el-form :model="form" :rules="formrule" ref="form" label-width="150px">
    <el-row align="middle" :gutter="10">
      <el-col :span="7">
        <el-form-item prop="category" label="题目类型">
          <el-select v-model="form.category" placeholder="请选择">
            <el-option v-for="category in option" :key="category.id" :label="category.label" :value="category.index">
            </el-option>
          </el-select>
        </el-form-item>
      </el-col>
      <el-col :span="7">
        <el-form-item prop="level" label="问题类型">
          <el-select v-model="form.level" placeholder="请选择" clearable @change="getRole($event)">
            <el-option v-for="item in select1" :key="item.value" :label="item.label" :value="item.value">
            </el-option>
          </el-select>
        </el-form-item>
      </el-col>
      <el-col :span="7">
        <el-form-item prop="xuanxiang" label="正确选项">
          <el-select v-model="form.xuanxiang" :multiple="multiple" collapse-tags placeholder="请选择">
    <el-option
      v-for="item in select2"
      :key="item.value"
      :label="item.label"
      :value="item.value">
    </el-option>
  </el-select>
        </el-form-item>
      </el-col>
      <el-col :span="20">
        <el-form-item prop="textarea1" label="题目:">
          <el-input v-model="form.textarea1" :autosize="{ minRows: 3 }" type="textarea" placeholder="请输入题目"
            resize="none" />
        </el-form-item>
      </el-col>
      <el-col :span="20" v-show="panduan">
        <el-form-item prop="textarea2" label="A:">
          <el-input v-model="form.textarea2" :autosize="{ minRows: 1 }" type="textarea" placeholder="请输入A选项"
            resize="none" />
        </el-form-item>
      </el-col>
      <el-col :span="20" v-show="panduan">
        <el-form-item prop="textarea3" label="B:">
          <el-input v-model="form.textarea3" :autosize="{ minRows: 1 }" type="textarea" placeholder="请输入B选项"
            resize="none" />
        </el-form-item>
      </el-col>
      <el-col :span="20" v-if="danxuan">
        <el-form-item prop="textarea4" label="C:">
          <el-input v-model="form.textarea4" :autosize="{ minRows: 1 }" type="textarea" placeholder="请输入C选项"
            resize="none" />
        </el-form-item>
      </el-col>
      <el-col :span="20" v-if="danxuan">
        <el-form-item prop="textarea5" label="D:">
          <el-input v-model="form.textarea5" :autosize="{ minRows: 1 }" type="textarea" placeholder="请输入D选项"
            resize="none" />
        </el-form-item>
      </el-col>
      <el-col :span="20" v-if="duoxuan">
        <el-form-item prop="textarea6" label="E:">
          <el-input v-model="form.textarea6" :autosize="{ minRows: 1 }" type="textarea" placeholder="请输入E选项"
            resize="none" />
        </el-form-item>
      </el-col>
      <el-col v-show="annui">
        <el-form-item class="an">
          <el-button style="width:90px" @click="doLogin('form')">添加</el-button>
          <el-button style="margin-left:80px;width:90px" @click="doclear()">取消</el-button>
        </el-form-item>
      </el-col>
    </el-row>
  </el-form>
</template>
<script>
import { ref, reactive, } from 'vue';
import axios from 'axios';
import { ElMessage } from 'element-plus'
import { Search } from '@element-plus/icons-vue';
export default {
  data() {
    return {
      multiple:false,
      annui: false,
      panduan: false,
      danxuan: false,
      duoxuan: false,
      Search,
      select1: [
        { value: '单选题', label: '单选题' },
        { value: '判断题', label: '判断题' },
        { value: '多选题', label: '多选题' }
      ],
      allrole: [
        { pro: '单选题', label: 'A' }, { pro: '单选题', label: 'B' }, { pro: '单选题', label: 'C' }, { pro: '单选题', label: 'D' },
        { pro: '多选题', label: 'A' }, { pro: '多选题', label: 'B' }, { pro: '多选题', label: 'C' }, { pro: '多选题', label: 'D' }, { pro: '多选题', label: 'E' },
        { pro: '判断题', label: 'A' }, { pro: '判断题', label: 'B' },

      ],
      loading: false,
      form: {
        xuanxiang:[],
        textarea1: ref(''), textarea2: ref(''), textarea3: ref(''), textarea4: ref(''), textarea5: ref(''), textarea6: ref(''),
        level: ref(''),
        category: ref('')
      },
      option: [],
      select2: [],
      formrule: {
        xuanxiang: [{ required: true, message: '不能为空' }],
        textarea2: [{ required: true, message: '不能为空' }],
        textarea1: [{ required: true, message: '不能为空' }],
        textarea3: [{ required: true, message: '不能为空' }],
        textarea4: [{ required: true, message: '不能为空' }],
        textarea5: [{ required: true, message: '不能为空' }],
        textarea6: [{ required: true, message: '不能为空' }],
        level: [{ required: true, message: '不能为空' }],
        category: [{ required: true, message: '不能为空' }]
      }
    }
  },
  mounted() {
    this.category()
  },
  methods: {
    getRole(prov) {
      this.annui = true
      this.panduan = false, this.danxuan = false, this.duoxuan = false
      this.form.xuanxiang = []
      let roles = []
      this.select2 = []
      for (var val of this.allrole) {
        if (prov === val.pro) {
          roles.push({ label: val.label, value: val.label })

        }

        this.select2 = roles
      }
      if (prov === '单选题') {
        this.panduan = true, this.danxuan = true
      }
      else if (prov === '判断题') {
        this.panduan = true
      }
      else if (prov === '多选题') {
        this.panduan = true, this.danxuan = true, this.duoxuan = true
        this.multiple=true
      }
      else {
        this.annui = false
        this.panduan = false, this.danxuan = false, this.duoxuan = false
      }
    },
    getList(opt) {
      console.log(opt)
    },

    category() {
      axios.get('/api/admin/category').then(res => {
        for (var i = 0; i < res.data.length; i++) {
          var obj = {
            index: res.data[i].index,
            label: res.data[i].index
          }
          this.option.push(obj)
        }
      })
    },
    doLogin(form) {
      this.$refs[form].validate(validate => {
        if (validate) {
          axios.post('/api/admin/bank', {
            params: {
              form: this.form
            }
          }).then(res => {
            if (res.data.code === 200) {
              ElMessage({
                showClose: true,
                message: '添加成功',
                type: 'success',
              })
              this.$refs['form'].resetFields()
            }
          })
        }
      }
      )

    }
  }
}
</script>