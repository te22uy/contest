<template>
  <p><strong>竞赛信息</strong></p>
  <el-table :data="tableData" border style="width: 100%">
    <template #empty>
      <el-empty description="暂无数据" />
    </template>
    <el-table-column prop="name" label="考生姓名" width="180" />
    <el-table-column prop="contestName" label="竞赛名称" width="260" />
    <el-table-column prop="contestcategory" label="竞赛类别" width="150" />
    <el-table-column prop="Contestlevel" label="竞赛级别" width="150" />
    <el-table-column prop="conteststar" label="开始时间" width="150" />
    <el-table-column prop="contestEnd" label="结束时间" width="150" />
    <el-table-column prop="score" label="成绩" width="110" />
    <el-table-column label="操作">
      <template v-slot="scope">
        <el-tooltip class="box-item" effect="dark" content="删除" placement="top">
          <el-button type="danger" :icon="Delete" circle @click="DeleteId(scope.row.contestId, scope.row.score)" />
        </el-tooltip>
        <el-tooltip class="box-item" effect="dark" content="立即考试" placement="top"
          v-if="scope.row.score == '' || scope.row.score == null">
          <el-button type="danger" :icon="Edit" circle @click="kaoshi(scope.row.contestId)" />
        </el-tooltip>
      </template>

    </el-table-column>
  </el-table>
</template>
<script>
import axios from 'axios';
import { ref } from 'vue';
import { Edit, Delete } from '@element-plus/icons-vue';
import { ElMessage } from 'element-plus';
import router from '@/router';
export default {
  data() {
    return {
      tableData: ref(''),
      user: JSON.parse(localStorage.getItem('usersinfo')), Edit, Delete,
    }
  },
  methods: {
    async DeleteId(contestId, score) {
      // 弹框询问用户是否删除数据
      const confirmResult = await this.$confirm('此操作将永久删除该竞赛', '提示', {
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
      if (score != null) {
        console.log(score)
        ElMessage({
          message: '竞赛已经结束，不能删除',
          type: 'error',
        })
      }
      else {
        axios.delete('api/admin/delusercontest', {
          params: {
            contestId: contestId
          }
        }).then(res => {
          if (res.data.code === 200) {
            this.$message.success('删除成功！')
            this.contestinfo()
          }
          else {
            this.$message.success('删除失败！')
            this.contestinfo()
          }
          this.loading = false
        })
      }
    },
    async kaoshi(contestId) {
      const confirmResult = await this.$confirm('你将考试，期间不能退出，诚信考试', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'error'
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消'
        })
      })

      if (confirmResult !== 'confirm') {
        return this.$message.info('已取消')
      }
      this.$router.push({
        name: 'exam',
        query: {
          contestId: contestId
        }
      })
    },
    contestinfo() {
      console.log(this.user.uid)
      if (this.user.roule == 3) {
        axios.get('/api/admin/usercontest', {
          params: {
            username: this.user.uid
          }
        }).then(res => {
          this.tableData = res.data
          this.consts = true
        })
      }
      else { this.consts = false }
    },
  },
  mounted() {
    this.contestinfo()
  }
}
</script>
