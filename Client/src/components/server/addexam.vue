<template>
  <el-form :model="form" :rules="formrule" ref="form" label-width="150px">
    <el-row align="middle" :gutter="10">
      <el-col :span="6">
        <el-form-item prop="subject" label="试卷名称" style="width:500px">
          <el-select v-model="form.subject" placeholder="请选择">
            <el-option v-for="subject in option" :key="subject.id" :label="subject.label" :value="subject.index">
            </el-option>
          </el-select>
        </el-form-item>
      </el-col>
      <el-col :span="6">
        <el-form-item prop="tal" label="总分">
          <el-input-number v-model="form.tal" :precision="2" :step="0.5" :max="100" />
        </el-form-item>
      </el-col> 
      <el-col :span="6">
        <el-form-item>
         <label>一共选中{{ multipleSelection.length }}条数据</label>
        </el-form-item>
      </el-col>
      <el-col :span="6">
        <el-form-item>
         
          <el-button style="width:90px" @click="doLogin('form')">添加</el-button>
        </el-form-item>
      </el-col>
      </el-row>
      </el-form>
  <el-table id="tabell" ref="filterTable" :data="tableData.slice((currentPage - 1) * pageSize, currentPage * pageSize)"
    border @selection-change="handleSelectionChange" @filter-change="filterTagTable" style="width: 100%"
    :row-key="getRoeKey">
    <el-table-column type="selection" width="55" :reserve-selection="true">
    </el-table-column>
    <el-table-column prop="questionId" label="序号" width="80">
    </el-table-column>
    <el-table-column filter-placement="bottom-end" :column-key="'category'" :filters="addresstabledata" prop="category"
      label="题目类型" width="100">
      <template v-slot="scope">
        <span disable-transitions>{{ scope.row.category }}</span>
      </template>
    </el-table-column>
    <el-table-column filter-placement="bottom-end" :column-key="'level'" :filters="nametabledata" prop="level"
      label="问题类型" width="100">
      <template v-slot="scope">
        <span disable-transitions>{{ scope.row.level }}</span>
      </template>
    </el-table-column>
    <el-table-column prop="question" label="题目" width="200">
    </el-table-column>
    <el-table-column prop="answerA" label="选项A" width="135">
    </el-table-column>
    <el-table-column prop="answerB" label="选项B" width="135">
    </el-table-column>
    <el-table-column prop="answerC" label="选项C" width="135">
    </el-table-column>
    <el-table-column prop="answerD" label="选项D" width="135">
    </el-table-column>
    <el-table-column prop="answerE" label="选项E" width="135">
    </el-table-column>
    <el-table-column prop="rightAnswer" label="答案" width="68">
    </el-table-column>
  </el-table>
  <div class="block">
    <el-pagination align='center' @size-change="handleSizeChange" @current-change="handleCurrentChange"
      :current-page="currentPage" :page-sizes="[5, 10, 20]" :page-size="pageSize"
      layout="total, sizes, prev, pager, next, jumper" :total="tableData.length">
    </el-pagination>
  </div>
</template>

<script>
import axios from 'axios'
import { ref } from 'vue'
export default {
  data() {
    return {
      option:[],
      form:{
        subject:ref(''),
        tal:ref('')
      },
      selectdata: { category: [], level: [] },
      newData: [],
      twoData: [],
      data: [],
      listdata: '',
      nametabledata: [
        { value: '单选题', text: '单选题' },
        { value: '判断题', text: '判断题' },
        { value: '多选题', text: '多选题' }
      ],
      addresstabledata: [],
      listQuery: {
        status: ''
      },
      tableData: [],
      currentPage: 1,
      pageSize: 10,
      tableData: [],
      multipleSelection: [],
      formrule: {
        subject: [{ required: true, message: '请输入竞赛名称' }],
        tal: [{ required: true, message: '请添加竞赛封面' }],
      }
    }
  },
  created() {
    axios.get('/api/admin/lookbank').then(res => {
      this.tableData = res.data

      localStorage.setItem('table', JSON.stringify(this.tableData))
      console.log(JSON.parse(localStorage.getItem('table')))
    })
  },
  methods: {
    doLogin(form) {
      this.$refs[form].validate(validate => {
        if (validate) {
          let arr = this.multipleSelection.map((item) => {
        return item.questionId
      })
     console.log(arr)
      axios.post('/api/admin/addexam', {
        params: {
          examid: arr,
          score:this.form.tal/parseFloat(arr.length),
          subject:this.form.subject
        }
      })
        }})
   
    },
    subjectlist(){
      axios.get('/api/admin//contest').then(res=>{
        for (var i = 0; i < res.data.length; i++) {
          var obj = {
            index: res.data[i].contestId,
           label : res.data[i].name
          }
          this.option.push(obj)
        }
      })
    },
    category() {
      axios.get('/api/admin/category').then(res => {
        for (var i = 0; i < res.data.length; i++) {
          var obj = {
            value: res.data[i].index,
            text: res.data[i].index
          }
          this.addresstabledata.push(obj)
        }
      })
    },
    handleSizeChange(val) {
      this.pageSize = val
    },
    handleCurrentChange(val) {
      this.currentPage = val
    },
    filterTag(value, row) {
      return row.category === value
    },
    filterHandler(value, row, column) {
      const property = column['property']
      return row[property] === value
    },
    filterTagTable(filters) {
      this.twoData = []
      this.selectdata[String(Object.keys(filters))] = filters[String(Object.keys(filters))]
      this.newData = JSON.parse(localStorage.getItem('table'))
      console.log(this.newData)
      for (let j = 0; j < Object.keys(this.selectdata).length; j++) {
        if (this.selectdata[Object.keys(this.selectdata)[j]].length <= 1) {
          for (let k = 0; k < this.selectdata[Object.keys(this.selectdata)[j]].length; k++) {
            for (let i = 0; i < this.newData.length; i++) {
              if (this.selectdata[Object.keys(this.selectdata)[j]][k] !== this.newData[i][String(Object.keys(this.selectdata)[j])]) {
                this.newData.splice(i, 1)
                i--
              }
            }
          }
        } else {
          // console.log('选择了多个')
          this.twoData = []
          for (let k = 0; k < this.selectdata[Object.keys(this.selectdata)[j]].length; k++) {
            for (let i = 0; i < this.newData.length; i++) {
              if (this.selectdata[Object.keys(this.selectdata)[j]][k] === this.newData[i][String(Object.keys(this.selectdata)[j])]) {
                this.twoData.push(this.newData[i])
              }
            }
          }
          if (this.twoData.length !== 0) {
            this.newData = []
            for (let io = 0; io < this.twoData.length; io++) {
              this.newData.push(this.twoData[io])
            }
          }
        }
      }
      this.tableData = this.newData
    },
    getRoeKey(row) {
      return row.questionId
    },
    toggleSelection(rows) {
      if (rows) {
        rows.forEach(row => {
          this.$refs.multipleTable.toggleRowSelection(row);
        });
      } else {
        this.$refs.multipleTable.clearSelection();
      }
    },
    handleSelectionChange(val) {
      this.multipleSelection = val;
      console.log(this.multipleSelection)
    }
  },
  mounted() {
    this.category()
    this.subjectlist()
  }
}
</script>
<style scoped>
#tabell {
  line-height: 30px;
}
</style>