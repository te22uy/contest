<template>
  <div id="name" style="width:33%;height: 80vh;float: left;"></div>
  <div id="level" style="width:33%;height: 80vh;float: left;"></div>
  <div id="category" style="width:33%;height: 80vh;float: left;"></div>
  <div id="zhu" style="height: 90vh; clear: both;"></div>
</template>
<script>
import axios from 'axios';
import * as echarts from 'echarts';
export default {
  data() {
    return {
      myChart: null,
      text: '',
      alldata1: [],
      toutext: '',
    }

  },
  mounted() {
    this.data1();
    this.data2();
    this.data3();
    this.data4();
  },
  methods: {
    data1() {
      axios.get('/api/admin/contestlistname').then(res => {
        this.alldata1 = res.data
        var chartDom = document.getElementById('name');
        this.myChart = echarts.init(chartDom);
        this.text = '竞赛占比'
        this.toutext = '竞赛名称'
        this.bing();
      })
    },
    data2() {
      axios.get('/api/admin/contestlistlevel').then(res => {
        this.alldata1 = res.data
        var chartDom = document.getElementById('level');
        this.myChart = echarts.init(chartDom);
        this.text = '竞赛级别占比'
        this.toutext = '竞赛级别'
        this.bing();
      })
    },
    data3() {
      axios.get('/api/admin/contestlistcategory').then(res => {
        this.alldata1 = res.data
        var chartDom = document.getElementById('category');
        this.myChart = echarts.init(chartDom);
        this.text = '竞赛类别占比'
        this.toutext = '竞赛类别'
        this.bing();
      })
    },
    bing() {
      var option;
      option = {
        title: {
          text: this.text,
          left: 'center'
        },
        tooltip: {
          trigger: 'item',
          formatter: '{a} <br/>{b} : {c} ({d}%)'
        },
        legend: {
          type: 'scroll',
          orient: 'vertical',
          left: 20,
          top: 20,
          bottom: 20,
        },
        series: [
          {
            name: this.toutext,
            type: 'pie',
            radius: '50%',
            data: this.alldata1,
            emphasis: {
              itemStyle: {
                shadowBlur: 10,
                shadowOffsetX: 0,
                shadowColor: 'rgba(0, 0, 0, 0.5)'
              }
            }
          }
        ]
      };
      option && this.myChart.setOption(option);
    },
    data4() {
      axios.get('/api/admin/zhu').then(res => {
        this.alldata1 = res.data
        console.log(this.alldata1)
        var chartDom = document.getElementById('zhu');
        this.myChart = echarts.init(chartDom);
        const sellerName = this.alldata1.map((item) => {
          return item.name
        })
        const svg = this.alldata1.map((item) => {
          return item.avg
        })
        const min = this.alldata1.map((item) => {
          return item.min
        })
        const max = this.alldata1.map((item) => {
          return item.max
        })
        var option = {
          tooltip: {
            // 坐标轴触发
            trigger: 'axis',
            axisPointer: {
              // 鼠标移动到柱状图上，显示为交叉线，
              type: 'cross',
              label: {
                backgroundColor: '#6a7985'
              }
            }
          },
          legend: {
            data: ['最低分', '平均分', '最高分']
          },
          xAxis: {
            type: 'category',
            data: sellerName,
          },
          yAxis: {
            type: 'value'
          },
          series: [
            {
              name: '最低分',
              type: 'bar',
              data: min,
              itemStyle: {
                normal: {
                  label: {
                    show: true, //开启显示
                    formatter(params) {
                      return params.data.value
                    },
                    position: 'top', //在上方显示
                    textStyle: { //数值样式
                      color: '#ff0000',
                      fontSize: 12
                    }
                  }
                }
              }
            }, {
              name: '平均分',
              type: 'bar',
              data: svg, itemStyle: {
                normal: {
                  label: {
                    show: true, //开启显示
                    formatter(params) {
                      return params.data.value
                    },
                    position: 'top', //在上方显示
                    textStyle: { //数值样式
                      color: '#ff0000',
                      fontSize: 12
                    }
                  }
                }
              }
            },
            {
              name: '最高分',
              type: 'bar',
              data: max, itemStyle: {
                normal: {
                  label: {
                    show: true, //开启显示
                    formatter(params) {
                      return params.data.value
                    },
                    position: 'top', //在上方显示
                    textStyle: { //数值样式
                      color: '#ff0000',
                      fontSize: 12
                    }
                  }
                }
              }
            }
          ]
        }
        option && this.myChart.setOption(option);
      })
    }
  }
}
</script>
