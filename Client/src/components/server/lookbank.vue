<template>
  <el-table ref="filterTable" :data="tableData.slice((currentPage - 1) * pageSize, currentPage * pageSize)" border
    @filter-change="filterTagTable" style="width: 100%">
    <el-table-column prop="questionId" label="问题序号" width="90">
    </el-table-column>
    <el-table-column filter-placement="bottom-end" :column-key="'category'" :filters="addresstabledata"
      prop="category" label="题目类型" width="100">
      <template v-slot="scope">
        <span disable-transitions>{{ scope.row.category }}</span>
      </template>
    </el-table-column>
    <el-table-column filter-placement="bottom-end" :column-key="'level'" :filters="nametabledata" prop="level"
      label="问题类型" width="95">
      <template v-slot="scope">
        <span disable-transitions>{{ scope.row.level }}</span>
      </template>
    </el-table-column>
    <el-table-column prop="question" label="题目" width="162">
    </el-table-column>
    <el-table-column prop="answerA" label="选项A" width="131">
    </el-table-column>
    <el-table-column prop="answerB" label="选项B" width="131">
    </el-table-column>
    <el-table-column prop="answerC" label="选项C" width="131">
    </el-table-column>
    <el-table-column prop="answerD" label="选项D" width="131">
    </el-table-column>
    <el-table-column prop="answerE" label="选项E" width="131">
    </el-table-column>
    <el-table-column prop="rightAnswer" label="答案" width="60">
    </el-table-column>
    <el-table-column label="操作">
      <template v-slot="scope">
        <el-tooltip class="box-item" effect="dark" content="修改" placement="top">
          <el-button type="primary" :icon="Edit" circle @click="change(scope.row.questionId)" />
        </el-tooltip>
        <el-tooltip class="box-item" effect="dark" content="删除" placement="top">
          <el-button type="danger" :icon="Delete" circle @click="DeleteId(scope.row.questionId)" />
        </el-tooltip>
      </template>
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
import { Search, Edit, Delete, CircleClose, Refresh } from '@element-plus/icons-vue';
import { ref, reactive, } from 'vue';
import axios from 'axios';
import { ElMessage } from 'element-plus'
export default {
  created() {
    axios.get('/api/admin/lookbank').then(res => {
      this.tableData = res.data

      localStorage.setItem('table', JSON.stringify(this.tableData))
      console.log(JSON.parse(localStorage.getItem('table')))
    })
  },
  mounted() {
    this.category()
  },
  methods: {
    change(questionId){
      console.log(questionId)
    },
    DeleteId(questionId){
      console.log(questionId)
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
    }
  },
  data() {
    return {
      currentPage: 1,
      pageSize: 10,
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
      Search, Edit, Delete, CircleClose, Refresh,
    }
  }
  
}
</script>
