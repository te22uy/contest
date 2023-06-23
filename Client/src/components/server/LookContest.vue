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
    <el-table-column label="比赛封面" width="140">
      <template v-slot="scope">
        <el-image style="width: 100px; height: 100px" :src="scope.row.contestImg" fit="contain" />
      </template>
    </el-table-column>
    <el-table-column prop="name" label="比赛名称" width="130" />
    <el-table-column prop="level" label="比赛级别" width="130" />
    <el-table-column prop="category" label="比赛类别" width="130" />
    <el-table-column prop="Startdate" label="开始时间" width="160" />
    <el-table-column prop="Enddate" label="结束时间" width="160" />
    <el-table-column label="状态" width="160">
      <template v-slot="scope">
        <el-tag type="warning" effect="dark" v-if="(scope.row.outdated == 0)">未开始</el-tag>
        <el-tag type="success" effect="dark" v-if="(scope.row.outdated == 1)">正在报名</el-tag>
        <el-tag type="danger" effect="dark" v-if="(scope.row.outdated == 2)">已经结束</el-tag>
      </template>
    </el-table-column>
    <el-table-column label="操作">
      <template v-slot="scope">
        <el-tooltip class="box-item" effect="dark" content="修改" placement="top">
          <el-button type="primary" :icon="Edit" circle @click="change(scope.row.contestId)" />
        </el-tooltip>
        <el-tooltip class="box-item" effect="dark" content="删除" placement="top">
          <el-button type="danger" :icon="Delete" circle @click="DeleteId(scope.row.contestId)" />
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
</template>
<script>
import { Search, Edit, Delete, CircleClose, Refresh } from '@element-plus/icons-vue';
import { ref, reactive, } from 'vue';
import axios from 'axios';
import { ElMessage } from 'element-plus'
export default {
  data() {
    return {
      currentPage: 1,
      pageSize: 10,
      scope: ref(''),
      input: ref(''),
      Search, Edit, Delete, CircleClose, Refresh,
      listter: reactive({
        arr: []
      }),
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
      axios.get('api/admin/contest',).then(res => {
        this.listter.arr = res.data
        this.loading = false
        this.listter.arr.sort((a, b) => {
          return b.Enddate < a.Enddate ? -1 : 1
        })
      })

    },
    async DeleteId(contestId) {
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
      axios.delete('api/admin/contestdelete', {
        params: {
          contestId: contestId
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
    change(contestId) {
      console.log(contestId)
      this.$router.push({
        name: 'ChangContest',
        query: {
          contestId: contestId
        }
      })
    },
    search() {

    }
  },
  created() {
    this.getUserList();
    this.loading = true
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
