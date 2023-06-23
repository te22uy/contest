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
          <el-button type="primary" :icon="Edit" circle @click="change(scope.row.contestId), drawer = true" />
        </el-tooltip>
      </template>
    </el-table-column>
  </el-table>
  <el-drawer size="70%" v-model="drawer" :data="data" title="" :with-header="false">
    <div id="fen" style="width:36%;height: 80vh;float: left;"></div>
    <div id="qian" style="width:30%;height: 80vh;float: left;"></div>
    <div id="hou" style="width:33%;height: 80vh;float: left;"></div>
  </el-drawer>
</template>
<script>
import { Search, Edit, Delete, CircleClose, Refresh } from '@element-plus/icons-vue';
import { ref, reactive, } from 'vue';
import axios from 'axios';
import * as echarts from 'echarts';
import { ElMessage } from 'element-plus'
export default {
  data() {
    return {
      myChart: null,
      contestId: '',
      data: [],
      data1: '',
      scope: ref(''),
      input: ref(''),
      drawer: ref(false),
      Search, Edit, Delete, CircleClose, Refresh,
      listter: reactive({
        arr: []
      }),
    }
  },
  methods: {
    getUserList() {
      axios.get('api/admin/contest',).then(res => {
        this.listter.arr = res.data
        this.loading = false
        this.listter.arr.sort((a, b) => {
          return b.Enddate < a.Enddate ? -1 : 1
        })
      })
    },
    qian1() {
      axios.get('api/admin/qian', {
        params: {
          contestId: this.contestId
        }
      }).then(res => {
        this.data = res.data
        console.log(this.data)
        var chartDom = document.getElementById('qian');
        this.myChart = echarts.init(chartDom);
        const fen = this.data.map((item) => {
          return item.name
        })
        const num = this.data.map((item) => {
          return item.score
        })
        var option = {
          title: { // 标题设置
            text: '前三名', // 标题文字

            left: 50, // 标题距离左边的距离
            top: 10 // 标题距离顶部的距离
          },
          xAxis: {
            type: 'category',
            data: fen
          },
          yAxis: {
            type: 'value'
          },
          series: [
            {
              type: 'bar',
              data: num
            }
          ]
        }
        option && this.myChart.setOption(option);
      })
    },
    hou1() {
      axios.get('api/admin/hou', {
        params: {
          contestId: this.contestId
        }
      }).then(res => {
        this.data = res.data
        axios.get('api/admin/ping', {
          params: {
            contestId: this.contestId
          }
        }).then(res => {
          this.data1 = res.data[0].avg
          console.log(this.data)
          var chartDom = document.getElementById('hou');
          this.myChart = echarts.init(chartDom);
          this.data.push({ name: '平均分', score: this.data1 })
          const fen = this.data.map((item) => {
            return item.name
          })
          const num = this.data.map((item) => {
            return item.score
          })

          var option = {
            title: { // 标题设置
              text: '后三名', // 标题文字

              left: 50, // 标题距离左边的距离
              top: 10 // 标题距离顶部的距离
            },
            xAxis: {
              type: 'category',
              data: fen
            },
            yAxis: {
              type: 'value'
            },
            series: [
              {
                type: 'bar',
                data: num
              }
            ]
          }
          option && this.myChart.setOption(option);
        })

      })
    },
    fen1() {
      axios.get('/api/admin/count', {
        params: {
          contestId: this.contestId
        }
      }).then(res => {
        this.data = res.data
        var chartDom = document.getElementById('fen');
        this.myChart = echarts.init(chartDom);
        const fen = this.data.map((item) => {
          return item.score
        })
        const num = this.data.map((item) => {
          return item.num
        })
        var option = {
          title: { // 标题设置
            text: '分数区间', // 标题文字

            left: 50, // 标题距离左边的距离
            top: 10 // 标题距离顶部的距离
          },
          xAxis: {
            type: 'category',
            data: fen
          },
          yAxis: {
            type: 'value'
          },
          series: [
            {
              type: 'bar',
              data: num
            }
          ]
        }
        option && this.myChart.setOption(option);
      })
    },
    change(contestId) {
      this.contestId = contestId
      this.qian1()
      this.fen1()
      this.hou1()
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
