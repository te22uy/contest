<template>
  <div style="text-align: center;">
    <el-input v-model="input" placeholder="搜索" class="input-with-select" style="width: 300px;" clearable>
      <template #append>
        <el-button :icon="Search" @click="search()" />
      </template>
    </el-input>
  </div>
  <el-table ref="filterTable" :data="tables.slice((currentPage - 1) * pageSize, currentPage * pageSize)" border
    @filter-change="filterTagTable" style="width: 100%" v-loading.fullscreen.lock="loading" element-loading-text="加载中"
    element-loading-spinner="el-icon-loading" element-loading-background="rgba(0, 0, 0, 0.8)" height="500">
    <template #empty>
      <el-empty description="暂无数据" />
    </template>
    <el-table-column prop="username" label="账号" width="130" />
    <el-table-column prop="name" label="姓名" width="90" />
    <el-table-column prop="sex" label="性别" width="60" />
    <el-table-column prop="school" label="学校" width="180" />
    <el-table-column prop="grade" label="年级" width="90" />
    <el-table-column prop="department" label="所在系" width="180" />
    <el-table-column prop="professional" label="专业" width="180" />
    <el-table-column prop="email" label="e-mail" width="190" />
    <el-table-column label="操作">
      <template v-slot="scope">
        <el-tooltip class="box-item" effect="dark" content="竞赛信息" placement="top">
          <el-button type="primary" :icon="View" circle
            @click="dialogTableVisible = true, handleEdit(scope.$index, scope.row.username)" />
        </el-tooltip>
        <el-tooltip class="box-item" effect="dark" content="删除学生" placement="top">
          <el-button type="danger" :icon="Delete" circle @click="DeleteId(scope.row.id)" />
        </el-tooltip>
        <el-tooltip class="box-item" effect="dark" content="重置密码" placement="top">
          <el-button type="warning" :icon="Refresh" circle @click="RefreshId(scope.row.id)" />
        </el-tooltip>
      </template>
    </el-table-column>
  </el-table>
  <div class="block">
    <el-pagination align='center' @size-change="handleSizeChange" @current-change="handleCurrentChange"
      :current-page="currentPage" :page-sizes="[5, 10, 20]" :page-size="pageSize"
      layout="total, sizes, prev, pager, next, jumper" :total="tables.length">
    </el-pagination>
  </div>
  <el-dialog v-model="dialogTableVisible" title="竞赛信息" width="1000">
    <el-table :data="gridData">
      <template #empty>
        <el-empty description="暂无数据" />
      </template>
      <el-table-column property="name" label="姓名" width="150" />
      <el-table-column property="contestName" label="竞赛名称" width="200" />
      <el-table-column property="contestcategory" label="竞赛种类" width="150" />
      <el-table-column property="Contestlevel" label="竞赛级别" width="150" />
      <el-table-column property="conteststar" label="开始时间" width="150" />
      <el-table-column property="contestEnd" label="结束时间" width="150" />
    </el-table>
  </el-dialog>
</template>
<script>
import { Search, View, Delete, CircleClose, Refresh } from '@element-plus/icons-vue';
import { ref, reactive, } from 'vue';
import axios from 'axios';
import { ElMessage } from 'element-plus'
export default {
  data() {
    return {
      currentPage: 1,
      pageSize: 10,
      gridData: [],
      scope: ref(''),
      input: ref(''),
      Search, Delete, CircleClose, Refresh, View,
      listter: reactive({
        arr: []
      }),
      dialogTableVisible: false,
      formLabelWidth: '120px',
      form: reactive({
        number: '',
        name: '',
        school: '',
        job: '',
        email: '',
        phone: ''
      }),
      formrule: {
        school: [{ required: true, message: '不能为空' }],
        job: [{ required: true, message: '不能为空' }],
        phone: [{ required: true, message: '请输入手机号' }, { type: "number", message: '手机号格式不对', transform: (value) => Number(value) }, { pattern: /^1[3456789]\d{9}$/, message: "手机号格式不对", }],
        email: [{ required: true, message: '不能为空' }, { type: "email", message: '电子邮箱格式不对' }]
      }
    }
  },
  methods: {
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
    getUserList() {
      axios.get('api/admin/user',).then(res => {
        this.listter.arr = res.data
        this.loading = false
      })

    },
    async DeleteId(therid) {
      console.log(therid)
      // 弹框询问用户是否删除数据
      const confirmResult = await this.$confirm('此操作将永久删除该用户, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'error'
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消删除'
        })
      })

      if (confirmResult !== 'confirm') {
        return this.$message.info('已取消删除')
      }
      this.loading = true
      axios.delete('api/admin/userdelete', {
        params: {
          therid: therid
        }
      }).then(res => {
        if (res.data.code === 200) {
          this.$message.success('删除用户成功！')
          this.getUserList()
        }
        else {
          this.$message.success('删除用户失败！')
          this.getUserList()
        }
        this.loading = false
      })

    },
    async RefreshId(therid) {
      const confirmResult = await this.$confirm('此操作将重置用户密码, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消重置'
        })
      })

      if (confirmResult !== 'confirm') {
        return this.$message.info('已取消重置')
      }
      this.loading = true
      axios.put('api/admin/userreset', {
        params: {
          therid: therid,
          password: '111111'
        }
      }).then(res => {
        if (res.data.code === 200) {
          this.$message.success('重置密码成功！')
          this.getUserList()
        }
        else {
          this.$message.success('重置密码成功！')
          this.getUserList()
        }
        this.loading = false
      })
    },
    handleEdit(index, row) {
      axios.get('/api/admin/usercontest', {
        params: {
          username: row
        }
      }).then(res => {
        this.gridData = res.data
      })
    },

    search() {

    }
  },
  created() {
    this.getUserList();
    this.loading = true
  },
  mounted() {
  },
  computed: {
    tables() {
      const input = this.input
      if (input) {
        console.log("input输入的搜索内容：" + this.input)
        return this.listter.arr.filter(data => {
          console.log("object:" + Object.keys(data))
          return Object.keys(data).some(key => {
            return String(data[key]).toLowerCase().indexOf(input) > -1
          })
        })

      }
      return this.listter.arr
    }

  }
}
</script>
