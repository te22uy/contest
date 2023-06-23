<template>
  <div style="text-align: center;">
    <el-input v-model="input" placeholder="搜索" class="input-with-select" style="width: 300px;" clearable>
      <template #append>
        <el-button :icon="Search" @click="search()" />
      </template>
    </el-input>
  </div>
  <el-table :data="tables" v-loading.fullscreen.lock="loading" element-loading-text="加载中"
    element-loading-spinner="el-icon-loading" element-loading-background="rgba(0, 0, 0, 0.8)" height="500"
    style="width: 100%">
    <template #empty>
      <el-empty description="暂无数据" />
    </template>
    <el-table-column prop="NewsName" label="新闻名称" width="470" />
    <el-table-column prop="NewAuthor" label="作者" width="230" />
    <el-table-column prop="time" label="发布时间" width="260" />
    <el-table-column label="操作">
      <template v-slot="scope">
        <el-tooltip class="box-item" effect="dark" content="修改" placement="top">
          <el-button type="primary" :icon="Edit" circle @click="change(scope.row.id)" />
        </el-tooltip>
        <el-tooltip class="box-item" effect="dark" content="删除" placement="top">
          <el-button type="danger" :icon="Delete" circle @click="DeleteId(scope.row.id)" />
        </el-tooltip>
      </template>
    </el-table-column>
  </el-table>
</template>
<script>
import { Search, Edit, Delete, CircleClose, Refresh } from '@element-plus/icons-vue';
import { ref, reactive, } from 'vue';
import axios from 'axios';
import { ElMessage } from 'element-plus'
export default {
  data() {
    return {
      scope: ref(''),
      input: ref(''),
      Search, Edit, Delete, CircleClose, Refresh,
      listter: reactive({
        arr: []
      }),
    }
  },
  methods: {
    getUserList() {
      axios.get('api/user/newslist',).then(res => {
        this.listter.arr = res.data
        this.loading = false
        console.log(this.listter.arr)
      })

    },
    async DeleteId(id) {
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
      axios.delete('api/admin/newdelete', {
        params: {
          id: id
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
    change(id) {
      console.log(id)
      this.$router.push({
        name: 'ChangeNews',
        query: {
          id: id
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
